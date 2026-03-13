import SwiftUI

struct PaywallView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                ZenBackground()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {
                        Spacer().frame(height: 20)

                        Image(systemName: "sparkle")
                            .font(.system(size: 54))
                            .foregroundStyle(ZenTheme.gooseYellow)
                            .shadow(
                                color: ZenTheme.gooseYellow.opacity(0.4),
                                radius: 20
                            )

                        VStack(spacing: 6) {
                            Text("解锁禅择 · 深度")
                                .font(ZenTheme.calligraphy(26))
                                .foregroundStyle(ZenTheme.inkBlack)
                            Text("探索属于你的八字玄机")
                                .font(ZenTheme.bodyFont(15))
                                .foregroundStyle(
                                    ZenTheme.distantMountain.opacity(0.6)
                                )
                        }

                        VStack(alignment: .leading, spacing: 18) {
                            featureRow(
                                icon: "scroll.fill",
                                title: "玄学深度报告",
                                desc: "专业八字命理分析，解读天干地支奥秘"
                            )
                            featureRow(
                                icon: "clock.badge.checkmark.fill",
                                title: "精准吉时推荐",
                                desc: "精确到时辰的最佳行动窗口"
                            )
                            featureRow(
                                icon: "paintpalette.fill",
                                title: "五行调和指南",
                                desc: "着装、方位、饮食一站式开运建议"
                            )
                            featureRow(
                                icon: "infinity",
                                title: "无限次择日",
                                desc: "不限次数，随时随地求签问卦"
                            )
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.white.opacity(0.7))
                        )
                        .padding(.horizontal)

                        Button {
                            viewModel.isPaid = true
                            HapticManager.success()
                            dismiss()
                        } label: {
                            VStack(spacing: 4) {
                                Text("开启禅境")
                                    .font(ZenTheme.calligraphy(18))
                                Text("¥18.00 / 永久")
                                    .font(ZenTheme.caption(12))
                                    .opacity(0.7)
                            }
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

                        Button("恢复购买") { HapticManager.selection() }
                            .font(ZenTheme.caption(13))
                            .foregroundStyle(
                                ZenTheme.distantMountain.opacity(0.5)
                            )

                        Text("本功能为娱乐性质，仅供参考\n购买前请确认了解产品内容")
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
