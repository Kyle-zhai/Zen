import Foundation

/// Sora-style invite code system.
///
/// Flow:
/// 1. User opens app → gets a unique invite code (6-char alphanumeric)
/// 2. User shares code to a friend
/// 3. Friend enters code → gets 30-day Pro + their own invite code
/// 4. Original user gets +7 days Pro
/// 5. Code expires in 7 days; once redeemed, a new code is generated
///
/// Data lives in Supabase `invite_codes` table.
/// Pro time is tracked locally via `freeProExpiry` in UserDefaults + iCloud sync.
@MainActor
@Observable
class InviteCodeManager {

    static let shared = InviteCodeManager()

    /// The user's current shareable invite code.
    private(set) var myCode: String?
    /// When the current code expires.
    private(set) var codeExpiresAt: Date?
    /// Whether the current code has been redeemed.
    private(set) var codeRedeemed: Bool = false
    /// How many people this user has successfully invited (lifetime).
    private(set) var totalInvites: Int = 0

    /// Free Pro expiry date (local + synced).
    var freeProExpiry: Date? {
        didSet {
            if let d = freeProExpiry {
                UserDefaults.standard.set(d, forKey: Self.freeProExpiryKey)
                CloudSyncManager.shared.set(d, forKey: Self.freeProExpiryKey)
            } else {
                UserDefaults.standard.removeObject(forKey: Self.freeProExpiryKey)
                CloudSyncManager.shared.set(nil as Date?, forKey: Self.freeProExpiryKey)
            }
        }
    }

    /// Whether the user currently has free Pro access.
    var hasFreePro: Bool {
        guard let expiry = freeProExpiry else { return false }
        return Date() < expiry
    }

    /// Remaining free Pro time as formatted string.
    var freeProRemainingText: String? {
        guard let expiry = freeProExpiry, Date() < expiry else { return nil }
        let remaining = expiry.timeIntervalSince(Date())
        let days = Int(remaining / 86400)
        if days > 0 { return "\(days)d" }
        let hours = Int(remaining / 3600)
        return "\(hours)h"
    }

    // MARK: - Keys

    private static let freeProExpiryKey = "inviteFreeProExpiry"
    private static let myCodeKey = "inviteMyCode"
    private static let codeExpiresAtKey = "inviteCodeExpiresAt"
    private static let totalInvitesKey = "inviteTotalInvites"
    private static let earlyBirdClaimedKey = "earlyBirdClaimed"

    private var supabaseUrl: String { Secrets.supabaseUrl }
    private var supabaseAnonKey: String { Secrets.supabaseAnonKey }

    // MARK: - Init

    private init() {
        // Load local state
        freeProExpiry = UserDefaults.standard.object(forKey: Self.freeProExpiryKey) as? Date
        myCode = UserDefaults.standard.string(forKey: Self.myCodeKey)
        codeExpiresAt = UserDefaults.standard.object(forKey: Self.codeExpiresAtKey) as? Date
        totalInvites = UserDefaults.standard.integer(forKey: Self.totalInvitesKey)

        // Check if code has expired
        if let exp = codeExpiresAt, Date() > exp {
            myCode = nil
            codeExpiresAt = nil
        }
    }

    // MARK: - Generate / Fetch My Code

    /// Ensure the user has an active invite code. Creates one if needed.
    func ensureCode(userId: String) async {
        // If we already have a valid local code, check if it's still active on server
        if let code = myCode, let exp = codeExpiresAt, Date() < exp {
            // Refresh from server to check if it was redeemed
            await refreshCodeStatus(code: code)
            return
        }

        // Need a new code — check server first, then create
        await fetchOrCreateCode(userId: userId)
    }

    private func fetchOrCreateCode(userId: String) async {
        // Check if server already has an active code for this user
        let query = "owner_id=eq.\(userId)&is_active=eq.true&order=created_at.desc&limit=1"
        guard let url = URL(string: "\(supabaseUrl)/rest/v1/invite_codes?\(query)") else { return }

        var request = URLRequest(url: url)
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let (data, response) = try? await URLSession.shared.data(for: request),
           let http = response as? HTTPURLResponse, http.statusCode == 200,
           let rows = try? JSONDecoder().decode([InviteCodeRow].self, from: data),
           let existing = rows.first {
            // Check if expired
            if let exp = ISO8601DateFormatter().date(from: existing.expiresAt), Date() < exp {
                saveCodeLocally(code: existing.code, expiresAt: exp)
                codeRedeemed = existing.redeemedBy != nil
                return
            }
            // Expired — deactivate and create new
            await deactivateCode(existing.code)
        }

        // Create a new code
        await createNewCode(userId: userId)
    }

    private func createNewCode(userId: String) async {
        let code = generateCode()
        let expiresAt = Date().addingTimeInterval(7 * 24 * 3600) // 7 days
        let isoFormatter = ISO8601DateFormatter()

        let body: [String: Any] = [
            "code": code,
            "owner_id": userId,
            "expires_at": isoFormatter.string(from: expiresAt),
            "is_active": true
        ]

        guard let url = URL(string: "\(supabaseUrl)/rest/v1/invite_codes") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=representation", forHTTPHeaderField: "Prefer")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        if let (_, response) = try? await URLSession.shared.data(for: request),
           let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) {
            saveCodeLocally(code: code, expiresAt: expiresAt)
            codeRedeemed = false
        }
    }

    // MARK: - Redeem Code

    enum RedeemResult {
        case success(daysGranted: Int)
        case alreadyRedeemed
        case expired
        case selfRedeem
        case notFound
        case alreadyHasFreePro
        case error(String)
    }

    /// Redeem someone else's invite code. Grants 30 days Pro to redeemer, +7 days to owner.
    func redeemCode(_ code: String, myUserId: String) async -> RedeemResult {
        let upperCode = code.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard upperCode.count >= 4 else { return .notFound }

        // Fetch the code from server
        let query = "code=eq.\(upperCode)&limit=1"
        guard let url = URL(string: "\(supabaseUrl)/rest/v1/invite_codes?\(query)") else {
            return .error("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")

        guard let (data, response) = try? await URLSession.shared.data(for: request),
              let http = response as? HTTPURLResponse, http.statusCode == 200,
              let rows = try? JSONDecoder().decode([InviteCodeRow].self, from: data),
              let row = rows.first else {
            return .notFound
        }

        // Validation
        if row.ownerId == myUserId { return .selfRedeem }
        if row.redeemedBy != nil { return .alreadyRedeemed }
        if !row.isActive { return .expired }
        if let exp = ISO8601DateFormatter().date(from: row.expiresAt), Date() > exp { return .expired }

        // Check if user already redeemed any code before
        if hasFreePro { return .alreadyHasFreePro }

        // Mark code as redeemed on server
        let isoNow = ISO8601DateFormatter().string(from: Date())
        let updateBody: [String: Any] = [
            "redeemed_by": myUserId,
            "redeemed_at": isoNow,
            "is_active": false
        ]

        guard let updateUrl = URL(string: "\(supabaseUrl)/rest/v1/invite_codes?code=eq.\(upperCode)") else {
            return .error("Update URL failed")
        }

        var updateRequest = URLRequest(url: updateUrl)
        updateRequest.httpMethod = "PATCH"
        updateRequest.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        updateRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        updateRequest.httpBody = try? JSONSerialization.data(withJSONObject: updateBody)

        guard let (_, updateResponse) = try? await URLSession.shared.data(for: updateRequest),
              let updateHttp = updateResponse as? HTTPURLResponse, (200...299).contains(updateHttp.statusCode) else {
            return .error("Server update failed")
        }

        // Grant 30 days to redeemer
        let newExpiry = Date().addingTimeInterval(30 * 24 * 3600)
        freeProExpiry = newExpiry

        // Grant +7 days to the code owner (via server-side record)
        await grantOwnerReward(ownerId: row.ownerId, days: 7)

        return .success(daysGranted: 30)
    }

    /// Grant the invite code owner extra Pro days.
    private func grantOwnerReward(ownerId: String, days: Int) async {
        let body: [String: Any] = [
            "user_id": ownerId,
            "days_granted": days,
            "granted_at": ISO8601DateFormatter().string(from: Date())
        ]

        guard let url = URL(string: "\(supabaseUrl)/rest/v1/invite_rewards") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        _ = try? await URLSession.shared.data(for: request)
    }

    /// Check if someone gave us reward days and apply them.
    func checkAndApplyRewards(userId: String) async {
        let query = "user_id=eq.\(userId)&applied=eq.false"
        guard let url = URL(string: "\(supabaseUrl)/rest/v1/invite_rewards?\(query)") else { return }

        var request = URLRequest(url: url)
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")

        guard let (data, response) = try? await URLSession.shared.data(for: request),
              let http = response as? HTTPURLResponse, http.statusCode == 200,
              let rows = try? JSONDecoder().decode([InviteRewardRow].self, from: data),
              !rows.isEmpty else { return }

        // Sum up all pending reward days
        let totalDays = rows.reduce(0) { $0 + $1.daysGranted }

        // Extend Pro time
        let base = freeProExpiry ?? Date()
        let newExpiry = base.addingTimeInterval(Double(totalDays) * 24 * 3600)
        freeProExpiry = newExpiry
        totalInvites += rows.count
        UserDefaults.standard.set(totalInvites, forKey: Self.totalInvitesKey)

        // Mark rewards as applied
        for row in rows {
            await markRewardApplied(rewardId: row.id)
        }

    }

    private func markRewardApplied(rewardId: Int) async {
        guard let url = URL(string: "\(supabaseUrl)/rest/v1/invite_rewards?id=eq.\(rewardId)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["applied": true])
        _ = try? await URLSession.shared.data(for: request)
    }

    // MARK: - Early Bird (first 100 users get 30 days free)

    /// Check if this user qualifies for early bird reward. First 100 users get 30 days free Pro.
    func checkEarlyBird(userId: String) async {
        // Already claimed or already has free Pro
        if UserDefaults.standard.bool(forKey: Self.earlyBirdClaimedKey) { return }
        if hasFreePro { return }

        // Check if user already in early_birds table
        let checkQuery = "user_id=eq.\(userId)&limit=1"
        guard let checkUrl = URL(string: "\(supabaseUrl)/rest/v1/early_birds?\(checkQuery)") else { return }
        var checkReq = URLRequest(url: checkUrl)
        checkReq.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")

        if let (data, resp) = try? await URLSession.shared.data(for: checkReq),
           let http = resp as? HTTPURLResponse, http.statusCode == 200,
           let rows = try? JSONDecoder().decode([[String: String]].self, from: data),
           !rows.isEmpty {
            // Already claimed on another device
            UserDefaults.standard.set(true, forKey: Self.earlyBirdClaimedKey)
            let newExpiry = Date().addingTimeInterval(30 * 24 * 3600)
            freeProExpiry = newExpiry
            return
        }

        // Count current early birds
        guard let countUrl = URL(string: "\(supabaseUrl)/rest/v1/early_birds?select=id") else { return }
        var countReq = URLRequest(url: countUrl)
        countReq.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        countReq.setValue("true", forHTTPHeaderField: "Prefer") // count=exact not needed, just count rows

        guard let (countData, countResp) = try? await URLSession.shared.data(for: countReq),
              let countHttp = countResp as? HTTPURLResponse, countHttp.statusCode == 200,
              let countRows = try? JSONDecoder().decode([[String: Int]].self, from: countData) else { return }

        guard countRows.count < 100 else {
            return
        }

        // Claim a spot
        let body: [String: Any] = [
            "user_id": userId,
            "claimed_at": ISO8601DateFormatter().string(from: Date())
        ]
        guard let claimUrl = URL(string: "\(supabaseUrl)/rest/v1/early_birds") else { return }
        var claimReq = URLRequest(url: claimUrl)
        claimReq.httpMethod = "POST"
        claimReq.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        claimReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
        claimReq.httpBody = try? JSONSerialization.data(withJSONObject: body)

        if let (_, claimResp) = try? await URLSession.shared.data(for: claimReq),
           let claimHttp = claimResp as? HTTPURLResponse, (200...299).contains(claimHttp.statusCode) {
            let newExpiry = Date().addingTimeInterval(30 * 24 * 3600)
            freeProExpiry = newExpiry
            UserDefaults.standard.set(true, forKey: Self.earlyBirdClaimedKey)
        }
    }

    // MARK: - Helpers

    private func refreshCodeStatus(code: String) async {
        let query = "code=eq.\(code)&limit=1"
        guard let url = URL(string: "\(supabaseUrl)/rest/v1/invite_codes?\(query)") else { return }
        var request = URLRequest(url: url)
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")

        if let (data, _) = try? await URLSession.shared.data(for: request),
           let rows = try? JSONDecoder().decode([InviteCodeRow].self, from: data),
           let row = rows.first {
            codeRedeemed = row.redeemedBy != nil
            if codeRedeemed {
                // Code was used — generate new one on next call
                myCode = nil
                codeExpiresAt = nil
                UserDefaults.standard.removeObject(forKey: Self.myCodeKey)
                UserDefaults.standard.removeObject(forKey: Self.codeExpiresAtKey)
            }
        }
    }

    private func deactivateCode(_ code: String) async {
        guard let url = URL(string: "\(supabaseUrl)/rest/v1/invite_codes?code=eq.\(code)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["is_active": false])
        _ = try? await URLSession.shared.data(for: request)
    }

    private func saveCodeLocally(code: String, expiresAt: Date) {
        myCode = code
        codeExpiresAt = expiresAt
        UserDefaults.standard.set(code, forKey: Self.myCodeKey)
        UserDefaults.standard.set(expiresAt, forKey: Self.codeExpiresAtKey)
    }

    /// Generate a 6-character alphanumeric code (uppercase, no ambiguous chars).
    private func generateCode() -> String {
        let chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789" // no I/O/0/1
        return String((0..<6).map { _ in chars.randomElement()! })
    }
}

// MARK: - Supabase Row Models

private struct InviteCodeRow: Codable {
    let id: Int?
    let code: String
    let ownerId: String
    let expiresAt: String
    let isActive: Bool
    let redeemedBy: String?
    let redeemedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, code
        case ownerId = "owner_id"
        case expiresAt = "expires_at"
        case isActive = "is_active"
        case redeemedBy = "redeemed_by"
        case redeemedAt = "redeemed_at"
    }
}

private struct InviteRewardRow: Codable {
    let id: Int
    let userId: String
    let daysGranted: Int
    let applied: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case daysGranted = "days_granted"
        case applied
    }
}
