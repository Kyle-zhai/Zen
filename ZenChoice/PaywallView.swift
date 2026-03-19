import SwiftUI
import StoreKit

struct PaywallView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedProductId: String = SubscriptionManager.yearlyProductId
    @State private var isPurchasing = false
    @State private var errorMessage: String?

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

                        // Feature list
                        VStack(alignment: .leading, spacing: 16) {
                            featureRow(icon: "brain.head.profile",
                                       title: cn ? "3个AI专属视角" : "3 Custom AI Perspectives",
                                       desc: cn ? "自定义视角+语气，AI为你量身生成鼓励" : "Custom perspectives + tone, AI generates unique encouragement")
                            featureRow(icon: "sparkles",
                                       title: cn ? "每次6个维度" : "6 Dimensions Per Session",
                                       desc: cn ? "3个AI视角 + 3个随机模版（免费版3-4个）" : "3 AI perspectives + 3 random templates (free: 3-4)")
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

                        // Plan picker — real StoreKit products
                        VStack(spacing: 12) {
                            if manager.products.isEmpty {
                                // Products still loading or unavailable
                                ProgressView()
                                    .padding()
                                Text(cn ? "正在加载价格…" : "Loading prices…")
                                    .font(ZenTheme.caption(13))
                                    .foregroundStyle(.secondary)
                            } else {
                                // Show yearly first (default selected), then monthly
                                ForEach(sortedProducts, id: \.id) { product in
                                    productButton(product)
                                }
                            }
                        }
                        .padding(.horizontal)

                        // Subscribe button
                        Button {
                            Task { await purchase() }
                        } label: {
                            Group {
                                if isPurchasing {
                                    ProgressView()
                                        .tint(ZenTheme.inkBlack)
                                } else {
                                    Text(cn ? "订阅" : "Subscribe")
                                        .font(ZenTheme.calligraphy(18))
                                        .foregroundStyle(ZenTheme.inkBlack)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(ZenTheme.gooseYellow)
                                    .shadow(color: ZenTheme.gooseYellow.opacity(0.4), radius: 12, y: 6)
                            )
                        }
                        .disabled(isPurchasing || manager.products.isEmpty)
                        .padding(.horizontal, 30)

                        // Restore
                        Button(cn ? "恢复购买" : "Restore Purchases") {
                            Task {
                                await manager.restorePurchases()
                                await MainActor.run { viewModel.syncSubscriptionStatus() }
                                if viewModel.isSubscribed {
                                    HapticManager.success()
                                    dismiss()
                                }
                            }
                        }
                        .font(ZenTheme.caption(13))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))

                        if let error = errorMessage {
                            Text(error)
                                .font(ZenTheme.caption(12))
                                .foregroundStyle(.red.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }

                        Text(cn
                             ? "订阅将通过 Apple ID 扣款，到期前24小时自动续费\n可随时在系统设置 > Apple ID > 订阅中取消"
                             : "Payment charged to Apple ID. Auto-renews 24hrs before expiry.\nCancel anytime in Settings > Apple ID > Subscriptions.")
                            .font(ZenTheme.caption(11))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
                            .multilineTextAlignment(.center)
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

    // MARK: - Sorted products (yearly first)

    private var sortedProducts: [Product] {
        manager.products.sorted { a, _ in a.id == SubscriptionManager.yearlyProductId }
    }

    // MARK: - Product button

    private func productButton(_ product: Product) -> some View {
        let isSelected = selectedProductId == product.id
        let isYearly = product.id == SubscriptionManager.yearlyProductId

        return Button {
            withAnimation { selectedProductId = product.id }
            HapticManager.selection()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text(isYearly ? (cn ? "年度订阅" : "Yearly") : (cn ? "月度订阅" : "Monthly"))
                            .font(ZenTheme.bodyFont(15))
                            .foregroundStyle(ZenTheme.inkBlack)

                        if isYearly {
                            Text(savingsPercent)
                                .font(ZenTheme.caption(11))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Capsule().fill(ZenTheme.gooseYellow))
                        }
                    }

                    if isYearly {
                        Text(monthlyEquivalent(for: product))
                            .font(ZenTheme.caption(11))
                            .foregroundStyle(ZenTheme.gooseYellow)
                    }
                }

                Spacer()

                Text(priceLabel(for: product, yearly: isYearly))
                    .font(ZenTheme.calligraphy(16))
                    .foregroundStyle(ZenTheme.inkBlack)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? ZenTheme.gooseYellow.opacity(0.15) : .white.opacity(0.5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? ZenTheme.gooseYellow : ZenTheme.distantMountain.opacity(0.1),
                                    lineWidth: isSelected ? 2 : 1)
                    )
            )
        }
    }

    // MARK: - Price formatting

    /// Show price in CNY when Chinese, otherwise use StoreKit's displayPrice (real App Store currency).
    private func priceLabel(for product: Product, yearly: Bool) -> String {
        let price = localizedPrice(for: product)
        let suffix = yearly ? (cn ? "/年" : "/yr") : (cn ? "/月" : "/mo")
        return price + suffix
    }

    private func localizedPrice(for product: Product) -> String {
        if cn {
            // Show CNY reference price for Chinese users
            let cny: Decimal = product.id == SubscriptionManager.yearlyProductId ? 98 : 12
            return "¥\(cny)"
        }
        // Non-Chinese: use StoreKit's displayPrice (actual App Store currency)
        return product.displayPrice
    }

    private func monthlyEquivalent(for product: Product) -> String {
        if cn {
            return "≈¥8.2/月"
        }
        let monthly = product.price / 12
        let formatted = monthly.formatted(.currency(code: product.priceFormatStyle.currencyCode ?? "USD"))
        return "≈\(formatted)/mo"
    }

    private var savingsPercent: String {
        // ¥98/yr vs ¥12*12=¥144/yr → save 32%
        // $39.99/yr vs $4.99*12=$59.88/yr → save 33%
        cn ? "省32%" : "Save 33%"
    }

    // MARK: - Purchase

    private func purchase() async {
        guard let product = manager.products.first(where: { $0.id == selectedProductId }) else { return }
        isPurchasing = true
        errorMessage = nil

        do {
            let success = try await manager.purchase(product)
            if success {
                await MainActor.run { viewModel.syncSubscriptionStatus() }
                HapticManager.success()
                dismiss()
            }
        } catch {
            errorMessage = cn ? "购买失败，请重试" : "Purchase failed, please try again"
            HapticManager.error()
        }

        isPurchasing = false
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
