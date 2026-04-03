import Foundation

// MARK: - Dimension Definition

struct Dimension: Identifiable, Codable {
    let id: String
    let category: String
    let emoji: String
    let title: String
    let titleEN: String
    let templates: [String]
    let templatesEN: [String]
}

// MARK: - Dimension Result

struct DimensionResult: Codable, Identifiable, Sendable {
    let id: UUID
    let dimensionId: String
    let dimensionTitle: String
    let emoji: String
    let content: String
}

// MARK: - Encouragement Result

struct EncouragementResult: Sendable {
    let wish: String
    let dimensions: [DimensionResult]
    let generatedAt: Date
    let isLLMGenerated: Bool
}

// MARK: - App Language

enum AppLanguage: String, CaseIterable, Codable {
    case english = "en"
    case chinese = "zh"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .chinese: return "中文"
        }
    }

    var isChinese: Bool { self == .chinese }
}

// MARK: - Subscription Status

enum SubscriptionStatus: String, Codable, Sendable {
    case free
    case monthly
    case yearly
}

// MARK: - Courage Record

struct CourageRecord: Codable, Identifiable, Sendable {
    let id: UUID
    var wish: String
    var dimensions: [DimensionResult]
    var isShared: Bool
    var isLLMGenerated: Bool
    var createdAt: Date?
}

// MARK: - Social: Courage Request

struct CourageRequest: Codable, Identifiable, Sendable {
    let id: UUID
    let type: RequestType
    let wish: String
    let aiSummary: String?
    let creatorUserId: String
    let maxResponses: Int
    let responseCount: Int
    let expiresAt: Date?
    let createdAt: Date?

    enum RequestType: String, Codable, Sendable {
        case encourage
        case witness
    }

    enum CodingKeys: String, CodingKey {
        case id, type, wish
        case aiSummary = "ai_summary"
        case creatorUserId = "creator_user_id"
        case maxResponses = "max_responses"
        case responseCount = "response_count"
        case expiresAt = "expires_at"
        case createdAt = "created_at"
    }
}

// MARK: - Social: Courage Response

struct CourageResponse: Codable, Identifiable, Sendable {
    let id: UUID
    let requestId: UUID
    let content: String
    let perspective: String?
    let emojiStamp: String?
    let voiceUrl: String?
    let isAnonymous: Bool
    let senderName: String?
    let senderUserId: String
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, content, perspective
        case requestId = "request_id"
        case emojiStamp = "emoji_stamp"
        case voiceUrl = "voice_url"
        case isAnonymous = "is_anonymous"
        case senderName = "sender_name"
        case senderUserId = "sender_user_id"
        case createdAt = "created_at"
    }
}

// MARK: - Social: Bond (Friend Connection)

struct Bond: Codable, Identifiable, Sendable {
    let id: UUID
    let userA: String
    let userB: String
    let resonanceCount: Int
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case userA = "user_a"
        case userB = "user_b"
        case resonanceCount = "resonance_count"
        case createdAt = "created_at"
    }

    /// Returns the friend's user ID given the current user's ID.
    func friendId(for currentUserId: String) -> String {
        userA == currentUserId ? userB : userA
    }
}

// MARK: - Social: Anonymous Encouragement

struct AnonymousEncouragement: Codable, Identifiable, Sendable {
    let id: UUID
    let senderUserId: String
    let receiverUserId: String
    let content: String
    let isRevealed: Bool
    let guessedCorrectly: Bool?
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, content
        case senderUserId = "sender_user_id"
        case receiverUserId = "receiver_user_id"
        case isRevealed = "is_revealed"
        case guessedCorrectly = "guessed_correctly"
        case createdAt = "created_at"
    }
}

// MARK: - Friend Display (for UI)

struct FriendDisplay: Identifiable {
    let id: UUID       // bond id
    let userId: String
    let nickname: String
    let avatarUrl: String?
    let resonanceCount: Int
}
