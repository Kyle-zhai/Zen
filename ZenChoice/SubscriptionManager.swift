import Foundation
import StoreKit

@Observable
class SubscriptionManager {

    static let monthlyProductId = "monthly_premium"
    static let yearlyProductId = "yearly_premium"

    private(set) var products: [Product] = []
    private(set) var purchasedProductIds: Set<String> = []

    var currentStatus: SubscriptionStatus {
        if purchasedProductIds.contains(Self.yearlyProductId) { return .yearly }
        if purchasedProductIds.contains(Self.monthlyProductId) { return .monthly }
        return .free
    }

    func loadProducts() async {
        do {
            products = try await Product.products(for: [
                Self.monthlyProductId,
                Self.yearlyProductId,
            ])
        } catch {
            print("[ZenChoice] Failed to load products: \(error)")
        }
    }

    func purchase(_ product: Product) async throws -> Bool {
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            purchasedProductIds.insert(transaction.productID)
            await transaction.finish()
            return true
        case .userCancelled, .pending:
            return false
        @unknown default:
            return false
        }
    }

    func restorePurchases() async {
        for await result in Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                purchasedProductIds.insert(transaction.productID)
            }
        }
    }

    func listenForTransactions() async {
        for await result in Transaction.updates {
            if let transaction = try? checkVerified(result) {
                purchasedProductIds.insert(transaction.productID)
                await transaction.finish()
            }
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
