import SwiftUI

@Observable
class ZenViewModel {

    // MARK: - Language

    var appLanguage: AppLanguage = {
        // If user has previously chosen a language, respect that
        if let raw = UserDefaults.standard.string(forKey: "appLanguage"),
           let lang = AppLanguage(rawValue: raw) {
            return lang
        }
        // First launch: detect system language
        let preferred = Locale.preferredLanguages.first ?? ""
        let isChinese = preferred.hasPrefix("zh")
        let detected: AppLanguage = isChinese ? .chinese : .english
        UserDefaults.standard.set(detected.rawValue, forKey: "appLanguage")
        return detected
    }() {
        didSet { UserDefaults.standard.set(appLanguage.rawValue, forKey: "appLanguage") }
    }

    /// Shorthand used by all views to pick CN/EN strings.
    var L: AppLanguage { appLanguage }

    // MARK: - Subscription (StoreKit 2)

    let subscriptionManager = SubscriptionManager()

    /// Stored property so SwiftUI can track changes. Updated via syncSubscriptionStatus().
    var subscriptionStatus: SubscriptionStatus = .free

    var isSubscribed: Bool {
        subscriptionStatus != .free
    }

    /// Call after any purchase / restore / transaction update to sync the stored status.
    @MainActor
    func syncSubscriptionStatus() {
        subscriptionStatus = subscriptionManager.currentStatus
    }

    // MARK: - Input

    var wish: String = ""

    // MARK: - Encouragement State

    var isLoading: Bool = false
    var showInkAnimation: Bool = false
    var showResult: Bool = false
    var currentResult: EncouragementResult?

    // MARK: - Subscriber Customization (3 custom perspectives)

    /// Each perspective has a user-chosen name, optional description, optional tone.
    struct CustomPerspective: Codable {
        var name: String = ""
        var description: String = ""
        var emoji: String = "✨"
        var tone: String = ""

        /// Only requires a name — description and tone are optional enhancements.
        var isValid: Bool { !name.isEmpty }
    }

    var customPerspectives: [CustomPerspective] = {
        if let data = UserDefaults.standard.data(forKey: "customPerspectives"),
           let arr = try? JSONDecoder().decode([CustomPerspective].self, from: data) {
            // Ensure we always have exactly 3 slots
            var result = arr
            while result.count < 3 { result.append(CustomPerspective()) }
            return Array(result.prefix(3))
        }
        return [CustomPerspective(), CustomPerspective(), CustomPerspective()]
    }() {
        didSet {
            if let data = try? JSONEncoder().encode(customPerspectives) {
                UserDefaults.standard.set(data, forKey: "customPerspectives")
            }
        }
    }

    /// How many valid custom perspectives the user has configured.
    var validPerspectiveCount: Int {
        customPerspectives.filter(\.isValid).count
    }

    // MARK: - Archive (local only, max 30)

    var archiveRecords: [CourageRecord] = []

    private static let archiveKey = "courageArchive"
    private static let maxArchiveCount = 30

    // MARK: - Sheets

    var showPaywall: Bool = false
    var showSettings: Bool = false
    var showArchive: Bool = false

    // MARK: - Error

    var errorMessage: String?
    var showError: Bool = false

    // MARK: - Share

    #if os(iOS)
    var shareCardImage: UIImage?
    #endif
    var showShareSheet: Bool = false

    // MARK: - Private

    private let llmProvider: LLMProvider = QwenProvider()

    // MARK: - Lifecycle

    func initialize() async {
        loadLocalArchive()
        await subscriptionManager.loadProducts()
        await subscriptionManager.restorePurchases()
        syncSubscriptionStatus()
        Task {
            await subscriptionManager.listenForTransactions()
            // Sync again after any transaction update
            await MainActor.run { syncSubscriptionStatus() }
        }
    }

    // MARK: - Core: Generate Encouragement

    @MainActor
    func generateEncouragement() async {
        let trimmed = wish.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            errorMessage = L.isChinese ? "请输入你想做的事" : "Please enter what you want to do"
            showError = true
            HapticManager.error()
            return
        }

        isLoading = true
        showResult = false

        withAnimation(.easeOut(duration: 0.4)) {
            showInkAnimation = true
        }
        HapticManager.impact()

        try? await Task.sleep(for: .seconds(2.2))

        let activePerspectives = customPerspectives.filter(\.isValid)

        if isSubscribed, !activePerspectives.isEmpty {
            // Subscriber: LLM for each custom perspective (parallel) + 3 local templates = 6 total
            var llmResults: [DimensionResult] = []

            let provider = llmProvider
            await withTaskGroup(of: DimensionResult?.self) { group in
                for p in activePerspectives {
                    // Use name as perspective if description is empty
                    let perspectiveText = p.description.isEmpty ? p.name : p.description
                    let prompt = buildLLMPrompt(wish: trimmed, perspective: perspectiveText, tone: p.tone)
                    let name = p.name
                    let emoji = p.emoji
                    group.addTask {
                        try? await provider.generate(prompt: prompt, perspectiveName: name, emoji: emoji)
                    }
                }
                for await result in group {
                    if let r = result { llmResults.append(r) }
                }
            }

            // Notify if some AI perspectives failed
            let failedCount = activePerspectives.count - llmResults.count
            if failedCount > 0 {
                errorMessage = L.isChinese
                    ? "部分AI视角生成失败，已用模版补充"
                    : "\(failedCount) AI perspective(s) unavailable, using templates instead"
                showError = true
            }

            // 3 local template dimensions to fill remaining slots
            let localCount = max(1, 6 - llmResults.count)
            let localResult = EncouragementEngine.generate(
                wish: trimmed,
                dimensionCount: localCount,
                language: appLanguage
            )

            // LLM results first, then local templates
            let allDimensions = llmResults + localResult.dimensions
            currentResult = EncouragementResult(
                wish: trimmed,
                dimensions: allDimensions,
                generatedAt: Date(),
                isLLMGenerated: !llmResults.isEmpty
            )
        } else {
            // Free tier or no custom perspectives: local templates only
            let dimensionCount = isSubscribed ? 5 : Int.random(in: 3...4)
            currentResult = EncouragementEngine.generate(
                wish: trimmed,
                dimensionCount: dimensionCount,
                language: appLanguage
            )
        }

        // Save to local archive
        if let result = currentResult {
            let record = CourageRecord(
                id: UUID(),
                wish: trimmed,
                dimensions: result.dimensions,
                isShared: false,
                isLLMGenerated: result.isLLMGenerated,
                createdAt: .now
            )
            appendToArchive(record)
        }

        withAnimation(.easeInOut(duration: 0.8)) {
            showInkAnimation = false
            showResult = true
        }

        isLoading = false
        HapticManager.success()
    }

    // MARK: - LLM Prompt Builder

    private func buildLLMPrompt(wish: String, perspective: String, tone: String) -> String {
        let coreAction = EncouragementEngine.extractCoreAction(from: wish, isChinese: L.isChinese)
        let lang = L.isChinese ? "中文" : "English"
        let tone = tone.isEmpty ? (L.isChinese ? "幽默" : "humorous") : tone

        if L.isChinese {
            return """
            你是一个鼓励大师。用户想要「\(coreAction)」。

            请你用「\(perspective)」的视角，以「\(tone)」的语气，写一段鼓励的话，告诉用户\(coreAction)是完全可行的，鼓励他们勇敢去做。

            要求：
            - 语言：\(lang)
            - 风格：有社交传播力，让人想截图分享
            - 字数：150-300字
            - 不要说教，要有趣、有共鸣
            - 不要用"加油"等空洞的鼓励词
            """
        } else {
            return """
            You are an encouragement master. The user wants to \(coreAction).

            Write an encouraging message from the perspective of "\(perspective)", using a "\(tone)" tone, telling the user that \(coreAction) is totally doable and encouraging them to go for it.

            Requirements:
            - Language: \(lang)
            - Style: Socially viral — makes people want to screenshot and share
            - Length: 100-200 words
            - Don't be preachy — be fun, relatable, and memorable
            - No empty platitudes like "you can do it"
            """
        }
    }

    // MARK: - Local Archive

    func loadLocalArchive() {
        guard let data = UserDefaults.standard.data(forKey: Self.archiveKey),
              let records = try? JSONDecoder().decode([CourageRecord].self, from: data) else {
            archiveRecords = []
            return
        }
        archiveRecords = records
    }

    private func appendToArchive(_ record: CourageRecord) {
        archiveRecords.insert(record, at: 0)
        if archiveRecords.count > Self.maxArchiveCount {
            archiveRecords = Array(archiveRecords.prefix(Self.maxArchiveCount))
        }
        saveArchiveToDisk()
    }

    private func saveArchiveToDisk() {
        if let data = try? JSONEncoder().encode(archiveRecords) {
            UserDefaults.standard.set(data, forKey: Self.archiveKey)
        }
    }

    // MARK: - Share Card

    func generateShareCard(dimensionResult: DimensionResult) {
        #if os(iOS)
        guard let result = currentResult else { return }
        shareCardImage = PosterService.renderShareCard(
            wish: result.wish,
            dimensionResult: dimensionResult,
            isChinese: L.isChinese
        )
        showShareSheet = shareCardImage != nil
        if shareCardImage != nil { HapticManager.success() }
        #endif
    }

    // MARK: - Reset

    func reset() {
        wish = ""
        showResult = false
        currentResult = nil
        #if os(iOS)
        shareCardImage = nil
        #endif
    }
}
