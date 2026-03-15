import SwiftUI

struct SettingsView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State private var localShowPaywall = false

    var body: some View {
        @Bindable var vm = viewModel

        NavigationStack {
            Form {
                Section("个人信息") {
                    TextField("你的名字", text: $vm.userName)
                }

                Section {
                    Button {
                        Task {
                            await viewModel.syncProfile()
                            HapticManager.success()
                        }
                    } label: {
                        Label("同步资料到云端", systemImage: "icloud.and.arrow.up")
                    }
                }

                Section("订阅") {
                    HStack {
                        Label("订阅状态", systemImage: "sparkle")
                        Spacer()
                        Text(subscriptionLabel)
                            .foregroundStyle(viewModel.isSubscribed ? .green : .secondary)
                    }

                    if !viewModel.isSubscribed {
                        Button("升级订阅") {
                            localShowPaywall = true
                        }
                    }
                }

                Section("免责声明") {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("娱乐性质说明", systemImage: "info.circle")
                            .font(.headline)

                        Text("""
                        「禅择 ZenChoice」是一款以娱乐为目的的趣味鼓励应用。\
                        本 App 所提供的所有鼓励内容为算法或AI生成，\
                        仅供娱乐参考，不构成任何专业建议。

                        请勿将本 App 的结果作为实际决策的唯一依据。\
                        对于因使用本 App 产生的任何后果，开发者不承担任何责任。

                        如有心理健康方面的困扰，请寻求专业人士帮助。
                        """)
                        .font(ZenTheme.caption(12))
                        .foregroundStyle(.secondary)
                        .lineSpacing(3)
                    }
                    .padding(.vertical, 4)
                }

                Section("关于") {
                    LabeledContent("版本", value: "2.0.0")
                    LabeledContent("开发者", value: "Kyle")
                }
            }
            .navigationTitle("设置")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") { dismiss() }
                }
            }
            .sheet(isPresented: $localShowPaywall) {
                PaywallView().environment(viewModel)
            }
        }
    }

    private var subscriptionLabel: String {
        switch viewModel.subscriptionStatus {
        case .free: return "免费版"
        case .monthly: return "月度订阅"
        case .yearly: return "年度订阅"
        }
    }
}

#Preview {
    SettingsView()
        .environment(ZenViewModel())
}
