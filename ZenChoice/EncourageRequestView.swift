import SwiftUI

struct EncourageRequestView: View {
    @Environment(\.dismiss) private var dismiss
    let wish: String
    let socialManager: SocialManager
    let isChinese: Bool
    let isSubscribed: Bool

    @State private var isCreating = false
    @State private var createdRequest: CourageRequest?
    @State private var showError = false

    private var cn: Bool { isChinese }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "hands.sparkles")
                    .font(.system(size: 48))
                    .foregroundStyle(ZenTheme.gooseYellow)

                Text("「\(wish)」")
                    .font(ZenTheme.calligraphy(20))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .multilineTextAlignment(.center)

                Text(cn ? "邀请朋友为你加持" : "Invite friends to bless you")
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))

                if let request = createdRequest {
                    ShareLink(item: socialManager.shareLink(for: request)) {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                            Text(cn ? "分享给朋友" : "Share with friends")
                        }
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 14).fill(ZenTheme.inkBlack))
                    }
                    .padding(.horizontal, 40)

                    Text(cn ? "朋友打开链接即可为你加持" : "Friends can bless you by opening the link")
                        .font(ZenTheme.caption(12))
                        .foregroundStyle(.secondary)
                } else {
                    Button {
                        Task { await createRequest() }
                    } label: {
                        HStack(spacing: 8) {
                            if isCreating {
                                ProgressView().tint(ZenTheme.gooseYellow)
                            }
                            Text(cn ? "生成加持链接" : "Generate blessing link")
                        }
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(ZenTheme.gooseYellow, lineWidth: 1.5)
                        )
                    }
                    .disabled(isCreating)
                    .padding(.horizontal, 40)
                }

                Spacer()
            }
            .background(ZenBackground())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray.opacity(0.6))
                    }
                }
            }
            .alert(cn ? "创建失败" : "Failed", isPresented: $showError) {
                Button(cn ? "知道了" : "OK") {}
            } message: {
                Text(cn ? "请检查网络后重试" : "Please check your connection and retry")
            }
        }
    }

    private func createRequest() async {
        isCreating = true
        defer { isCreating = false }

        do {
            createdRequest = try await socialManager.createRequest(
                type: .encourage,
                wish: wish,
                aiSummary: nil,
                maxResponses: 99
            )
            HapticManager.success()
        } catch {
            showError = true
            HapticManager.error()
        }
    }
}
