import Foundation
import StoreKit

@MainActor
@Observable
class SubscriptionManager {

    static let monthlyProductId = "monthly_premium"
    static let yearlyProductId = "yearly_premium"

    private(set) var activeProductId: String?
    private(set) var expirationDate: Date?

    var currentStatus: SubscriptionStatus {
        switch activeProductId {
        case Self.yearlyProductId: return .yearly
        case Self.monthlyProductId: return .monthly
        default: return .free
        }
    }

    func refreshStatus() async {
        var latestProductId: String?
        var latestExpiration: Date?
        var latestPurchaseDate: Date = .distantPast

        for await result in Transaction.currentEntitlements {
            guard let transaction = try? checkVerified(result) else { continue }
            guard transaction.revocationDate == nil else { continue }

            let pid = transaction.productID
            guard pid == Self.monthlyProductId || pid == Self.yearlyProductId else { continue }

            if transaction.purchaseDate > latestPurchaseDate {
                latestPurchaseDate = transaction.purchaseDate
                latestProductId = pid
                latestExpiration = transaction.expirationDate
            }
        }

        activeProductId = latestProductId
        expirationDate = latestExpiration
    }

    func restorePurchases() async {
        try? await AppStore.sync()
        await refreshStatus()
    }

    private nonisolated func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }

    enum StoreError: Error {
        case failedVerification
    }
}
