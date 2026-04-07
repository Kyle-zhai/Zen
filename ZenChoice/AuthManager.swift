import Foundation
import AuthenticationServices

@MainActor
@Observable
class AuthManager {

    // MARK: - Config
    private let supabaseUrl: String
    private let supabaseAnonKey: String

    // MARK: - State
    var isLoggedIn: Bool = false
    var userId: String?
    var accessToken: String?
    var profile: UserProfile?
    var needsProfileSetup: Bool = false

    // MARK: - Keychain Keys
    private static let accessTokenKey = "supabase_access_token"
    private static let refreshTokenKey = "supabase_refresh_token"
    private static let userIdKey = "supabase_user_id"

    init(supabaseUrl: String = Secrets.supabaseUrl, supabaseAnonKey: String = Secrets.supabaseAnonKey) {
        self.supabaseUrl = supabaseUrl
        self.supabaseAnonKey = supabaseAnonKey
        loadSession()
    }

    // MARK: - Session Persistence (UserDefaults for simplicity; migrate to Keychain for production)

    private func loadSession() {
        // Anonymous mode — always "logged in" with a device-based UUID
        if UserDefaults.standard.string(forKey: Self.userIdKey) == nil {
            UserDefaults.standard.set(UUID().uuidString, forKey: Self.userIdKey)
        }
        userId = UserDefaults.standard.string(forKey: Self.userIdKey)
        accessToken = UserDefaults.standard.string(forKey: Self.accessTokenKey)
        isLoggedIn = true
        needsProfileSetup = false
    }

    private func saveSession(accessToken: String, refreshToken: String, userId: String) {
        self.accessToken = accessToken
        self.userId = userId
        self.isLoggedIn = true
        UserDefaults.standard.set(accessToken, forKey: Self.accessTokenKey)
        UserDefaults.standard.set(refreshToken, forKey: Self.refreshTokenKey)
        UserDefaults.standard.set(userId, forKey: Self.userIdKey)
    }

    func signOut() {
        accessToken = nil
        userId = nil
        profile = nil
        isLoggedIn = false
        needsProfileSetup = false
        UserDefaults.standard.removeObject(forKey: Self.accessTokenKey)
        UserDefaults.standard.removeObject(forKey: Self.refreshTokenKey)
        UserDefaults.standard.removeObject(forKey: Self.userIdKey)
    }

    // MARK: - Sign in with Apple

    func signInWithApple(idToken: String, nonce: String) async throws {
        guard !supabaseUrl.isEmpty else { throw AuthError.notConfigured }

        let body: [String: Any] = [
            "provider": "apple",
            "id_token": idToken,
            "nonce": nonce
        ]

        let url = URL(string: "\(supabaseUrl)/auth/v1/token?grant_type=id_token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.timeoutInterval = 15

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let errorBody = String(data: data, encoding: .utf8) ?? "unknown"
            throw AuthError.signInFailed("Apple sign in failed: \(errorBody)")
        }

        try parseAuthResponse(data)
    }

    // MARK: - Email OTP

    func sendOTP(email: String) async throws {
        guard !supabaseUrl.isEmpty else { throw AuthError.notConfigured }

        let body: [String: Any] = ["email": email]

        let url = URL(string: "\(supabaseUrl)/auth/v1/otp")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.timeoutInterval = 15

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let errorBody = String(data: data, encoding: .utf8) ?? "unknown"
            throw AuthError.signInFailed("Send OTP failed: \(errorBody)")
        }
        _ = data
    }

    func verifyOTP(email: String, code: String) async throws {
        guard !supabaseUrl.isEmpty else { throw AuthError.notConfigured }

        let body: [String: Any] = [
            "email": email,
            "token": code,
            "type": "email"
        ]

        let url = URL(string: "\(supabaseUrl)/auth/v1/verify")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.timeoutInterval = 15

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let errorBody = String(data: data, encoding: .utf8) ?? "unknown"
            throw AuthError.signInFailed("Verify failed: \(errorBody)")
        }

        try parseAuthResponse(data)
    }

    // MARK: - Profile

    func checkProfileExists() async {
        guard let userId, let accessToken, !supabaseUrl.isEmpty else { return }
        // Skip for test mode
        guard accessToken != "test-token" else {
            if profile == nil {
                profile = UserProfile(id: userId, nickname: "测试用户", accountId: "test123", avatarUrl: nil)
            }
            needsProfileSetup = false
            return
        }

        let url = URL(string: "\(supabaseUrl)/rest/v1/profiles?id=eq.\(userId)&select=*")!
        var request = URLRequest(url: url)
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        if let (data, _) = try? await URLSession.shared.data(for: request),
           let rows = try? JSONDecoder().decode([UserProfile].self, from: data),
           let existing = rows.first {
            profile = existing
            needsProfileSetup = false
        } else {
            needsProfileSetup = true
        }
    }

    func createProfile(nickname: String, accountId: String, avatarUrl: String?) async throws {
        guard let userId, let accessToken, !supabaseUrl.isEmpty else { throw AuthError.notConfigured }

        var body: [String: Any] = [
            "id": userId,
            "nickname": nickname,
            "account_id": accountId
        ]
        if let avatarUrl { body["avatar_url"] = avatarUrl }

        let url = URL(string: "\(supabaseUrl)/rest/v1/profiles")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=representation", forHTTPHeaderField: "Prefer")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw AuthError.signInFailed("Failed to create profile")
        }

        if let rows = try? JSONDecoder().decode([UserProfile].self, from: data),
           let created = rows.first {
            profile = created
            needsProfileSetup = false
        }
    }

    // MARK: - Update Profile

    private static let lastNicknameChangeDateKey = "lastNicknameChangeDate"

    var lastNicknameChangeDate: Date? {
        UserDefaults.standard.object(forKey: Self.lastNicknameChangeDateKey) as? Date
    }

    var canChangeNickname: Bool {
        guard let last = lastNicknameChangeDate else { return true }
        return Date().timeIntervalSince(last) > 30 * 24 * 3600
    }

    var daysUntilNicknameChange: Int {
        guard let last = lastNicknameChangeDate else { return 0 }
        let elapsed = Date().timeIntervalSince(last)
        let remaining = (30 * 24 * 3600) - elapsed
        return max(0, Int(ceil(remaining / 86400)))
    }

    func updateProfile(nickname: String?, avatarUrl: String?) async throws {
        guard let userId, let accessToken, !supabaseUrl.isEmpty else { throw AuthError.notConfigured }

        var body: [String: Any] = [:]
        if let nickname { body["nickname"] = nickname }
        if let avatarUrl { body["avatar_url"] = avatarUrl }
        guard !body.isEmpty else { return }

        let url = URL(string: "\(supabaseUrl)/rest/v1/profiles?id=eq.\(userId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=representation", forHTTPHeaderField: "Prefer")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let errorBody = String(data: data, encoding: .utf8) ?? "unknown"
            throw AuthError.signInFailed("Update failed: \(errorBody)")
        }

        if let rows = try? JSONDecoder().decode([UserProfile].self, from: data),
           let updated = rows.first {
            profile = updated
        }

        if nickname != nil {
            UserDefaults.standard.set(Date(), forKey: Self.lastNicknameChangeDateKey)
        }
    }

    // MARK: - Token Refresh

    /// Refresh the access token using the stored refresh token.
    /// Call this on app launch and when a 401 is received.
    func refreshSessionIfNeeded() async {
        guard let refreshToken = UserDefaults.standard.string(forKey: Self.refreshTokenKey),
              !supabaseUrl.isEmpty,
              accessToken != "test-token" else { return }

        let body: [String: Any] = ["refresh_token": refreshToken]

        guard let url = URL(string: "\(supabaseUrl)/auth/v1/token?grant_type=refresh_token") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.timeoutInterval = 15

        guard let (data, response) = try? await URLSession.shared.data(for: request),
              let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            #if DEBUG
            print("[AuthManager] Token refresh failed — user may need to re-login")
            #endif
            // Token is dead, force re-login
            signOut()
            return
        }

        do {
            try parseAuthResponse(data)
            #if DEBUG
            print("[AuthManager] Token refreshed successfully")
            #endif
        } catch {
            signOut()
        }
    }

    // MARK: - Auth Header (for other managers to use)

    var authHeaders: [String: String] {
        var headers: [String: String] = ["apikey": supabaseAnonKey]
        if let token = accessToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }

    // MARK: - Helpers

    private func parseAuthResponse(_ data: Data) throws {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let token = json["access_token"] as? String,
              let refresh = json["refresh_token"] as? String,
              let user = json["user"] as? [String: Any],
              let uid = user["id"] as? String else {
            throw AuthError.signInFailed("Invalid auth response")
        }

        saveSession(accessToken: token, refreshToken: refresh, userId: uid)

        Task {
            await checkProfileExists()
        }
    }

    // MARK: - Test Bypass

    func testBypass() {
        let testId = "test-user-\(UUID().uuidString.prefix(8))"
        saveSession(accessToken: "test-token", refreshToken: "test-refresh", userId: testId)
        profile = UserProfile(id: testId, nickname: "测试用户", accountId: "test123", avatarUrl: nil)
        needsProfileSetup = false
    }

    // MARK: - Errors

    enum AuthError: Error, LocalizedError {
        case notConfigured
        case signInFailed(String)

        var errorDescription: String? {
            switch self {
            case .notConfigured: return "Auth not configured"
            case .signInFailed(let msg): return msg
            }
        }
    }
}

// MARK: - User Profile Model

struct UserProfile: Codable, Sendable {
    let id: String
    let nickname: String
    let accountId: String?
    let avatarUrl: String?

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case accountId = "account_id"
        case avatarUrl = "avatar_url"
    }
}
