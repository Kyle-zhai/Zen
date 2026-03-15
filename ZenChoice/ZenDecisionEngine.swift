import Foundation

enum EncouragementEngine {

    /// Generate encouragement from local templates (free tier).
    static func generate(
        wish: String,
        dimensionCount: Int = 4,
        specificDimensionIds: [String]? = nil
    ) -> EncouragementResult {
        let dimensions: [Dimension]
        if let ids = specificDimensionIds {
            dimensions = DimensionPool.dimensions(for: ids)
        } else {
            dimensions = DimensionPool.randomSubset(count: dimensionCount)
        }

        let isChineseLocale = Locale.current.language.languageCode?.identifier == "zh"
        let results = dimensions.map { dim -> DimensionResult in
            let pool = isChineseLocale ? dim.templates : dim.templatesEN
            let template = pool.randomElement() ?? "{wish}"
            let content = template.replacingOccurrences(of: "{wish}", with: wish)
            return DimensionResult(
                id: UUID(),
                dimensionId: dim.id,
                dimensionTitle: isChineseLocale ? dim.title : dim.titleEN,
                emoji: dim.emoji,
                content: content
            )
        }

        return EncouragementResult(
            wish: wish,
            dimensions: results,
            generatedAt: Date(),
            isLLMGenerated: false
        )
    }
}
