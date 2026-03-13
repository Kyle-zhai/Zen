import SwiftUI

@Observable
class ZenViewModel {

    // MARK: - User State

    var userName: String = ""
    var birthDate: Date = Calendar.current.date(
        byAdding: .year, value: -25, to: .now
    ) ?? .now
    var isPaid: Bool = false
    var currentUserId: UUID?

    // MARK: - Mode

    var selectedMode: DivinationMode = .todayAuspice

    // MARK: - Divination State

    var wish: String = ""
    var isLoading: Bool = false
    var showInkAnimation: Bool = false
    var showResult: Bool = false
    var currentResult: DivinationResult?

    var currentRecord: DecisionRecord? { currentResult?.record }

    // MARK: - History

    var history: [DecisionRecord] = []

    // MARK: - Sheets

    var showPaywall: Bool = false
    var showSettings: Bool = false
    var showHistory: Bool = false

    // MARK: - Error

    var errorMessage: String?
    var showError: Bool = false

    // MARK: - Poster

    #if os(iOS)
    var posterImage: UIImage?
    #endif
    var showShareSheet: Bool = false

    // MARK: - Private

    private let supabaseManager = SupabaseManager()

    // MARK: - Lifecycle

    func initialize() async {
        do {
            currentUserId = try await supabaseManager.signInAnonymously()
            await loadHistory()
        } catch {
            errorMessage = "连接服务失败，请检查网络"
            showError = true
            HapticManager.error()
        }
    }

    // MARK: - Core Divination (both modes)

    func divine() async {
        let trimmed = wish.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            errorMessage = selectedMode == .todayAuspice
                ? "请输入你想做的事"
                : "请输入你想做的事"
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

        switch selectedMode {
        case .todayAuspice:
            await divineTodayAuspice(event: trimmed)
        case .findBestDay:
            await divineFindBestDay(event: trimmed)
        }

        Task { if let r = currentRecord { try? await supabaseManager.saveRecord(r) } }

        withAnimation(.easeInOut(duration: 0.8)) {
            showInkAnimation = false
            showResult = true
        }

        isLoading = false
        HapticManager.success()
    }

    // MARK: - Mode 1: Today's Auspice

    private func divineTodayAuspice(event: String) async {
        let today = Date()
        let (verdict, isAuspicious) = ZenDecisionEngine.evaluateToday(
            event: event, userName: userName
        )
        let reasons = ZenDecisionEngine.generateReasons(for: today, userName: userName)
        let report = ZenDecisionEngine.generatePremiumReport(
            for: today, userName: userName, birthDate: birthDate
        )

        let record = DecisionRecord(
            id: UUID(),
            userId: currentUserId ?? UUID(),
            wish: event,
            recommendedDate: today,
            freeReasons: reasons,
            premiumReport: report,
            createdAt: .now
        )

        currentResult = DivinationResult(
            mode: .todayAuspice,
            record: record,
            verdict: verdict,
            isAuspicious: isAuspicious,
            recommendedTime: nil
        )
    }

    // MARK: - Mode 2: Find Best Day

    private func divineFindBestDay(event: String) async {
        let bestDay = ZenDecisionEngine.findBestDay(userName: userName)
        let bestTime = ZenDecisionEngine.recommendTime(for: bestDay, userName: userName)
        let reasons = ZenDecisionEngine.generateReasons(for: bestDay, userName: userName)
        let report = ZenDecisionEngine.generatePremiumReport(
            for: bestDay, userName: userName, birthDate: birthDate
        )

        let record = DecisionRecord(
            id: UUID(),
            userId: currentUserId ?? UUID(),
            wish: event,
            recommendedDate: bestDay,
            freeReasons: reasons,
            premiumReport: report,
            createdAt: .now
        )

        currentResult = DivinationResult(
            mode: .findBestDay,
            record: record,
            verdict: nil,
            isAuspicious: true,
            recommendedTime: bestTime
        )
    }

    // MARK: - History

    func loadHistory() async {
        guard let uid = currentUserId else { return }
        do {
            history = try await supabaseManager.fetchHistory(userId: uid)
        } catch {
            print("[ZenChoice] Load history failed: \(error)")
        }
    }

    // MARK: - Profile Sync

    func syncProfile() async {
        guard let uid = currentUserId else { return }
        do {
            try await supabaseManager.syncProfile(
                name: userName, birthDate: birthDate, userId: uid
            )
        } catch {
            print("[ZenChoice] Sync profile failed: \(error)")
        }
    }

    // MARK: - Poster

    func generatePoster() {
        #if os(iOS)
        guard let record = currentRecord else { return }
        posterImage = PosterService.render(record: record)
        showShareSheet = posterImage != nil
        if posterImage != nil { HapticManager.success() }
        #endif
    }

    func reset() {
        wish = ""
        showResult = false
        currentResult = nil
        #if os(iOS)
        posterImage = nil
        #endif
    }
}
