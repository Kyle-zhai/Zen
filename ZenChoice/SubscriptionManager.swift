import Foundation
import StoreKit

@Observable
class SubscriptionManager {

    static let monthlyProductId = "monthly_premium"
    static let yearlyProductId = "yearly_premium"

    private(set) var products: [Product] = []
    private(set) var activeProductId: String?
    private(set) var expirationDate: Date?

    var currentStatus: SubscriptionStatus {
        switch activeProductId {
        case Self.yearlyProductId: return .yearly
        case Self.monthlyProductId: return .monthly
        default: return .free
        }
    }

    var monthlyProduct: Product? {
        products.first { $0.id == Self.monthlyProductId }
    }

    var yearlyProduct: Product? {
        products.first { $0.id == Self.yearlyProductId }
    }

    func loadProducts() async {
        do {
            products = try await Product.products(for: [
                Self.monthlyProductId,
                Self.yearlyProductId,
            ])
        } catch {
            // Product loading failed
        }
    }

    func purchase(_ product: Product) async throws -> Bool {
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            await transaction.finish()
            try? await Task.sleep(for: .milliseconds(800))
            await refreshStatus()
            return true
        case .userCancelled, .pending:
            return false
        @unknown default:
            return false
        }
    }

    /// Find the single active subscription by scanning current entitlements.
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

    func listenForTransactions() async {
        for await result in Transaction.updates {
            if let transaction = try? checkVerified(result) {
                await transaction.finish()
            }
            await refreshStatus()
        }
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
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
