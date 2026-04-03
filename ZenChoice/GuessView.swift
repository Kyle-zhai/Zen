import SwiftUI

struct GuessView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    let encouragement: AnonymousEncouragement

    @State private var selectedFriendId: String?
    @State private var isSubmitting = false
    @State private var result: GuessResult?

    private var cn: Bool { viewModel.L.isChinese }

    enum GuessResult {
        case correct(String) // friend nickname
        case wrong
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ZenBackground()

                if let result {
                    resultView(result)
                } else {
                    guessSelectionView
                }
            }
            .navigationTitle(cn ? "猜猜是谁" : "Guess Who")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(cn ? "关闭" : "Close") { dismiss() }
                }
            }
        }
    }

    // MARK: - Selection

    private var guessSelectionView: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "questionmark.circle")
                .font(.system(size: 44))
                .foregroundStyle(ZenTheme.gooseYellow)

            Text(cn ? "这段鼓励来自你的一位好友" : "This encouragement came from a friend")
                .font(ZenTheme.bodyFont(15))
                .foregroundStyle(ZenTheme.inkBlack)

            // Show the encouragement content
            Text("「\(encouragement.content)」")
                .font(ZenTheme.bodyFont(14))
                .foregroundStyle(ZenTheme.distantMountain)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(ZenTheme.gooseYellow.opacity(0.1))
                )
                .padding(.horizontal, 24)

            Text(cn ? "猜猜是谁写的？" : "Can you guess who wrote it?")
                .font(ZenTheme.caption(13))
                .foregroundStyle(.secondary)

            // Friend list to choose from
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.socialManager.friendDisplayList) { friend in
                        Button {
                            selectedFriendId = friend.userId
                        } label: {
                            HStack(spacing: 12) {
                                Circle()
                                    .fill(ZenTheme.distantMountain.opacity(0.1))
                                    .frame(width: 38, height: 38)
                                    .overlay {
                                        Text(String(friend.nickname.prefix(1)))
                                            .font(ZenTheme.calligraphy(16))
                                            .foregroundStyle(ZenTheme.inkBlack)
                                    }

                                Text(friend.nickname)
                                    .font(ZenTheme.bodyFont(15))
                                    .foregroundStyle(ZenTheme.inkBlack)

                                Spacer()

                                if selectedFriendId == friend.userId {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(ZenTheme.gooseYellow)
                                }
                            }
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selectedFriendId == friend.userId
                                          ? ZenTheme.gooseYellow.opacity(0.1)
                                          : .white.opacity(0.6))
                            )
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            .frame(maxHeight: 260)

            // Submit guess
            Button {
                Task { await submitGuess() }
            } label: {
                HStack(spacing: 8) {
                    if isSubmitting {
                        ProgressView().tint(ZenTheme.gooseYellow)
                    }
                    Text(cn ? "确认猜测" : "Confirm Guess")
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
            .disabled(selectedFriendId == nil || isSubmitting)
            .padding(.horizontal, 24)

            // Skip
            Button(cn ? "跳过" : "Skip") {
                dismiss()
            }
            .font(ZenTheme.caption(13))
            .foregroundStyle(.secondary)

            Spacer()
        }
    }

    // MARK: - Result

    private func resultView(_ result: GuessResult) -> some View {
        VStack(spacing: 20) {
            Spacer()

            switch result {
            case .correct(let nickname):
                Image(systemName: "sparkles")
                    .font(.system(size: 56))
                    .foregroundStyle(ZenTheme.gooseYellow)

                Text(cn ? "猜对了！" : "Correct!")
                    .font(ZenTheme.calligraphy(24))
                    .foregroundStyle(ZenTheme.inkBlack)

                Text(cn ? "是 \(nickname) 给你的鼓励" : "It was from \(nickname)")
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.distantMountain)

                Text(cn ? "共鸣 +1 ✨" : "Resonance +1 ✨")
                    .font(ZenTheme.bodyFont(14))
                    .foregroundStyle(ZenTheme.gooseYellow)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(ZenTheme.gooseYellow.opacity(0.1))
                    )

            case .wrong:
                Image(systemName: "face.smiling")
                    .font(.system(size: 56))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))

                Text(cn ? "没猜对" : "Not quite")
                    .font(ZenTheme.calligraphy(24))
                    .foregroundStyle(ZenTheme.inkBlack)

                Text(cn ? "这位好友的身份保持神秘" : "This friend remains a mystery")
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.distantMountain)
            }

            Button(cn ? "完成" : "Done") { dismiss() }
                .font(ZenTheme.calligraphy(16))
                .foregroundStyle(ZenTheme.gooseYellow)
                .padding(.top, 16)

            Spacer()
        }
    }

    // MARK: - Action

    private func submitGuess() async {
        guard let guessId = selectedFriendId else { return }
        isSubmitting = true
        defer { isSubmitting = false }

        do {
            let correct = try await viewModel.socialManager.guessEncourager(
                encouragementId: encouragement.id,
                guessedUserId: guessId
            )

            if correct {
                let nickname = viewModel.socialManager.friendDisplayList
                    .first(where: { $0.userId == guessId })?.nickname ?? "?"
                result = .correct(nickname)
                HapticManager.success()
            } else {
                result = .wrong
                HapticManager.impact()
            }
        } catch {
            result = .wrong
        }
    }
}
