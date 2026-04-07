import Foundation

@MainActor
@Observable
class FortuneEngine {

    private(set) var allFortunes: [Fortune] = []
    private(set) var todayFortune: Fortune?
    private(set) var hasDrawnToday: Bool = false

    private static let historyKey = "fortuneHistory"
    private static let lastDrawDateKey = "lastFortuneDrawDate"
    private static let dailyFortuneCountKey = "dailyFortuneCount"
    private static let dailyFortuneCountDateKey = "dailyFortuneCountDate"

    /// 24-hour cooldown window
    static let cooldownInterval: TimeInterval = 24 * 60 * 60

    /// Public getter for the last draw timestamp (used by ViewModel to sync encourage cooldown).
    var lastDrawDate: Date? {
        UserDefaults.standard.object(forKey: Self.lastDrawDateKey) as? Date
    }

    init() {
        // Pre-check cooldown before fortune data loads so the UI doesn't flash
        if let lastDraw = UserDefaults.standard.object(forKey: Self.lastDrawDateKey) as? Date,
           Date().timeIntervalSince(lastDraw) < Self.cooldownInterval {
            hasDrawnToday = true
        }
    }

    // MARK: - Load

    func loadFortunes() {
        guard let url = Bundle.main.url(forResource: "FortuneData", withExtension: "json"),
              let rawData = try? Data(contentsOf: url),
              let fortunes = try? JSONDecoder().decode([Fortune].self, from: rawData) else { return }
        allFortunes = fortunes
        checkCooldown()

        // Safety: if cooldown is active but fortune can't be recovered, reset cooldown
        if hasDrawnToday && todayFortune == nil {
            hasDrawnToday = false
        }
    }

    // MARK: - Daily Draw (24h cooldown)

    func drawFortune() -> Fortune? {
        guard !allFortunes.isEmpty else { return nil }

        // If within 24h cooldown, return existing fortune
        if hasDrawnToday, let today = todayFortune { return today }

        // Pick from non-recent fortunes (7-day history)
        let history = recentHistory(days: 7)
        let available = allFortunes.filter { f in !history.contains(f.id) }
        let pool = available.isEmpty ? allFortunes : available

        guard let fortune = pool.randomElement() else { return nil }
        todayFortune = fortune
        hasDrawnToday = true

        saveToHistory(fortuneId: fortune.id)
        saveDrawTimestamp()

        return fortune
    }

    // MARK: - Daily Fortune Count (for paywall)

    var dailyFortuneCount: Int {
        guard let lastDate = UserDefaults.standard.object(forKey: Self.dailyFortuneCountDateKey) as? Date else { return 0 }
        if Date().timeIntervalSince(lastDate) < Self.cooldownInterval {
            return UserDefaults.standard.integer(forKey: Self.dailyFortuneCountKey)
        }
        return 0
    }

    func incrementFortuneCount() {
        let lastDate = UserDefaults.standard.object(forKey: Self.dailyFortuneCountDateKey) as? Date ?? .distantPast
        var count = 0
        if Date().timeIntervalSince(lastDate) < Self.cooldownInterval {
            count = UserDefaults.standard.integer(forKey: Self.dailyFortuneCountKey)
        }
        count += 1
        UserDefaults.standard.set(count, forKey: Self.dailyFortuneCountKey)
        UserDefaults.standard.set(Date(), forKey: Self.dailyFortuneCountDateKey)
    }

    // MARK: - Private

    private func checkCooldown() {
        guard let lastDraw = UserDefaults.standard.object(forKey: Self.lastDrawDateKey) as? Date else {
            hasDrawnToday = false
            todayFortune = nil
            return
        }

        if Date().timeIntervalSince(lastDraw) < Self.cooldownInterval {
            hasDrawnToday = true
            if let lastId = recentHistory(days: 1).first,
               let fortune = allFortunes.first(where: { $0.id == lastId }) {
                todayFortune = fortune
            }
        } else {
            hasDrawnToday = false
            todayFortune = nil
        }
    }

    private func recentHistory(days: Int) -> [String] {
        guard let data = UserDefaults.standard.data(forKey: Self.historyKey),
              let history = try? JSONDecoder().decode([[String: String]].self, from: data) else {
            return []
        }
        let cutoff = Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? .distantPast
        let formatter = ISO8601DateFormatter()
        return history.compactMap { entry in
            guard let dateStr = entry["date"],
                  let id = entry["id"],
                  let date = formatter.date(from: dateStr),
                  date > cutoff else { return nil }
            return id
        }
    }

    private func saveToHistory(fortuneId: String) {
        var history: [[String: String]] = []
        if let data = UserDefaults.standard.data(forKey: Self.historyKey),
           let existing = try? JSONDecoder().decode([[String: String]].self, from: data) {
            history = existing
        }
        let entry = ["id": fortuneId, "date": ISO8601DateFormatter().string(from: Date())]
        history.append(entry)
        if history.count > 30 { history = Array(history.suffix(30)) }
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: Self.historyKey)
            CloudSyncManager.shared.set(data, forKey: Self.historyKey)
        }
    }

    private func saveDrawTimestamp() {
        let now = Date()
        UserDefaults.standard.set(now, forKey: Self.lastDrawDateKey)
        CloudSyncManager.shared.set(now, forKey: Self.lastDrawDateKey)
    }
}
