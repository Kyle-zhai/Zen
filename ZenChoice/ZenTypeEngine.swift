import Foundation

@MainActor
@Observable
class ZenTypeEngine {

    enum TestLevel { case basic, advanced }

    private(set) var allTypes: [ZenType] = []
    private var allBasicQuestions: [ZenTestQuestion] = []
    private var allAdvancedQuestions: [ZenTestQuestion] = []
    /// The subset of questions selected for the current test session.
    private(set) var basicQuestions: [ZenTestQuestion] = []
    private(set) var advancedQuestions: [ZenTestQuestion] = []
    private(set) var basicResult: ZenType?
    private(set) var advancedResult: ZenType?
    /// Raw score breakdown from the last completed test (type id → score).
    private(set) var basicScores: [String: Int] = [:]
    private(set) var advancedScores: [String: Int] = [:]
    var currentAnswers: [Int: String] = [:]  // questionId -> "a" or "b" or "c"
    var testLevel: TestLevel = .basic

    private static let basicResultKey = "zenTypeBasicResult"
    private static let advancedResultKey = "zenTypeAdvancedResult"
    private static let basicScoresKey = "zenTypeBasicScores"
    private static let advancedScoresKey = "zenTypeAdvancedScores"

    /// How many questions to pick from each pool per test session.
    private static let basicQuestionCount = 8
    private static let advancedQuestionCount = 30

    // Backward compat
    var userResult: ZenType? { basicResult }
    var hasResult: Bool { basicResult != nil }
    var hasAdvancedResult: Bool { advancedResult != nil }

    var questions: [ZenTestQuestion] {
        testLevel == .basic ? basicQuestions : advancedQuestions
    }

    // MARK: - Load

    func loadData() {
        guard let url = Bundle.main.url(forResource: "ZenTypeData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }

        struct ZenTypeFile: Codable {
            let types: [ZenType]
            let questions: [ZenTestQuestion]
            let advancedQuestions: [ZenTestQuestion]

            enum CodingKeys: String, CodingKey {
                case types, questions
                case advancedQuestions = "advanced_questions"
            }
        }

        guard let file = try? JSONDecoder().decode(ZenTypeFile.self, from: data) else { return }
        allTypes = file.types
        allBasicQuestions = file.questions
        allAdvancedQuestions = file.advancedQuestions
        // Select random subsets for this session
        reshuffleQuestions()

        if let savedId = UserDefaults.standard.string(forKey: Self.basicResultKey),
           let saved = allTypes.first(where: { $0.id == savedId }) {
            basicResult = saved
            basicScores = loadScores(forKey: Self.basicScoresKey)
        }
        if let savedId = UserDefaults.standard.string(forKey: Self.advancedResultKey),
           let saved = allTypes.first(where: { $0.id == savedId }) {
            advancedResult = saved
            advancedScores = loadScores(forKey: Self.advancedScoresKey)
        }
    }

    // MARK: - Shuffle

    /// Pick a random subset of questions, ensuring every type can still be reached.
    func reshuffleQuestions() {
        basicQuestions = selectBalanced(from: allBasicQuestions, count: Self.basicQuestionCount)
        advancedQuestions = selectBalanced(from: allAdvancedQuestions, count: Self.advancedQuestionCount)
    }

    /// Select `count` questions from `pool`, ensuring all 9 type IDs appear in at least one option score.
    private func selectBalanced(from pool: [ZenTestQuestion], count: Int) -> [ZenTestQuestion] {
        guard pool.count > count else { return pool.shuffled() }
        let typeIds = Set(allTypes.map(\.id))

        // Try up to 20 times to find a balanced subset
        for _ in 0..<20 {
            let selected = Array(pool.shuffled().prefix(count))
            let covered = coveredTypes(in: selected)
            if typeIds.isSubset(of: covered) {
                return selected
            }
        }
        // Fallback: greedy — pick questions that maximize type coverage
        var selected: [ZenTestQuestion] = []
        var covered: Set<String> = []
        var remaining = pool.shuffled()

        // First pass: pick questions that cover uncovered types
        while selected.count < count && !remaining.isEmpty {
            if let idx = remaining.firstIndex(where: { q in
                let qTypes = questionTypes(q)
                return !qTypes.isSubset(of: covered)
            }) {
                let q = remaining.remove(at: idx)
                covered.formUnion(questionTypes(q))
                selected.append(q)
            } else {
                selected.append(remaining.removeFirst())
            }
        }
        return selected
    }

    private func coveredTypes(in questions: [ZenTestQuestion]) -> Set<String> {
        var types: Set<String> = []
        for q in questions {
            types.formUnion(q.optionAScores.keys)
            types.formUnion(q.optionBScores.keys)
            types.formUnion(q.optionCScores.keys)
        }
        return types
    }

    private func questionTypes(_ q: ZenTestQuestion) -> Set<String> {
        var types: Set<String> = []
        types.formUnion(q.optionAScores.keys)
        types.formUnion(q.optionBScores.keys)
        types.formUnion(q.optionCScores.keys)
        return types
    }

    // MARK: - Answer & Score

    func recordAnswer(questionId: Int, choice: String) {
        currentAnswers[questionId] = choice
    }

    func calculateResult() -> ZenType? {
        var scores: [String: Int] = [:]
        let qs = testLevel == .basic ? basicQuestions : advancedQuestions

        for q in qs {
            guard let chosen = currentAnswers[q.id] else { continue }
            let s: [String: Int]
            switch chosen {
            case "a": s = q.optionAScores
            case "c": s = q.optionCScores
            default: s = q.optionBScores
            }
            for (model, score) in s {
                scores[model, default: 0] += score
            }
        }

        guard let topId = scores.max(by: { $0.value < $1.value })?.key,
              let result = allTypes.first(where: { $0.id == topId }) else { return nil }

        if testLevel == .basic {
            basicResult = result
            basicScores = scores
            UserDefaults.standard.set(result.id, forKey: Self.basicResultKey)
            CloudSyncManager.shared.set(result.id, forKey: Self.basicResultKey)
            saveScores(scores, forKey: Self.basicScoresKey)
        } else {
            advancedResult = result
            advancedScores = scores
            UserDefaults.standard.set(result.id, forKey: Self.advancedResultKey)
            CloudSyncManager.shared.set(result.id, forKey: Self.advancedResultKey)
            saveScores(scores, forKey: Self.advancedScoresKey)
        }

        return result
    }

    // MARK: - Score Persistence

    private func saveScores(_ scores: [String: Int], forKey key: String) {
        if let data = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(data, forKey: key)
            CloudSyncManager.shared.set(data, forKey: key)
        }
    }

    private func loadScores(forKey key: String) -> [String: Int] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let scores = try? JSONDecoder().decode([String: Int].self, from: data) else {
            return [:]
        }
        return scores
    }

    /// Normalized scores (0–1) for radar chart display. Uses the specified test level's scores.
    func normalizedScores(for level: TestLevel) -> [String: Double] {
        let raw = level == .basic ? basicScores : advancedScores
        guard let maxVal = raw.values.max(), maxVal > 0 else { return [:] }
        return raw.mapValues { Double($0) / Double(maxVal) }
    }

    // MARK: - Advanced Test

    func startAdvancedTest() {
        testLevel = .advanced
        currentAnswers = [:]
        reshuffleQuestions()
    }

    // MARK: - Reset

    func resetTest() {
        basicResult = nil
        advancedResult = nil
        basicScores = [:]
        advancedScores = [:]
        currentAnswers = [:]
        testLevel = .basic
        UserDefaults.standard.removeObject(forKey: Self.basicResultKey)
        UserDefaults.standard.removeObject(forKey: Self.advancedResultKey)
        UserDefaults.standard.removeObject(forKey: Self.basicScoresKey)
        UserDefaults.standard.removeObject(forKey: Self.advancedScoresKey)
        CloudSyncManager.shared.set(nil as String?, forKey: Self.basicResultKey)
        CloudSyncManager.shared.set(nil as String?, forKey: Self.advancedResultKey)
        CloudSyncManager.shared.set(nil as Data?, forKey: Self.basicScoresKey)
        CloudSyncManager.shared.set(nil as Data?, forKey: Self.advancedScoresKey)
        reshuffleQuestions()
    }
}
