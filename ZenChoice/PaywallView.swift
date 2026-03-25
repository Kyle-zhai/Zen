import SwiftUI
import StoreKit

struct PaywallView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedProductId: String = SubscriptionManager.yearlyProductId
    @State private var isPurchasing = false
    @State private var errorMessage: String?
    @State private var isLoadingProducts = false
    @State private var hasAttemptedLoad = false

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

                        // Plan picker
                        VStack(spacing: 12) {
                            if isLoadingProducts {
                                ProgressView()
                                    .padding()
                                Text(cn ? "正在加载价格…" : "Loading prices…")
                                    .font(ZenTheme.caption(13))
                                    .foregroundStyle(.secondary)
                            } else if manager.products.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: "wifi.exclamationmark")
                                        .font(.title2)
                                        .foregroundStyle(.secondary)
                                    Text(cn ? "无法加载订阅产品，请检查网络后重试" : "Unable to load products. Please check your connection and try again.")
                                        .font(ZenTheme.bodyFont(14))
                                        .foregroundStyle(.secondary)
                                        .multilineTextAlignment(.center)
                                    Button(cn ? "重试" : "Retry") {
                                        Task { await loadProducts() }
                                    }
                                    .font(ZenTheme.bodyFont(14))
                                    .foregroundStyle(ZenTheme.gooseYellow)
                                }
                                .padding()
                            } else {
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
                                    Text(subscribeButtonLabel)
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
                        .disabled(isPurchasing || manager.products.isEmpty || isLoadingProducts)
                        .opacity(manager.products.isEmpty || isLoadingProducts ? 0.5 : 1)
                        .padding(.horizontal, 30)

                        // Restore
                        Button(cn ? "恢复购买" : "Restore Purchases") {
                            Task {
                                await manager.restorePurchases()
                                await MainActor.run { viewModel.syncSubscriptionStatus() }
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
            .task {
                guard !hasAttemptedLoad else { return }
                hasAttemptedLoad = true
                if manager.products.isEmpty {
                    await loadProducts()
                }
            }
        }
    }

    // MARK: - Load products (with 10s UI timeout)

    private func loadProducts() async {
        isLoadingProducts = true

        // Separate timeout task: if loadProducts() hangs (e.g. StoreKit
        // doesn't respond to cancellation), the spinner still stops after 10s.
        let timeoutTask = Task {
            try? await Task.sleep(for: .seconds(10))
            await MainActor.run {
                if isLoadingProducts {
                    isLoadingProducts = false
                }
            }
        }

        await manager.loadProducts()

        // Loading finished before timeout — cancel the timer
        timeoutTask.cancel()
        isLoadingProducts = false
    }

    // MARK: - Labels

    private var currentPlanLabel: String {
        switch viewModel.subscriptionStatus {
        case .free: return ""
        case .monthly: return cn ? "当前：月度订阅" : "Current: Monthly"
        case .yearly: return cn ? "当前：年度订阅" : "Current: Yearly"
        }
    }

    private var subscribeButtonLabel: String {
        if viewModel.subscriptionStatus == .monthly && selectedProductId == SubscriptionManager.yearlyProductId {
            return cn ? "升级到年度" : "Upgrade to Yearly"
        }
        return cn ? "订阅" : "Subscribe"
    }

    // MARK: - Sorted products (yearly first)

    private var sortedProducts: [Product] {
        manager.products.sorted { a, _ in a.id == SubscriptionManager.yearlyProductId }
    }

    // MARK: - Product button

    private func productButton(_ product: Product) -> some View {
        let isSelected = selectedProductId == product.id
        let isYearly = product.id == SubscriptionManager.yearlyProductId
        let isCurrent = (isYearly && viewModel.subscriptionStatus == .yearly) ||
                        (!isYearly && viewModel.subscriptionStatus == .monthly)

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

                        if isCurrent {
                            Text(cn ? "当前" : "Current")
                                .font(ZenTheme.caption(10))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Capsule().fill(.green))
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

    private func priceLabel(for product: Product, yearly: Bool) -> String {
        let price = product.displayPrice
        let suffix = yearly ? (cn ? "/年" : "/yr") : (cn ? "/月" : "/mo")
        return price + suffix
    }

    private func monthlyEquivalent(for product: Product) -> String {
        let monthly = product.price / 12
        let formatted = monthly.formatted(.currency(code: product.priceFormatStyle.currencyCode ?? "USD"))
        let suffix = cn ? "/月" : "/mo"
        return "≈\(formatted)\(suffix)"
    }

    private var savingsPercent: String {
        guard let yearly = manager.yearlyProduct, let monthly = manager.monthlyProduct else {
            return cn ? "省33%" : "Save 33%"
        }
        let yearlyDouble = NSDecimalNumber(decimal: yearly.price).doubleValue
        let monthlyDouble = NSDecimalNumber(decimal: monthly.price).doubleValue * 12
        guard monthlyDouble > 0 else { return "" }
        let pct = Int(((monthlyDouble - yearlyDouble) / monthlyDouble) * 100)
        return cn ? "省\(pct)%" : "Save \(pct)%"
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
