import SwiftUI

struct AnonymousEncourageView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    let friend: FriendDisplay

    @State private var content = ""
    @State private var isSubmitting = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var sent = false

    private var cn: Bool { viewModel.L.isChinese }

    var body: some View {
        NavigationStack {
            ZStack {
                ZenBackground()

                if sent {
                    sentConfirmation
                } else {
                    composeView
                }
            }
            .navigationTitle(cn ? "匿名鼓励" : "Anonymous Encouragement")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(cn ? "关闭" : "Close") { dismiss() }
                }
            }
            .alert(cn ? "提示" : "Notice", isPresented: $showError) {
                Button(cn ? "知道了" : "OK") {}
            } message: {
                Text(errorMessage)
            }
        }
    }

    // MARK: - Compose

    private var composeView: some View {
        VStack(spacing: 24) {
            Spacer()

            // Recipient
            VStack(spacing: 8) {
                Circle()
                    .fill(ZenTheme.distantMountain.opacity(0.1))
                    .frame(width: 56, height: 56)
                    .overlay {
                        Text(String(friend.nickname.prefix(1)))
                            .font(ZenTheme.calligraphy(22))
                            .foregroundStyle(ZenTheme.inkBlack)
                    }

                Text(cn ? "给 \(friend.nickname) 写一段匿名鼓励" : "Write anonymous encouragement for \(friend.nickname)")
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .multilineTextAlignment(.center)

                Text(cn ? "对方会在下次「获知真相」时收到\nta可以猜猜是谁写的" : "They'll see this next time they reveal the truth\nand can guess who wrote it")
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            // Text input
            TextEditor(text: $content)
                .font(ZenTheme.bodyFont(16))
                .frame(height: 120)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(ZenTheme.distantMountain.opacity(0.15), lineWidth: 1)
                )
                .padding(.horizontal, 24)

            Text("\(content.count)/200")
                .font(ZenTheme.caption(11))
                .foregroundStyle(content.count > 200 ? .red : .secondary)

            // Send button
            Button {
                Task { await send() }
            } label: {
                HStack(spacing: 8) {
                    if isSubmitting {
                        ProgressView().tint(ZenTheme.gooseYellow)
                    }
                    Text(cn ? "匿名送出" : "Send Anonymously")
                }
                .font(ZenTheme.calligraphy(16))
                .foregroundStyle(ZenTheme.gooseYellow)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(ZenTheme.inkBlack)
                )
            }
            .disabled(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || content.count > 200 || isSubmitting)
            .padding(.horizontal, 24)

            Spacer()
        }
    }

    // MARK: - Sent Confirmation

    private var sentConfirmation: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 56))
                .foregroundStyle(ZenTheme.gooseYellow)

            Text(cn ? "鼓励已匿名送出" : "Encouragement sent anonymously")
                .font(ZenTheme.bodyFont(17))
                .foregroundStyle(ZenTheme.inkBlack)

            Text(cn ? "\(friend.nickname) 会在下次获知真相时收到" : "\(friend.nickname) will see it next time they reveal the truth")
                .font(ZenTheme.caption(13))
                .foregroundStyle(.secondary)

            Button(cn ? "完成" : "Done") { dismiss() }
                .font(ZenTheme.calligraphy(16))
                .foregroundStyle(ZenTheme.gooseYellow)
                .padding(.top, 16)

            Spacer()
        }
    }

    // MARK: - Action

    private func send() async {
        isSubmitting = true
        defer { isSubmitting = false }

        let trimmed = content.trimmingCharacters(in: .whitespacesAndNewlines)
        do {
            try await viewModel.socialManager.sendAnonymousEncouragement(to: friend.userId, content: trimmed)
            HapticManager.success()
            sent = true
        } catch {
            errorMessage = cn ? "发送失败，请重试" : "Failed to send, please retry"
            showError = true
            HapticManager.error()
        }
    }
}
