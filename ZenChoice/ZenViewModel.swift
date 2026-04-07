import SwiftUI
import StoreKit
import UserNotifications

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
        subscriptionStatus != .free || InviteCodeManager.shared.hasFreePro
    }

    /// Call after any purchase / restore / transaction update to sync the stored status.
    @MainActor
    func syncSubscriptionStatus() {
        subscriptionStatus = subscriptionManager.currentStatus
    }

    // MARK: - Daily Usage Limit

    private static let usageCountKey = "dailyUsageCount"
    private static let usageDateKey = "dailyUsageDate"

    var dailyUsageCount: Int = 0

    var dailyLimit: Int {
        switch subscriptionStatus {
        case .free: return 15
        case .monthly: return 20
        case .yearly: return 30
        }
    }

    var remainingUsage: Int {
        max(0, dailyLimit - dailyUsageCount)
    }

    private func loadDailyUsage() {
        let cooldown = FortuneEngine.cooldownInterval
        // Sync with fortune draw date; fall back to encourage session date
        let fortuneDate = fortuneEngine.lastDrawDate
        let encourageDate = UserDefaults.standard.object(forKey: Self.usageDateKey) as? Date
        let sessionDate = fortuneDate ?? encourageDate

        if let sessionDate, Date().timeIntervalSince(sessionDate) < cooldown {
            dailyUsageCount = UserDefaults.standard.integer(forKey: Self.usageCountKey)
        } else {
            dailyUsageCount = 0
            UserDefaults.standard.set(0, forKey: Self.usageCountKey)
        }
    }

    private func incrementDailyUsage() {
        dailyUsageCount += 1
        UserDefaults.standard.set(dailyUsageCount, forKey: Self.usageCountKey)
        CloudSyncManager.shared.set(dailyUsageCount, forKey: Self.usageCountKey)
        // Start encourage session if no active session exists
        let cooldown = FortuneEngine.cooldownInterval
        let fortuneDate = fortuneEngine.lastDrawDate
        let encourageDate = UserDefaults.standard.object(forKey: Self.usageDateKey) as? Date
        let sessionDate = fortuneDate ?? encourageDate
        if sessionDate == nil || Date().timeIntervalSince(sessionDate!) >= cooldown {
            let now = Date()
            UserDefaults.standard.set(now, forKey: Self.usageDateKey)
            CloudSyncManager.shared.set(now, forKey: Self.usageDateKey)
            scheduleRefreshNotification()
        }
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

    // MARK: - Auth

    let authManager = AuthManager()

    // MARK: - Social

    let socialManager = SocialManager()

    // MARK: - Tab Navigation

    var selectedTab: AppTab = .fortune

    // MARK: - Fortune & ZenType Engines

    let fortuneEngine = FortuneEngine()
    let zenTypeEngine = ZenTypeEngine()

    var showRespondSheet: Bool = false
    var deepLinkRequest: CourageRequest?

    // MARK: - Share Reward (daily share → 1 free custom perspective)

    private static let shareRewardDateKey = "shareRewardDate"

    var hasShareReward: Bool {
        guard let date = UserDefaults.standard.object(forKey: Self.shareRewardDateKey) as? Date else { return false }
        return Date().timeIntervalSince(date) < 24 * 60 * 60
    }

    func recordShareReward() {
        guard !isSubscribed, !hasShareReward else { return }
        UserDefaults.standard.set(Date(), forKey: Self.shareRewardDateKey)
    }

    @MainActor
    func handleDeepLink(url: URL) {
        guard let destination = DeepLinkHandler.parse(url: url) else { return }

        Task {
            switch destination {
            case .encourage(let id), .witness(let id):
                do {
                    deepLinkRequest = try await socialManager.fetchRequest(id: id)
                    showRespondSheet = true
                } catch {
                    errorMessage = L.isChinese ? "链接已失效" : "Link expired"
                    showError = true
                }
            case .bond(let fromUserId):
                guard authManager.isLoggedIn else {
                    errorMessage = L.isChinese ? "请先登录" : "Please sign in first"
                    showError = true
                    return
                }
                do {
                    try await socialManager.createBond(friendUserId: fromUserId)
                    HapticManager.success()
                    errorMessage = L.isChinese ? "善缘已结！" : "Bond formed!"
                    showError = true
                } catch {
                    errorMessage = L.isChinese ? "结缘失败" : "Bond failed"
                    showError = true
                }
            case .authCallback:
                break  // OTP flow handles auth in-app, no callback needed
            }
        }
    }

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

    private let llmProvider: LLMProvider = QwenProvider.shared

    // MARK: - Lifecycle

    @MainActor
    func initialize() async {
        // Wire social manager to auth
        socialManager.authManager = authManager

        // Load local data first (no network) so UI is ready immediately
        loadLocalArchive()
        loadDailyUsage()
        fortuneEngine.loadFortunes()
        zenTypeEngine.loadData()

        // Network-dependent init follows
        // Refresh token on launch (prevents 401 after token expiry)
        if authManager.isLoggedIn {
            await authManager.refreshSessionIfNeeded()
        }

        // Check profile if logged in
        if authManager.isLoggedIn {
            await authManager.checkProfileExists()
        }

        // Invite code: early bird + ensure code + apply pending rewards
        if let userId = authManager.userId {
            await InviteCodeManager.shared.checkEarlyBird(userId: userId)
            await InviteCodeManager.shared.ensureCode(userId: userId)
            await InviteCodeManager.shared.checkAndApplyRewards(userId: userId)
        }

        requestNotificationPermission()

        // Check existing entitlements (local, fast)
        await subscriptionManager.refreshStatus()
        syncSubscriptionStatus()

        // Listen for transaction updates in background and sync status
        Task { @MainActor in
            for await result in Transaction.updates {
                if let transaction = try? result.payloadValue {
                    await transaction.finish()
                }
                await subscriptionManager.refreshStatus()
                syncSubscriptionStatus()
            }
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

        // Check daily usage limit
        loadDailyUsage() // refresh in case day changed
        guard remainingUsage > 0 else {
            errorMessage = L.isChinese
                ? "今日已经足够勇敢了，留给明天一点机会吧 😎"
                : "You've been brave enough today — save some courage for tomorrow 😎"
            showError = true
            HapticManager.error()
            return
        }

        isLoading = true
        showResult = false
        showInkAnimation = true
        HapticManager.impact()

        try? await Task.sleep(for: .seconds(1.8))

        let allActive = customPerspectives.filter(\.isValid)
        let activePerspectives = isSubscribed ? allActive : (hasShareReward ? Array(allActive.prefix(1)) : [])

        if !activePerspectives.isEmpty {
            let provider = llmProvider
            let indexedResults: [(Int, DimensionResult)] = await withTaskGroup(of: (Int, DimensionResult?).self) { group in
                for (index, p) in activePerspectives.enumerated() {
                    let perspectiveText = p.description.isEmpty ? p.name : p.description
                    let prompt = buildLLMPrompt(wish: trimmed, perspective: perspectiveText, tone: p.tone)
                    let name = p.name
                    let emoji = p.emoji
                    group.addTask {
                        let result = try? await provider.generate(prompt: prompt, perspectiveName: name, emoji: emoji)
                        return (index, result)
                    }
                }
                var collected: [(Int, DimensionResult)] = []
                for await (index, result) in group {
                    if let r = result { collected.append((index, r)) }
                }
                return collected
            }
            let llmResults = indexedResults.sorted { $0.0 < $1.0 }.map(\.1)

            let failedCount = activePerspectives.count - llmResults.count
            if failedCount > 0 {
                errorMessage = L.isChinese
                    ? "部分AI视角生成失败，已用模版补充"
                    : "\(failedCount) AI perspective(s) unavailable, using templates instead"
                showError = true
            }

            let localCount = max(1, 6 - llmResults.count)
            let localResult = EncouragementEngine.generate(
                wish: trimmed,
                dimensionCount: localCount,
                language: appLanguage
            )

            let allDimensions = llmResults + localResult.dimensions
            currentResult = EncouragementResult(
                wish: trimmed,
                dimensions: allDimensions,
                generatedAt: Date(),
                isLLMGenerated: !llmResults.isEmpty
            )
        } else {
            let dimensionCount = isSubscribed ? 5 : 4
            currentResult = EncouragementEngine.generate(
                wish: trimmed,
                dimensionCount: dimensionCount,
                language: appLanguage
            )
        }

        // Increment daily usage
        incrementDailyUsage()

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

        // Stop all loading states immediately, then show result
        showInkAnimation = false
        isLoading = false
        showResult = true
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
        if shareCardImage != nil {
            HapticManager.success()
            recordShareReward()
        }
        #endif
    }

    // MARK: - Fortune Card

    func generateFortuneCard(fortune: Fortune) {
        #if os(iOS)
        shareCardImage = PosterService.renderFortuneCard(
            fortune: fortune,
            isChinese: L.isChinese
        )
        showShareSheet = shareCardImage != nil
        if shareCardImage != nil {
            HapticManager.success()
            recordShareReward()
        }
        #endif
    }

    // MARK: - ZenType Card

    func generateZenTypeCard(zenType: ZenType) {
        #if os(iOS)
        shareCardImage = PosterService.renderZenTypeCard(
            zenType: zenType,
            isChinese: L.isChinese
        )
        showShareSheet = shareCardImage != nil
        if shareCardImage != nil {
            HapticManager.success()
            recordShareReward()
        }
        #endif
    }

    func generateZenTypeAdvancedCard(zenType: ZenType, basicType: ZenType?) {
        #if os(iOS)
        shareCardImage = PosterService.renderZenTypeAdvancedCard(
            zenType: zenType,
            isChinese: L.isChinese,
            basicType: basicType
        )
        showShareSheet = shareCardImage != nil
        if shareCardImage != nil {
            HapticManager.success()
            recordShareReward()
        }
        #endif
    }

    // MARK: - Notifications

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    func scheduleRefreshNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["zenFortuneRefresh"])

        let content = UNMutableNotificationContent()
        content.title = L.isChinese ? "禅意" : "ZenChoice"
        content.body = L.isChinese
            ? "禅签已刷新，来看看今天的签文吧"
            : "Your oracle has refreshed — come draw today's fortune"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: FortuneEngine.cooldownInterval,
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: "zenFortuneRefresh",
            content: content,
            trigger: trigger
        )
        center.add(request)
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
