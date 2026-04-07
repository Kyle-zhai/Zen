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

// MARK: - Friend Request

struct FriendRequest: Codable, Identifiable, Sendable {
    let id: UUID
    let fromUserId: String
    let toUserId: String
    let status: Status
    let createdAt: Date?

    enum Status: String, Codable, Sendable {
        case pending
        case accepted
        case rejected
    }

    enum CodingKeys: String, CodingKey {
        case id, status
        case fromUserId = "from_user_id"
        case toUserId = "to_user_id"
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

// MARK: - Daily Fortune

struct Fortune: Codable, Identifiable {
    let id: String
    let category: String
    let should: String
    let shouldEN: String
    let shouldNot: String
    let shouldNotEN: String
    let luckyDecision: String
    let luckyDecisionEN: String
    let zenQuote: String
    let zenQuoteEN: String

    enum CodingKeys: String, CodingKey {
        case id, category
        case should, shouldNot = "should_not"
        case shouldEN = "should_en", shouldNotEN = "should_not_en"
        case luckyDecision = "lucky_decision", luckyDecisionEN = "lucky_decision_en"
        case zenQuote = "zen_quote", zenQuoteEN = "zen_quote_en"
    }
}

// MARK: - ZenType (AI Model Personality)

struct ZenType: Codable, Identifiable {
    let id: String
    let codeCN: String
    let codeEN: String
    let starCN: String
    let starEN: String
    let taglineCN: String
    let taglineEN: String
    let summaryCN: String
    let summaryEN: String
    let labelsCN: [String]
    let labelsEN: [String]
    let detailCN: String
    let detailEN: String

    enum CodingKeys: String, CodingKey {
        case id
        case codeCN = "code_cn", codeEN = "code_en"
        case starCN = "star_cn", starEN = "star_en"
        case taglineCN = "tagline_cn", taglineEN = "tagline_en"
        case summaryCN = "summary_cn", summaryEN = "summary_en"
        case labelsCN = "labels_cn", labelsEN = "labels_en"
        case detailCN = "detail_cn", detailEN = "detail_en"
    }
}

struct ZenTestQuestion: Codable, Identifiable {
    let id: Int
    let questionCN: String
    let questionEN: String
    let optionACN: String
    let optionAEN: String
    let optionBCN: String
    let optionBEN: String
    let optionCCN: String
    let optionCEN: String
    let optionAScores: [String: Int]
    let optionBScores: [String: Int]
    let optionCScores: [String: Int]

    enum CodingKeys: String, CodingKey {
        case id
        case questionCN = "question_cn", questionEN = "question_en"
        case optionACN = "option_a_cn", optionAEN = "option_a_en"
        case optionBCN = "option_b_cn", optionBEN = "option_b_en"
        case optionCCN = "option_c_cn", optionCEN = "option_c_en"
        case optionAScores = "option_a_scores"
        case optionBScores = "option_b_scores"
        case optionCScores = "option_c_scores"
    }
}

// MARK: - App Tab

enum AppTab: String, CaseIterable {
    case fortune
    case encourage
    case zenType
}
