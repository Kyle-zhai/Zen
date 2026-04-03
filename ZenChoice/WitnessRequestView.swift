import SwiftUI

struct WitnessRequestView: View {
    @Environment(\.dismiss) private var dismiss
    let wish: String
    let aiSummary: String
    let socialManager: SocialManager
    let isChinese: Bool
    let maxSignatures: Int

    @State private var isCreating = false
    @State private var createdRequest: CourageRequest?
    @State private var showError = false

    private var cn: Bool { isChinese }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "signature")
                    .font(.system(size: 48))
                    .foregroundStyle(ZenTheme.gooseYellow)

                Text("「\(wish)」")
                    .font(ZenTheme.calligraphy(20))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .multilineTextAlignment(.center)

                Text(cn
                     ? "邀请朋友见证你的决定（最多\(maxSignatures)人）"
                     : "Invite friends to witness (\(maxSignatures) max)")
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))

                Text(aiSummary)
                    .font(ZenTheme.bodyFont(13))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                    .lineLimit(3)
                    .padding(.horizontal, 24)
                    .multilineTextAlignment(.center)

                if let request = createdRequest {
                    ShareLink(item: socialManager.shareLink(for: request)) {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                            Text(cn ? "分享给见证人" : "Share with witnesses")
                        }
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 14).fill(ZenTheme.inkBlack))
                    }
                    .padding(.horizontal, 40)
                } else {
                    Button {
                        Task { await createRequest() }
                    } label: {
                        HStack(spacing: 8) {
                            if isCreating {
                                ProgressView().tint(ZenTheme.gooseYellow)
                            }
                            Text(cn ? "生成见证链接" : "Generate witness link")
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
                type: .witness,
                wish: wish,
                aiSummary: aiSummary,
                maxResponses: maxSignatures
            )
            HapticManager.success()
        } catch {
            showError = true
            HapticManager.error()
        }
    }
}
