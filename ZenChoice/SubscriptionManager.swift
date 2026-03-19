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
            print("[ZenChoice] Failed to load products: \(error)")
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

        print("[ZenChoice] refreshStatus: products count = \(products.count)")

        // Method 1: Product.subscription.status (most reliable for upgrade detection)
        for product in products {
            guard let subscription = product.subscription else {
                print("[ZenChoice] product \(product.id) has no subscription info")
                continue
            }
            do {
                let statuses = try await subscription.status
                print("[ZenChoice] product \(product.id) has \(statuses.count) status entries")
                for status in statuses {
                    print("[ZenChoice]   state=\(status.state)")
                    guard case .verified(let renewalInfo) = status.renewalInfo,
                          case .verified(let transaction) = status.transaction else {
                        print("[ZenChoice]   verification failed, skipping")
                        continue
                    }

                    let isActive = status.state == .subscribed || status.state == .inGracePeriod
                    print("[ZenChoice]   productID=\(transaction.productID) isActive=\(isActive) exp=\(String(describing: transaction.expirationDate)) autoRenewProductId=\(renewalInfo.autoRenewPreference ?? "nil")")

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
                print("[ZenChoice] product \(product.id) status error: \(error)")
            }
        }

        // Method 2: Fallback to currentEntitlements
        if bestProductId == nil {
            print("[ZenChoice] Falling back to Transaction.currentEntitlements")
            for await result in Transaction.currentEntitlements {
                if let transaction = try? checkVerified(result) {
                    print("[ZenChoice]   entitlement: \(transaction.productID) revoked=\(transaction.revocationDate != nil) exp=\(String(describing: transaction.expirationDate))")
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

        print("[ZenChoice] refreshStatus result: activeProductId=\(bestProductId ?? "nil") exp=\(String(describing: bestExpiration))")
        activeProductId = bestProductId
        expirationDate = bestExpiration
    }

    func restorePurchases() async {
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
