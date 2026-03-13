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
                    DatePicker(
                        "出生日期",
                        selection: $vm.birthDate,
                        displayedComponents: .date
                    )
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

                Section("会员") {
                    HStack {
                        Label("禅择 · 深度", systemImage: "sparkle")
                        Spacer()
                        Text(viewModel.isPaid ? "已解锁" : "未解锁")
                            .foregroundStyle(viewModel.isPaid ? .green : .secondary)
                    }

                    if !viewModel.isPaid {
                        Button("解锁深度报告") {
                            localShowPaywall = true
                        }
                    }
                }

                Section("免责声明") {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("娱乐性质说明", systemImage: "info.circle")
                            .font(.headline)

                        Text("""
                        「禅择 ZenChoice」是一款以娱乐为目的的趣味择日应用。\
                        本 App 所提供的所有择日建议、命理分析、玄学报告均为算法随机生成，\
                        不具备任何科学依据或真实预测能力。

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
                    LabeledContent("版本", value: "1.0.0")
                    LabeledContent("开发者", value: "Kyle")
                    LabeledContent("引擎", value: "禅择玄学引擎 v3.14")
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
}

#Preview {
    SettingsView()
        .environment(ZenViewModel())
}
