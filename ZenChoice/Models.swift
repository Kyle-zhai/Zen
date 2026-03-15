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

// MARK: - Subscription Status

enum SubscriptionStatus: String, Codable, Sendable {
    case free
    case monthly
    case yearly
}

// MARK: - User Profile

struct UserProfile: Codable, Identifiable, Sendable {
    let id: UUID
    var name: String
    var subscriptionStatus: SubscriptionStatus
    var createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, name
        case subscriptionStatus = "subscription_status"
        case createdAt = "created_at"
    }
}

// MARK: - Courage Record

struct CourageRecord: Codable, Identifiable, Sendable {
    let id: UUID
    var userId: UUID
    var wish: String
    var dimensions: [DimensionResult]
    var isShared: Bool
    var isLLMGenerated: Bool
    var createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, wish, dimensions
        case userId = "user_id"
        case isShared = "is_shared"
        case isLLMGenerated = "is_llm_generated"
        case createdAt = "created_at"
    }
}
