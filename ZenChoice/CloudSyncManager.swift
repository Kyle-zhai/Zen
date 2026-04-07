import Foundation

/// Syncs critical user data via iCloud Key-Value Store (NSUbiquitousKeyValueStore).
/// Tied to the user's Apple ID — data persists across delete/reinstall.
@MainActor
@Observable
class CloudSyncManager {

    static let shared = CloudSyncManager()

    // Keys to sync between UserDefaults ↔ iCloud KV
    private static let syncKeys: [String] = [
        "fortuneHistory",
        "lastFortuneDrawDate",
        "dailyFortuneCount",
        "dailyFortuneCountDate",
        "zenTypeBasicResult",
        "zenTypeAdvancedResult",
        "zenTypeBasicScores",
        "zenTypeAdvancedScores",
        "dailyUsageDate",
        "dailyUsageCount",
    ]

    private let cloud = NSUbiquitousKeyValueStore.default
    private let local = UserDefaults.standard

    private init() {}

    // MARK: - Start

    func start() {
        // Listen for remote changes
        NotificationCenter.default.addObserver(
            forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: cloud,
            queue: .main
        ) { [weak self] notification in
            Task { @MainActor in
                self?.handleRemoteChange(notification)
            }
        }

        cloud.synchronize()

        // On first launch or reinstall, pull from iCloud
        pullFromCloud()
    }

    // MARK: - Push local → iCloud

    func pushToCloud() {
        for key in Self.syncKeys {
            if let value = local.object(forKey: key) {
                cloud.set(value, forKey: key)
            }
        }
        cloud.synchronize()
    }

    // MARK: - Pull iCloud → local

    func pullFromCloud() {
        for key in Self.syncKeys {
            if let cloudValue = cloud.object(forKey: key) {
                // Only overwrite local if local is empty (reinstall scenario)
                // or if cloud date is newer (for date keys)
                if local.object(forKey: key) == nil {
                    local.set(cloudValue, forKey: key)
                } else if key.contains("Date") || key.contains("date") {
                    // For date keys, prefer the more recent one
                    if let cloudDate = cloudValue as? Date,
                       let localDate = local.object(forKey: key) as? Date {
                        if cloudDate > localDate {
                            local.set(cloudDate, forKey: key)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Handle remote change

    private func handleRemoteChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reason = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? Int else { return }

        // Only pull on server change or initial sync
        if reason == NSUbiquitousKeyValueStoreServerChange
            || reason == NSUbiquitousKeyValueStoreInitialSyncChange {
            pullFromCloud()
        }
    }

    // MARK: - Convenience: write to both

    func set(_ value: Any?, forKey key: String) {
        local.set(value, forKey: key)
        if Self.syncKeys.contains(key) {
            if let value {
                cloud.set(value, forKey: key)
            } else {
                cloud.removeObject(forKey: key)
            }
            cloud.synchronize()
        }
    }
}
