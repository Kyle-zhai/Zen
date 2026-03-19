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
