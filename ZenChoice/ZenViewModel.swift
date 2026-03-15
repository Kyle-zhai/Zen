import SwiftUI

@Observable
class ZenViewModel {

    // MARK: - User State

    var userName: String = ""
    var subscriptionStatus: SubscriptionStatus = .free
    var currentUserId: UUID?

    var isSubscribed: Bool {
        subscriptionStatus != .free
    }

    // MARK: - Input

    var wish: String = ""

    // MARK: - Encouragement State

    var isLoading: Bool = false
    var showInkAnimation: Bool = false
    var showResult: Bool = false
    var currentResult: EncouragementResult?

    // MARK: - Subscriber Customization

    var selectedDimensionIds: [String]? = nil
    var selectedTone: String? = nil

    // MARK: - Archive

    var archiveRecords: [CourageRecord] = []

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

    private let supabaseManager = SupabaseManager()
    private let llmProvider: LLMProvider = PlaceholderLLMProvider()

    // MARK: - Lifecycle

    func initialize() async {
        do {
            currentUserId = try await supabaseManager.signInAnonymously()
            await loadArchive()
        } catch {
            // App works offline for free tier (local templates)
            print("[ZenChoice] Init failed, continuing offline: \(error)")
        }
    }

    // MARK: - Core: Generate Encouragement

    @MainActor
    func generateEncouragement() async {
        let trimmed = wish.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            errorMessage = "请输入你想做的事"
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

        let dimensionCount = isSubscribed ? 5 : Int.random(in: 3...4)

        if isSubscribed, let tone = selectedTone {
            // Subscriber: use LLM
            do {
                let dims = selectedDimensionIds ?? []
                let results = try await llmProvider.generate(
                    wish: trimmed,
                    dimensions: dims,
                    tone: tone
                )
                currentResult = EncouragementResult(
                    wish: trimmed,
                    dimensions: results,
                    generatedAt: Date(),
                    isLLMGenerated: true
                )
            } catch {
                // Fallback to local on LLM failure
                currentResult = EncouragementEngine.generate(
                    wish: trimmed,
                    dimensionCount: dimensionCount,
                    specificDimensionIds: selectedDimensionIds
                )
            }
        } else {
            // Free tier: local templates
            currentResult = EncouragementEngine.generate(
                wish: trimmed,
                dimensionCount: dimensionCount,
                specificDimensionIds: isSubscribed ? selectedDimensionIds : nil
            )
        }

        // Save to archive
        if let result = currentResult {
            let record = CourageRecord(
                id: UUID(),
                userId: currentUserId ?? UUID(),
                wish: trimmed,
                dimensions: result.dimensions,
                isShared: false,
                isLLMGenerated: result.isLLMGenerated,
                createdAt: .now
            )
            Task { try? await supabaseManager.saveRecord(record) }
        }

        withAnimation(.easeInOut(duration: 0.8)) {
            showInkAnimation = false
            showResult = true
        }

        isLoading = false
        HapticManager.success()
    }

    // MARK: - Archive

    func loadArchive() async {
        guard let uid = currentUserId else { return }
        do {
            archiveRecords = try await supabaseManager.fetchArchive(userId: uid)
        } catch {
            print("[ZenChoice] Load archive failed: \(error)")
        }
    }

    // MARK: - Profile Sync

    func syncProfile() async {
        guard let uid = currentUserId else { return }
        do {
            try await supabaseManager.syncProfile(
                name: userName, userId: uid
            )
        } catch {
            print("[ZenChoice] Sync profile failed: \(error)")
        }
    }

    // MARK: - Share Card

    func generateShareCard(dimensionResult: DimensionResult) {
        #if os(iOS)
        guard let result = currentResult else { return }
        shareCardImage = PosterService.renderShareCard(
            wish: result.wish,
            dimensionResult: dimensionResult
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
