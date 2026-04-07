import Foundation

enum EncouragementEngine {

    /// Generate encouragement from local templates (free tier).
    static func generate(
        wish: String,
        dimensionCount: Int = 4,
        pinnedDimensionId: String? = nil,
        language: AppLanguage = .english
    ) -> EncouragementResult {
        var dimensions: [Dimension]
        if let pinned = pinnedDimensionId,
           let pinnedDim = DimensionPool.all.first(where: { $0.id == pinned }) {
            // Subscriber: pinned dimension first, then fill with random others
            let others = DimensionPool.all
                .filter { $0.id != pinned }
                .shuffled()
                .prefix(dimensionCount - 1)
            dimensions = [pinnedDim] + others
        } else {
            dimensions = DimensionPool.randomSubset(count: dimensionCount)
        }

        let useChinese = language.isChinese
        let coreAction = extractCoreAction(from: wish, isChinese: useChinese)
        let results = dimensions.map { dim -> DimensionResult in
            let pool = useChinese ? dim.templates : dim.templatesEN
            let template = pool.randomElement() ?? "{wish}"
            let content = template.replacingOccurrences(of: "{wish}", with: coreAction)
            return DimensionResult(
                id: UUID(),
                dimensionId: dim.id,
                dimensionTitle: useChinese ? dim.title : dim.titleEN,
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

    // MARK: - Extract Core Action

    /// Strips common question wrappers from user input, leaving only the core action verb/phrase.
    /// e.g. "我今天适合表白吗" → "表白", "Should I ask her out today" → "ask her out"
    static func extractCoreAction(from input: String, isChinese: Bool) -> String {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if isChinese {
            return extractChineseAction(from: trimmed)
        } else {
            return extractEnglishAction(from: trimmed)
        }
    }

    private static func extractChineseAction(from input: String) -> String {
        var s = input

        // Remove trailing punctuation: ？?！!。.
        while let last = s.last, "？?！!。.…".contains(last) {
            s.removeLast()
        }

        // Phase 0: Strip hesitation/uncertainty wrappers
        // e.g. "我在犹豫要不要辞职" → "辞职", "我不知道该不该跟他道歉" → "跟他道歉"
        let hesitationPrefixes: [String] = [
            "我在犹豫要不要去", "我在犹豫要不要", "我在犹豫该不该去", "我在犹豫该不该",
            "我在犹豫能不能", "我在犹豫是不是该", "我在犹豫",
            "我犹豫要不要去", "我犹豫要不要", "我犹豫该不该去", "我犹豫该不该", "我犹豫",
            "在犹豫要不要去", "在犹豫要不要", "在犹豫该不该", "在犹豫",
            "犹豫要不要去", "犹豫要不要", "犹豫该不该", "犹豫",
            "我不知道该不该去", "我不知道该不该", "我不知道要不要去", "我不知道要不要",
            "我不知道能不能", "我不知道是不是该", "我不知道",
            "不知道该不该", "不知道要不要", "不知道",
            "我纠结要不要去", "我纠结要不要", "我纠结该不该", "我纠结",
            "纠结要不要", "纠结该不该", "纠结",
            "我拿不定主意要不要", "我拿不定主意",
            "拿不定主意要不要", "拿不定主意",
            "我很矛盾要不要", "我很矛盾",
        ]
        for prefix in hesitationPrefixes {
            if s.hasPrefix(prefix) && s.count > prefix.count {
                s = String(s.dropFirst(prefix.count))
                break
            }
        }

        // Phase 1: Strip leading time expressions so "今天我想表白" and
        // "明天我想辞职" both reduce to "我想X" before prefix matching.
        let timeWords = [
            "今天晚上", "今天下午", "今天上午", "今天早上",
            "明天晚上", "明天下午", "明天上午", "明天早上",
            "后天", "今天", "明天", "这周末", "这周", "下周",
            "下个月", "这个月", "最近", "现在", "待会儿", "待会",
            "等一下", "马上",
        ]
        for tw in timeWords {
            if s.hasPrefix(tw) && s.count > tw.count {
                s = String(s.dropFirst(tw.count))
                break
            }
        }

        // Phase 2: Strip intent/modal prefixes
        let prefixes: [String] = [
            "我适不适合", "我适合去", "我适合",
            "适不适合", "适合去", "适合",
            "我想不想", "我想去", "我想要去", "我想要", "我想",
            "我要不要去", "我要不要", "我要去", "我要",
            "我能不能", "我能去", "我能",
            "我应不应该", "我应该去", "我应该",
            "我可不可以", "我可以去", "我可以",
            "我该不该去", "我该不该", "我该去", "我该",
            "我觉得我应该", "我觉得我要", "我觉得我想",
            "我打算去", "我打算", "我准备去", "我准备",
            "我决定去", "我决定",
            "要不要去", "要不要", "能不能去", "能不能",
            "应不应该", "应该去", "应该",
            "可不可以", "可以去", "可以",
            "该不该", "该去", "该",
            "想去", "想", "去",
        ]

        let suffixes: [String] = [
            "好不好", "好吗", "行不行", "行吗",
            "可以吗", "可以不", "对不对", "对吗",
            "呢", "吗", "嘛", "啊", "呀", "吧",
        ]

        for prefix in prefixes {
            if s.hasPrefix(prefix) && s.count > prefix.count {
                s = String(s.dropFirst(prefix.count))
                break
            }
        }

        for suffix in suffixes {
            if s.hasSuffix(suffix) && s.count > suffix.count {
                s = String(s.dropLast(suffix.count))
                break
            }
        }

        let result = s.trimmingCharacters(in: .whitespacesAndNewlines)
        return result.isEmpty ? input : result
    }

    private static func extractEnglishAction(from input: String) -> String {
        var s = input

        // Remove trailing punctuation
        while let last = s.last, "?!.".contains(last) {
            s.removeLast()
        }
        s = s.trimmingCharacters(in: .whitespaces)

        // Strip leading time expressions (case-insensitive)
        let lowerTrim = s.lowercased()
        let enTimeWords = [
            "today i ", "tomorrow i ", "tonight i ",
            "this week i ", "this weekend i ", "next week i ",
        ]
        for tw in enTimeWords {
            if lowerTrim.hasPrefix(tw) && s.count > tw.count {
                s = String(s.dropFirst(tw.count))
                // Re-capitalize first letter
                s = s.prefix(1).uppercased() + s.dropFirst()
                break
            }
        }

        // Lowercase for matching, but preserve original casing in result
        let lower = s.lowercased()

        let prefixes: [(pattern: String, keepRest: Bool)] = [
            // Hesitation / uncertainty
            ("i'm hesitating about whether to ", true),
            ("i'm hesitating about whether i should ", true),
            ("i'm hesitating about ", true),
            ("i'm hesitating whether to ", true),
            ("i'm hesitating to ", true),
            ("i hesitate to ", true),
            ("hesitating about whether to ", true),
            ("hesitating about ", true),
            ("hesitating whether to ", true),
            ("i don't know if i should ", true),
            ("i don't know whether to ", true),
            ("i don't know whether i should ", true),
            ("don't know if i should ", true),
            ("don't know whether to ", true),
            ("i'm not sure if i should ", true),
            ("i'm not sure whether to ", true),
            ("i'm not sure about ", true),
            ("not sure if i should ", true),
            ("not sure whether to ", true),
            ("i can't decide if i should ", true),
            ("i can't decide whether to ", true),
            ("can't decide if i should ", true),
            ("can't decide whether to ", true),
            ("i'm torn about whether to ", true),
            ("i'm torn about ", true),
            ("unsure if i should ", true),
            ("unsure whether to ", true),
            // Intent / modal
            ("should i go ", true),
            ("should i try to ", true),
            ("should i try ", true),
            ("should i go and ", true),
            ("should i ", true),
            ("is it a good day to ", true),
            ("is it a good idea to ", true),
            ("is today a good day to ", true),
            ("is it okay to ", true),
            ("is it ok to ", true),
            ("can i go ", true),
            ("can i go and ", true),
            ("can i ", true),
            ("do i dare to ", true),
            ("do i dare ", true),
            ("do you think i should ", true),
            ("i'm thinking about ", true),
            ("i'm thinking of ", true),
            ("i am thinking about ", true),
            ("i am thinking of ", true),
            ("i want to go ", true),
            ("i want to go and ", true),
            ("i want to ", true),
            ("i wanna ", true),
            ("i'd like to ", true),
            ("i would like to ", true),
            ("i'm going to ", true),
            ("i plan to ", true),
            ("i need to ", true),
            ("i'm considering ", true),
            ("i'm debating whether to ", true),
            ("thinking about ", true),
            ("thinking of ", true),
        ]

        let suffixes: [String] = [
            " today", " right now", " now",
            " or not", " or should i not",
        ]

        for (pattern, _) in prefixes {
            if lower.hasPrefix(pattern) && s.count > pattern.count {
                s = String(s.dropFirst(pattern.count))
                break
            }
        }

        let lowerAfterPrefix = s.lowercased()
        for suffix in suffixes {
            if lowerAfterPrefix.hasSuffix(suffix) && s.count > suffix.count {
                s = String(s.dropLast(suffix.count))
                break
            }
        }

        let result = s.trimmingCharacters(in: .whitespaces)
        return result.isEmpty ? input : result
    }
}
