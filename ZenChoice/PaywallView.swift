import SwiftUI

struct PaywallView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPlan: Plan = .yearly

    enum Plan: String, CaseIterable {
        case monthly, yearly

        var title: String {
            switch self {
            case .monthly: return "月度订阅"
            case .yearly: return "年度订阅"
            }
        }

        var price: String {
            switch self {
            case .monthly: return "¥18/月"
            case .yearly: return "¥128/年"
            }
        }

        var priceSubtitle: String? {
            switch self {
            case .monthly: return nil
            case .yearly: return "约¥10.7/月，省41%"
            }
        }
    }

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
                            .shadow(
                                color: ZenTheme.gooseYellow.opacity(0.4),
                                radius: 20
                            )

                        VStack(spacing: 6) {
                            Text("解锁完整体验")
                                .font(ZenTheme.calligraphy(24))
                                .foregroundStyle(ZenTheme.inkBlack)
                            Text("让每次鼓励都独一无二")
                                .font(ZenTheme.bodyFont(15))
                                .foregroundStyle(
                                    ZenTheme.distantMountain.opacity(0.6)
                                )
                        }

                        // Feature comparison
                        VStack(alignment: .leading, spacing: 16) {
                            featureRow(
                                icon: "brain.head.profile",
                                title: "AI个性化生成",
                                desc: "每次生成独一无二的鼓励，永不重复"
                            )
                            featureRow(
                                icon: "slider.horizontal.3",
                                title: "自选维度与语气",
                                desc: "选择你喜欢的视角和表达风格"
                            )
                            featureRow(
                                icon: "plus.circle",
                                title: "更多维度",
                                desc: "每次获得5+个维度的鼓励（免费版3-4个）"
                            )
                            featureRow(
                                icon: "book.closed",
                                title: "勇气档案 + 年度报告",
                                desc: "回顾你的每一次勇敢，生成年度勇气卡片"
                            )
                            featureRow(
                                icon: "paintbrush",
                                title: "自定义金句卡",
                                desc: "个性化字体与背景样式"
                            )
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.white.opacity(0.7))
                        )
                        .padding(.horizontal)

                        // Plan picker
                        VStack(spacing: 12) {
                            ForEach(Plan.allCases, id: \.self) { plan in
                                planButton(plan)
                            }
                        }
                        .padding(.horizontal)

                        // Subscribe button
                        Button {
                            // TODO: Integrate StoreKit 2 purchase
                            viewModel.subscriptionStatus = selectedPlan == .monthly ? .monthly : .yearly
                            HapticManager.success()
                            dismiss()
                        } label: {
                            Text("订阅")
                                .font(ZenTheme.calligraphy(18))
                                .foregroundStyle(ZenTheme.inkBlack)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(ZenTheme.gooseYellow)
                                        .shadow(
                                            color: ZenTheme.gooseYellow.opacity(0.4),
                                            radius: 12, y: 6
                                        )
                                )
                        }
                        .padding(.horizontal, 30)

                        Button("恢复购买") {
                            // TODO: Restore StoreKit 2 purchases
                            HapticManager.selection()
                        }
                        .font(ZenTheme.caption(13))
                        .foregroundStyle(
                            ZenTheme.distantMountain.opacity(0.5)
                        )

                        Text("本功能为娱乐性质，仅供参考\n订阅可随时在系统设置中取消")
                            .font(ZenTheme.caption(11))
                            .foregroundStyle(
                                ZenTheme.distantMountain.opacity(0.3)
                            )
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(
                                ZenTheme.distantMountain.opacity(0.4)
                            )
                    }
                }
            }
        }
    }

    private func planButton(_ plan: Plan) -> some View {
        Button {
            withAnimation { selectedPlan = plan }
            HapticManager.selection()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(plan.title)
                        .font(ZenTheme.bodyFont(15))
                        .foregroundStyle(ZenTheme.inkBlack)
                    if let sub = plan.priceSubtitle {
                        Text(sub)
                            .font(ZenTheme.caption(11))
                            .foregroundStyle(ZenTheme.gooseYellow)
                    }
                }
                Spacer()
                Text(plan.price)
                    .font(ZenTheme.calligraphy(16))
                    .foregroundStyle(ZenTheme.inkBlack)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(selectedPlan == plan ? ZenTheme.gooseYellow.opacity(0.15) : .white.opacity(0.5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                selectedPlan == plan ? ZenTheme.gooseYellow : ZenTheme.distantMountain.opacity(0.1),
                                lineWidth: selectedPlan == plan ? 2 : 1
                            )
                    )
            )
        }
    }

    private func featureRow(
        icon: String, title: String, desc: String
    ) -> some View {
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
