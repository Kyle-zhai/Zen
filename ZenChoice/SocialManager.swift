import Foundation

@MainActor
@Observable
class SocialManager {

    // MARK: - Config (fill in after creating Supabase project)
    private let supabaseUrl = ""  // fill in your Supabase project URL
    private let supabaseAnonKey = ""  // fill in your Supabase anon key

    // MARK: - Auth Reference

    var authManager: AuthManager?

    private var userId: String? { authManager?.userId }
    private var authHeaders: [String: String] {
        authManager?.authHeaders ?? ["apikey": supabaseAnonKey]
    }

    // MARK: - Inbox State

    var requests: [CourageRequest] = []
    var unreadCount: Int = 0

    // MARK: - Bond State

    var bonds: [Bond] = []
    var friendProfiles: [String: UserProfile] = [:]  // userId -> profile

    var friendDisplayList: [FriendDisplay] {
        guard let myId = userId else { return [] }
        return bonds.compactMap { bond in
            let friendId = bond.friendId(for: myId)
            let profile = friendProfiles[friendId]
            return FriendDisplay(
                id: bond.id,
                userId: friendId,
                nickname: profile?.nickname ?? "???",
                avatarUrl: profile?.avatarUrl,
                resonanceCount: bond.resonanceCount
            )
        }
    }

    // MARK: - Anonymous Encouragement State

    var pendingEncouragements: [AnonymousEncouragement] = []

    // MARK: - Create Request

    func createRequest(type: CourageRequest.RequestType, wish: String, aiSummary: String?, maxResponses: Int) async throws -> CourageRequest {
        guard let userId else { throw SocialError.notConfigured }

        let body: [String: Any] = [
            "type": type.rawValue,
            "wish": wish,
            "ai_summary": aiSummary as Any,
            "creator_user_id": userId,
            "max_responses": maxResponses
        ]

        let data = try await postJSON(path: "/rest/v1/courage_requests", body: body, returnRows: true)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let rows = try decoder.decode([CourageRequest].self, from: data)
        guard let request = rows.first else {
            throw SocialError.invalidResponse
        }
        return request
    }

    // MARK: - Submit Response

    func submitResponse(requestId: UUID, content: String, perspective: String?, emojiStamp: String?, voiceUrl: String?, isAnonymous: Bool, senderName: String?) async throws {
        guard let userId else { throw SocialError.notConfigured }

        let body: [String: Any] = [
            "request_id": requestId.uuidString,
            "content": content,
            "perspective": perspective as Any,
            "emoji_stamp": emojiStamp as Any,
            "voice_url": voiceUrl as Any,
            "is_anonymous": isAnonymous,
            "sender_name": senderName as Any,
            "sender_user_id": userId
        ]

        _ = try await postJSON(path: "/rest/v1/courage_responses", body: body, returnRows: false)
    }

    // MARK: - Fetch Request by ID

    func fetchRequest(id: UUID) async throws -> CourageRequest {
        let data = try await getJSON(path: "/rest/v1/courage_requests?id=eq.\(id.uuidString)&select=*")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let rows = try decoder.decode([CourageRequest].self, from: data)
        guard let request = rows.first else {
            throw SocialError.notFound
        }
        return request
    }

    // MARK: - Fetch Responses for a Request

    func fetchResponses(requestId: UUID) async throws -> [CourageResponse] {
        let data = try await getJSON(path: "/rest/v1/courage_responses?request_id=eq.\(requestId.uuidString)&select=*&order=created_at.asc")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([CourageResponse].self, from: data)
    }

    // MARK: - Fetch My Requests (Inbox)

    func fetchMyRequests() async throws {
        guard let userId else { return }
        let data = try await getJSON(path: "/rest/v1/courage_requests?creator_user_id=eq.\(userId)&select=*&order=created_at.desc&limit=50")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        requests = try decoder.decode([CourageRequest].self, from: data)
    }

    // MARK: - Upload Voice

    func uploadVoice(requestId: UUID, responseId: UUID, fileData: Data) async throws -> String {
        let path = "voices/\(requestId.uuidString)/\(responseId.uuidString).m4a"
        let url = URL(string: "\(supabaseUrl)/storage/v1/object/voice-messages/\(path)")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        for (key, value) in authHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.setValue("audio/mp4", forHTTPHeaderField: "Content-Type")
        request.httpBody = fileData
        request.timeoutInterval = 30

        let (_, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw SocialError.uploadFailed
        }

        return "\(supabaseUrl)/storage/v1/object/public/voice-messages/\(path)"
    }

    // MARK: - Share Link

    func shareLink(for request: CourageRequest) -> URL {
        let page = request.type == .encourage ? "encourage" : "witness"
        return URL(string: "https://kyle-zhai.github.io/Zen/\(page).html?id=\(request.id.uuidString)")!
    }

    // MARK: - Bond Management

    func createBond(friendUserId: String) async throws {
        guard let userId else { throw SocialError.notConfigured }

        // Ensure consistent ordering (userA < userB) to prevent duplicates
        let (a, b) = userId < friendUserId ? (userId, friendUserId) : (friendUserId, userId)

        let body: [String: Any] = [
            "user_a": a,
            "user_b": b
        ]

        _ = try await postJSON(path: "/rest/v1/bonds", body: body, returnRows: false)
        try await fetchBonds()
    }

    func fetchBonds() async throws {
        guard let userId else { return }

        let data = try await getJSON(path: "/rest/v1/bonds?or=(user_a.eq.\(userId),user_b.eq.\(userId))&select=*&order=created_at.desc")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        bonds = try decoder.decode([Bond].self, from: data)

        // Fetch friend profiles
        let friendIds = bonds.map { $0.friendId(for: userId) }
        for fid in friendIds where friendProfiles[fid] == nil {
            if let profile = try? await fetchProfile(userId: fid) {
                friendProfiles[fid] = profile
            }
        }
    }

    private func fetchProfile(userId: String) async throws -> UserProfile? {
        let data = try await getJSON(path: "/rest/v1/profiles?id=eq.\(userId)&select=*")
        let rows = try JSONDecoder().decode([UserProfile].self, from: data)
        return rows.first
    }

    /// Generate a bond invite link containing the current user's ID.
    func bondInviteLink() -> URL? {
        guard let userId else { return nil }
        return URL(string: "https://kyle-zhai.github.io/Zen/bond.html?from=\(userId)")
    }

    // MARK: - Anonymous Encouragement

    func sendAnonymousEncouragement(to receiverUserId: String, content: String) async throws {
        guard let userId else { throw SocialError.notConfigured }

        let body: [String: Any] = [
            "sender_user_id": userId,
            "receiver_user_id": receiverUserId,
            "content": content
        ]

        _ = try await postJSON(path: "/rest/v1/anonymous_encouragements", body: body, returnRows: false)
    }

    func fetchPendingEncouragements() async throws {
        guard let userId else { return }

        let data = try await getJSON(path: "/rest/v1/anonymous_encouragements?receiver_user_id=eq.\(userId)&is_revealed=eq.false&select=*&order=created_at.desc&limit=1")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        pendingEncouragements = try decoder.decode([AnonymousEncouragement].self, from: data)
    }

    func guessEncourager(encouragementId: UUID, guessedUserId: String) async throws -> Bool {
        guard let userId else { throw SocialError.notConfigured }

        // Fetch the encouragement to check the sender
        let data = try await getJSON(path: "/rest/v1/anonymous_encouragements?id=eq.\(encouragementId.uuidString)&select=*")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let rows = try decoder.decode([AnonymousEncouragement].self, from: data)
        guard let encouragement = rows.first else { throw SocialError.notFound }

        let correct = encouragement.senderUserId == guessedUserId

        // Mark as revealed
        try await patchJSON(path: "/rest/v1/anonymous_encouragements?id=eq.\(encouragementId.uuidString)", body: [
            "is_revealed": true,
            "guessed_correctly": correct
        ])

        // If correct, increment resonance_count for both users' bond
        if correct {
            let (a, b) = userId < encouragement.senderUserId
                ? (userId, encouragement.senderUserId)
                : (encouragement.senderUserId, userId)

            // Use RPC to atomically increment
            _ = try? await postJSON(path: "/rest/v1/rpc/increment_resonance", body: [
                "a_id": a,
                "b_id": b
            ], returnRows: false)

            try await fetchBonds()
        }

        return correct
    }

    // MARK: - Private: HTTP Helpers

    private func getJSON(path: String) async throws -> Data {
        guard !supabaseUrl.isEmpty else { throw SocialError.notConfigured }

        let url = URL(string: "\(supabaseUrl)\(path)")!
        var request = URLRequest(url: url)
        for (key, value) in authHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.timeoutInterval = 15

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw SocialError.networkError("GET failed: \(path)")
        }
        return data
    }

    private func postJSON(path: String, body: [String: Any], returnRows: Bool) async throws -> Data {
        guard !supabaseUrl.isEmpty else { throw SocialError.notConfigured }

        let url = URL(string: "\(supabaseUrl)\(path)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        for (key, value) in authHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if returnRows {
            request.setValue("return=representation", forHTTPHeaderField: "Prefer")
        }
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.timeoutInterval = 15

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let errorBody = String(data: data, encoding: .utf8) ?? "unknown"
            throw SocialError.networkError("POST failed: \(errorBody)")
        }
        return data
    }

    private func patchJSON(path: String, body: [String: Any]) async throws {
        guard !supabaseUrl.isEmpty else { throw SocialError.notConfigured }

        let url = URL(string: "\(supabaseUrl)\(path)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        for (key, value) in authHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.timeoutInterval = 15

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let errorBody = String(data: data, encoding: .utf8) ?? "unknown"
            throw SocialError.networkError("PATCH failed: \(errorBody)")
        }
        _ = data
    }

    // MARK: - Errors

    enum SocialError: Error, LocalizedError {
        case notConfigured
        case networkError(String)
        case invalidResponse
        case notFound
        case uploadFailed

        var errorDescription: String? {
            switch self {
            case .notConfigured: return "Social features not configured"
            case .networkError(let msg): return "Network error: \(msg)"
            case .invalidResponse: return "Invalid server response"
            case .notFound: return "Request not found"
            case .uploadFailed: return "Voice upload failed"
            }
        }
    }
}
