import SwiftUI
import PhotosUI

struct ProfileSetupView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @State private var nickname = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var isSubmitting = false
    @State private var showError = false
    @State private var errorMessage = ""

    private var cn: Bool { viewModel.L.isChinese }

    private let defaultNicknames = [
        "无名散人", "云游客", "观自在", "随风行者", "听雨人",
        "Wanderer", "Seeker", "Dreamer", "Observer", "Traveler"
    ]

    var body: some View {
        ZStack {
            ZenBackground()

            VStack(spacing: 28) {
                Spacer()

                Text(cn ? "设置你的修行档案" : "Set Up Your Profile")
                    .font(ZenTheme.calligraphy(24))
                    .foregroundStyle(ZenTheme.inkBlack)

                // Avatar
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    ZStack {
                        if let avatarImage {
                            avatarImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(ZenTheme.distantMountain.opacity(0.1))
                                .frame(width: 80, height: 80)
                                .overlay {
                                    Image(systemName: "person.crop.circle.badge.plus")
                                        .font(.system(size: 30))
                                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                                }
                        }
                    }
                }
                .onChange(of: selectedPhoto) { _, item in
                    Task {
                        if let data = try? await item?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            avatarImage = Image(uiImage: uiImage)
                        }
                    }
                }

                Text(cn ? "点击选择头像" : "Tap to choose avatar")
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(.secondary)

                // Nickname
                VStack(alignment: .leading, spacing: 8) {
                    Text(cn ? "你的法号" : "Your nickname")
                        .font(ZenTheme.caption(12))
                        .foregroundStyle(.secondary)

                    TextField(cn ? "输入昵称" : "Enter nickname", text: $nickname)
                        .font(ZenTheme.bodyFont(17))
                        .multilineTextAlignment(.center)
                        .padding(14)
                        .background(RoundedRectangle(cornerRadius: 12).fill(.white))

                    // Random suggestion
                    Button(cn ? "随机一个" : "Random") {
                        let pool = cn ? defaultNicknames.prefix(5) : defaultNicknames.suffix(5)
                        nickname = pool.randomElement() ?? "Wanderer"
                    }
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.gooseYellow)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal, 40)

                Spacer()

                // Submit
                Button {
                    Task { await submit() }
                } label: {
                    HStack(spacing: 8) {
                        if isSubmitting {
                            ProgressView().tint(ZenTheme.gooseYellow)
                        }
                        Text(cn ? "开始修行" : "Begin")
                    }
                    .font(ZenTheme.calligraphy(18))
                    .foregroundStyle(ZenTheme.gooseYellow)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 14).fill(ZenTheme.inkBlack))
                }
                .disabled(nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSubmitting)
                .padding(.horizontal, 40)

                Spacer().frame(height: 40)
            }
        }
        .alert(cn ? "提示" : "Notice", isPresented: $showError) {
            Button(cn ? "知道了" : "OK") {}
        } message: {
            Text(errorMessage)
        }
        .onAppear {
            // Set a random default nickname
            let pool = cn ? defaultNicknames.prefix(5) : defaultNicknames.suffix(5)
            nickname = pool.randomElement() ?? "Wanderer"
        }
    }

    private func submit() async {
        isSubmitting = true
        defer { isSubmitting = false }

        let trimmed = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        do {
            // TODO: Upload avatar to Supabase Storage and get URL
            try await viewModel.authManager.createProfile(nickname: trimmed, avatarUrl: nil)
            HapticManager.success()
        } catch {
            errorMessage = (cn ? "设置失败: " : "Setup failed: ") + error.localizedDescription
            showError = true
            HapticManager.error()
        }
    }
}
