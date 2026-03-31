import SwiftUI
import StoreKit

struct PaywallView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    private var cn: Bool { viewModel.L.isChinese }
    private var manager: SubscriptionManager { viewModel.subscriptionManager }

    var body: some View {
        NavigationStack {
            ZStack {
                ZenBackground()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        Spacer().frame(height: 20)

                        Image(systemName: "sparkles")
                            .font(.system(size: 48))
                            .foregroundStyle(ZenTheme.gooseYellow)
                            .shadow(color: ZenTheme.gooseYellow.opacity(0.4), radius: 20)

                        VStack(spacing: 6) {
                            Text(cn ? "解锁完整体验" : "Unlock Full Experience")
                                .font(ZenTheme.calligraphy(24))
                                .foregroundStyle(ZenTheme.inkBlack)
                            Text(cn ? "让每次鼓励都独一无二" : "Make every encouragement unique")
                                .font(ZenTheme.bodyFont(15))
                                .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
                        }

                        // Current subscription status
                        if viewModel.isSubscribed {
                            VStack(spacing: 6) {
                                HStack(spacing: 8) {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundStyle(.green)
                                    Text(currentPlanLabel)
                                        .font(ZenTheme.bodyFont(14))
                                        .foregroundStyle(ZenTheme.inkBlack)
                                }

                                if let exp = manager.expirationDate {
                                    Text(cn ? "到期时间：\(exp.formatted(date: .long, time: .omitted))" : "Expires: \(exp.formatted(date: .long, time: .omitted))")
                                        .font(ZenTheme.caption(12))
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: 12).fill(.green.opacity(0.08)))
                        }

                        // Feature list
                        VStack(alignment: .leading, spacing: 16) {
                            featureRow(icon: "flame",
                                       title: cn ? "更多每日次数" : "More Daily Uses",
                                       desc: cn ? "月度20次/天，年度30次/天（免费版15次/天）" : "Monthly: 20/day, Yearly: 30/day (free: 15/day)")
                            featureRow(icon: "brain.head.profile",
                                       title: cn ? "3个AI专属视角" : "3 Custom AI Perspectives",
                                       desc: cn ? "自定义视角+语气，AI为你量身生成鼓励" : "Custom perspectives + tone, AI generates unique encouragement")
                            featureRow(icon: "sparkles",
                                       title: cn ? "每次6个维度" : "6 Dimensions Per Session",
                                       desc: cn ? "3个AI视角 + 3个随机模版（免费版4个）" : "3 AI perspectives + 3 random templates (free: 4)")
                            featureRow(icon: "book.closed",
                                       title: cn ? "勇气档案" : "Courage Archive",
                                       desc: cn ? "保存最近30条记录，回顾每次勇敢" : "Save last 30 records, revisit every brave moment")
                            featureRow(icon: "square.and.arrow.up",
                                       title: cn ? "精美分享卡" : "Beautiful Share Cards",
                                       desc: cn ? "一键生成社交分享卡片" : "One-tap shareable quote cards")
                        }
                        .padding(20)
                        .background(RoundedRectangle(cornerRadius: 16).fill(.white.opacity(0.7)))
                        .padding(.horizontal)

                        // Apple native subscription UI — handles loading, pricing, purchase
                        SubscriptionStoreView(productIDs: [
                            SubscriptionManager.monthlyProductId,
                            SubscriptionManager.yearlyProductId
                        ])
                        .subscriptionStoreButtonLabel(.multiline)
                        .subscriptionStorePickerItemBackground(.thinMaterial)
                        .storeButton(.visible, for: .restorePurchases)
                        .onInAppPurchaseCompletion { _, result in
                            switch result {
                            case .success(.success):
                                await manager.refreshStatus()
                                await MainActor.run {
                                    viewModel.syncSubscriptionStatus()
                                }
                                HapticManager.success()
                                dismiss()
                            default:
                                break
                            }
                        }
                        .frame(minHeight: 300)
                        .padding(.horizontal)

                        Text(cn
                             ? "订阅将通过 Apple ID 扣款，到期前24小时自动续费\n可随时在系统设置 > Apple ID > 订阅中取消"
                             : "Payment charged to Apple ID. Auto-renews 24hrs before expiry.\nCancel anytime in Settings > Apple ID > Subscriptions.")
                            .font(ZenTheme.caption(11))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
                            .multilineTextAlignment(.center)

                        HStack(spacing: 16) {
                            Link(cn ? "隐私政策" : "Privacy Policy",
                                 destination: URL(string: "https://kyle-zhai.github.io/Zen/privacy.html")!)
                            Text("·").foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
                            Link(cn ? "用户协议" : "Terms of Use",
                                 destination: URL(string: "https://kyle-zhai.github.io/Zen/terms.html")!)
                        }
                        .font(ZenTheme.caption(11))
                        .padding(.bottom, 30)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                    }
                }
            }
        }
    }

    // MARK: - Labels

    private var currentPlanLabel: String {
        switch viewModel.subscriptionStatus {
        case .free: return ""
        case .monthly: return cn ? "当前：月度订阅" : "Current: Monthly"
        case .yearly: return cn ? "当前：年度订阅" : "Current: Yearly"
        }
    }

    // MARK: - Feature row

    private func featureRow(icon: String, title: String, desc: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(ZenTheme.gooseYellow)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.inkBlack)
                Text(desc)
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
            }
        }
    }
}

#Preview {
    PaywallView()
        .environment(ZenViewModel())
}
