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
            // Product loading failed — user will see empty price list
        }
    }

    func purchase(_ product: Product) async throws -> Bool {
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            await transaction.finish()
            await refreshStatus()
            return true
        case .userCancelled, .pending:
            return false
        @unknown default:
            return false
        }
    }

    /// Determine the single active subscription by checking Product.SubscriptionInfo.
    /// This correctly handles upgrades/downgrades within a subscription group.
    func refreshStatus() async {
        var bestProductId: String?
        var bestExpiration: Date?

        // Method 1: Product.subscription.status (most reliable for upgrade detection)
        for product in products {
            guard let subscription = product.subscription else { continue }
            do {
                let statuses = try await subscription.status
                for status in statuses {
                    guard case .verified(let renewalInfo) = status.renewalInfo,
                          case .verified(let transaction) = status.transaction else {
                        continue
                    }

                    let isActive = status.state == .subscribed || status.state == .inGracePeriod
                    guard isActive else { continue }

                    // Use autoRenewPreference — this is the KEY field that reflects upgrades.
                    // After upgrading monthly→yearly, autoRenewPreference becomes yearly_premium
                    // even if the current transaction is still monthly.
                    let effectiveProductId = renewalInfo.autoRenewPreference ?? transaction.productID
                    let exp = transaction.expirationDate

                    if bestProductId == nil {
                        bestProductId = effectiveProductId
                        bestExpiration = exp
                    } else if effectiveProductId == Self.yearlyProductId && bestProductId == Self.monthlyProductId {
                        bestProductId = effectiveProductId
                        bestExpiration = exp
                    } else if effectiveProductId == bestProductId, let e = exp, let be = bestExpiration, e > be {
                        bestExpiration = e
                    }
                }
            } catch {
                // Status check failed for this product, try next
            }
        }

        // Method 2: Fallback to currentEntitlements
        if bestProductId == nil {
            for await result in Transaction.currentEntitlements {
                if let transaction = try? checkVerified(result) {
                    if transaction.revocationDate != nil { continue }
                    let pid = transaction.productID
                    let exp = transaction.expirationDate

                    if bestProductId == nil {
                        bestProductId = pid
                        bestExpiration = exp
                    } else if pid == Self.yearlyProductId && bestProductId == Self.monthlyProductId {
                        bestProductId = pid
                        bestExpiration = exp
                    }
                }
            }
        }

        activeProductId = bestProductId
        expirationDate = bestExpiration
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
