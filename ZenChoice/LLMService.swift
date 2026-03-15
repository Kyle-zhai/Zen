import Foundation

/// Protocol for LLM-based encouragement generation (subscriber tier).
/// Implement with any model provider (Claude, GPT, DeepSeek, etc.).
protocol LLMProvider {
    func generate(
        wish: String,
        dimensions: [String],
        tone: String
    ) async throws -> [DimensionResult]
}

/// Placeholder implementation that falls back to local templates.
/// Replace with actual API integration when ready.
struct PlaceholderLLMProvider: LLMProvider {
    func generate(
        wish: String,
        dimensions: [String],
        tone: String
    ) async throws -> [DimensionResult] {
        // Fallback: use local engine with specified dimensions
        let result = EncouragementEngine.generate(
            wish: wish,
            dimensionCount: dimensions.count,
            specificDimensionIds: dimensions.isEmpty ? nil : dimensions
        )
        return result.dimensions
    }
}
