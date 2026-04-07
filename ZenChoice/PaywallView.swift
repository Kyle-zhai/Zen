import SwiftUI
import StoreKit

struct PaywallView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    private var cn: Bool { viewModel.L.isChinese }
    private var manager: SubscriptionManager { viewModel.subscriptionManager }

    var body: some View {
        NavigationStack {
            SubscriptionStoreView(productIDs: [
                SubscriptionManager.monthlyProductId,
                SubscriptionManager.yearlyProductId
            ]) {
                VStack(spacing: 24) {
                    Spacer().frame(height: 8)

                    // Icon
                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .clipShape(RoundedRectangle(cornerRadius: 14))

                    // Title
                    VStack(spacing: 6) {
                        Text(cn ? "禅意 Pro" : "ZenChoice Pro")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.primary)
                        Text(cn ? "解锁完整体验" : "Unlock the full experience")
                            .font(.system(size: 15))
                            .foregroundStyle(.secondary)
                    }

                    // Current plan badge
                    if viewModel.isSubscribed {
                        HStack(spacing: 6) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            Text(currentPlanLabel)
                                .font(.system(size: 14, weight: .medium))
                            if let exp = manager.expirationDate {
                                Text("· \(exp.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                    }

                    // Feature list
                    VStack(alignment: .leading, spacing: 16) {
                        featureRow(
                            icon: "sparkle",
                            text: cn ? "无限每日签" : "Unlimited daily fortunes"
                        )
                        featureRow(
                            icon: "brain.head.profile",
                            text: cn ? "AI深度命星解读" : "AI deep star reading"
                        )
                        featureRow(
                            icon: "flame",
                            text: cn ? "更多鼓励次数" : "More encouragement uses"
                        )
                        featureRow(
                            icon: "sparkles",
                            text: cn ? "3个AI专属视角 · 6个维度" : "3 custom AI views · 6 dimensions"
                        )
                        featureRow(
                            icon: "hands.sparkles",
                            text: cn ? "无限社交请求" : "Unlimited social requests"
                        )
                    }
                    .padding(.horizontal, 4)
                }
                .padding(.horizontal)
            }
            .subscriptionStoreButtonLabel(.multiline)
            .storeButton(.visible, for: .restorePurchases)
            .onInAppPurchaseCompletion { _, result in
                switch result {
                case .success(.success):
                    await manager.refreshStatus()
                    viewModel.syncSubscriptionStatus()
                    HapticManager.success()
                    dismiss()
                default:
                    break
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray.opacity(0.6))
                    }
                }
            }
        }
    }

    private var currentPlanLabel: String {
        switch viewModel.subscriptionStatus {
        case .free: return ""
        case .monthly: return cn ? "月度订阅" : "Monthly"
        case .yearly: return cn ? "年度订阅" : "Yearly"
        }
    }

    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundStyle(.blue)
                .frame(width: 24)
            Text(text)
                .font(.system(size: 15))
        }
    }
}

#Preview {
    PaywallView()
        .environment(ZenViewModel())
}
