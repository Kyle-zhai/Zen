import SwiftUI

struct RespondView: View {
    @Environment(\.dismiss) private var dismiss
    let request: CourageRequest
    let socialManager: SocialManager
    let isChinese: Bool

    @State private var content = ""
    @State private var selectedPerspective = ""
    @State private var customPerspective = ""
    @State private var isAnonymous = true
    @State private var senderName = ""
    @State private var isSubmitting = false
    @State private var showSuccess = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isGeneratingAI = false
    // Witness: custom perspective input
    @State private var witnessPerspective = ""

    private var cn: Bool { isChinese }

    private let perspectives = [
        ("毒舌闺蜜", "Sassy BFF"),
        ("慈祥奶奶", "Loving Grandma"),
        ("未来的ta", "Future Self"),
        ("哲学家", "Philosopher"),
        ("段子手", "Comedian")
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                if request.type == .witness {
                    witnessBody
                } else {
                    encourageBody
                }
            }
            .background(ZenBackground())
            .navigationTitle(request.type == .encourage ? (cn ? "加持" : "Bless") : (cn ? "见证" : "Witness"))
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray.opacity(0.6))
                    }
                }
            }
            .alert(cn ? "提交成功" : "Submitted!", isPresented: $showSuccess) {
                Button(cn ? "好的" : "OK") { dismiss() }
            } message: {
                Text(request.type == .witness
                     ? (cn ? "你已见证了这一刻" : "You have witnessed this moment")
                     : (cn ? "你的加持已送达" : "Your blessing has been delivered"))
            }
            .alert(cn ? "提示" : "Notice", isPresented: $showError) {
                Button(cn ? "知道了" : "OK") {}
            } message: {
                Text(errorMessage)
            }
        }
    }

    // MARK: - Witness Body (real-name, custom perspective, no message/voice/stamp)

    private var witnessBody: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 40)

            // Seal illustration
            ZStack {
                Circle()
                    .fill(ZenTheme.mist.opacity(0.04))
                    .frame(width: 120, height: 120)
                Circle()
                    .stroke(ZenTheme.mist.opacity(0.12), lineWidth: 1.5)
                    .frame(width: 100, height: 100)
                Image(systemName: "signature")
                    .font(.system(size: 40))
                    .foregroundStyle(ZenTheme.mist.opacity(0.6))
            }

            Spacer().frame(height: 24)

            Text(cn ? "你的朋友做了一个决定" : "Your friend made a decision")
                .font(ZenTheme.bodyFont(14))
                .foregroundStyle(ZenTheme.mist.opacity(0.5))

            Spacer().frame(height: 12)

            Text("「\(request.wish)」")
                .font(ZenTheme.calligraphy(24))
                .foregroundStyle(ZenTheme.ricePaper)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer().frame(height: 8)

            Text(cn ? "ta 希望你为这个决定签名见证" : "They want you to sign off on this decision")
                .font(ZenTheme.bodyFont(13))
                .foregroundStyle(ZenTheme.mist.opacity(0.5))

            Spacer().frame(height: 32)

            // Custom perspective input
            VStack(alignment: .leading, spacing: 8) {
                Text(cn ? "你的身份视角（选填）" : "Your perspective (optional)")
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.mist.opacity(0.5))

                TextField(
                    cn ? "例如：室友、老战友、合伙人..." : "e.g. roommate, old friend, partner...",
                    text: $witnessPerspective
                )
                .font(ZenTheme.bodyFont(15))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 10).fill(ZenTheme.cardSurface))
            }
            .padding(.horizontal, 24)

            Spacer().frame(height: 32)

            // Confirm button
            Button {
                Task { await submitWitness() }
            } label: {
                HStack(spacing: 8) {
                    if isSubmitting {
                        ProgressView().tint(ZenTheme.ricePaper)
                    } else {
                        Image(systemName: "checkmark.seal")
                    }
                    Text(cn ? "确认见证" : "Confirm Witness")
                }
                .font(ZenTheme.calligraphy(16))
                .foregroundStyle(ZenTheme.ricePaper)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(RoundedRectangle(cornerRadius: 2).fill(ZenTheme.inkDark))
            }
            .disabled(isSubmitting)
            .padding(.horizontal, 24)

            Spacer().frame(height: 12)

            Text(cn ? "将以你的账户名实名见证" : "You will witness under your account name")
                .font(ZenTheme.caption(11))
                .foregroundStyle(ZenTheme.mist.opacity(0.4))

            Spacer().frame(height: 60)
        }
    }

    // MARK: - Encourage Body (perspective picker, text, AI ghostwrite, voice, identity)

    private var encourageBody: some View {
        VStack(spacing: 24) {
            // Header
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(ZenTheme.gooseYellow.opacity(0.12))
                        .frame(width: 80, height: 80)
                    Image(systemName: "hands.sparkles")
                        .font(.system(size: 32))
                        .foregroundStyle(ZenTheme.gooseYellow)
                }

                Text(cn ? "你的朋友想要" : "Your friend wants to")
                    .font(ZenTheme.bodyFont(14))
                    .foregroundStyle(ZenTheme.mist.opacity(0.5))

                Text("「\(request.wish)」")
                    .font(ZenTheme.calligraphy(22))
                    .foregroundStyle(ZenTheme.ricePaper)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                Text(cn ? "用你的视角为 ta 加持吧！" : "Send your blessing from a unique perspective!")
                    .font(ZenTheme.bodyFont(13))
                    .foregroundStyle(ZenTheme.gooseYellow)
            }
            .padding(.top, 20)

            // Perspective picker
            perspectivePicker

            // Text input
            VStack(alignment: .leading, spacing: 8) {
                Text(cn ? "写一句加持" : "Write your blessing")
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.mist.opacity(0.5))

                TextField(cn ? "写点什么..." : "Write something...", text: $content, axis: .vertical)
                    .font(ZenTheme.bodyFont(15))
                    .lineLimit(3...6)
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 2).fill(ZenTheme.cardSurface))

                // AI ghostwrite button
                Button {
                    Task { await generateAIContent() }
                } label: {
                    HStack(spacing: 6) {
                        if isGeneratingAI {
                            ProgressView().tint(ZenTheme.gooseYellow)
                        } else {
                            Image(systemName: "sparkles")
                        }
                        Text(cn ? "AI帮我写" : "AI ghostwrite")
                    }
                    .font(ZenTheme.caption(13))
                    .foregroundStyle(ZenTheme.gooseYellow)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Capsule().stroke(ZenTheme.gooseYellow.opacity(0.4)))
                }
                .disabled(isGeneratingAI)
            }
            .padding(.horizontal)

            // Anonymous / signed toggle
            identitySection

            // Submit button
            Button {
                Task { await submitEncourage() }
            } label: {
                HStack(spacing: 8) {
                    if isSubmitting {
                        ProgressView().tint(ZenTheme.gooseYellow)
                    }
                    Text(isAnonymous
                         ? (cn ? "匿名送出" : "Send anonymously")
                         : (cn ? "署名送出" : "Send with name"))
                }
                .font(ZenTheme.calligraphy(16))
                .foregroundStyle(ZenTheme.gooseYellow)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(RoundedRectangle(cornerRadius: 2).fill(ZenTheme.inkDark))
            }
            .disabled(content.isEmpty || isSubmitting)
            .padding(.horizontal)

            Spacer().frame(height: 40)
        }
    }

    // MARK: - Perspective Picker

    private var perspectivePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(cn ? "选一个身份视角" : "Pick a perspective")
                .font(ZenTheme.caption(12))
                .foregroundStyle(ZenTheme.mist.opacity(0.5))

            let columns = [GridItem(.adaptive(minimum: 90))]
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(perspectives, id: \.0) { zh, en in
                    let label = cn ? zh : en
                    let isSelected = selectedPerspective == label
                    Button {
                        selectedPerspective = label
                        customPerspective = ""
                    } label: {
                        Text(label)
                            .font(ZenTheme.caption(13))
                            .foregroundStyle(isSelected ? ZenTheme.ricePaper : ZenTheme.ricePaper.opacity(0.85))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(isSelected ? ZenTheme.inkDark : ZenTheme.cardSurface)
                            )
                    }
                }

                TextField(cn ? "自定义..." : "Custom...", text: $customPerspective)
                    .font(ZenTheme.caption(13))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(ZenTheme.cardSurface))
                    .onChange(of: customPerspective) { _, val in
                        if !val.isEmpty { selectedPerspective = "" }
                    }
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Identity Section

    private var identitySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(cn ? "匿名" : "Anonymous", isOn: $isAnonymous)
                .font(ZenTheme.bodyFont(14))
                .tint(ZenTheme.gooseYellow)

            if !isAnonymous {
                TextField(cn ? "你的名字" : "Your name", text: $senderName)
                    .font(ZenTheme.bodyFont(15))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 8).fill(ZenTheme.cardSurface))
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Actions

    private func submitWitness() async {
        isSubmitting = true
        defer { isSubmitting = false }

        // Get sender's profile name for real-name witness
        let profileName = socialManager.authManager?.profile?.nickname ?? ""
        let perspective = witnessPerspective.trimmingCharacters(in: .whitespacesAndNewlines)

        do {
            try await socialManager.submitResponse(
                requestId: request.id,
                content: cn ? "我见证了这一刻" : "I witnessed this moment",
                perspective: perspective.isEmpty ? nil : perspective,
                emojiStamp: nil,
                voiceUrl: nil,
                isAnonymous: false,
                senderName: profileName
            )
            HapticManager.success()
            showSuccess = true
        } catch {
            errorMessage = error.localizedDescription
            showError = true
            HapticManager.error()
        }
    }

    private func submitEncourage() async {
        isSubmitting = true
        defer { isSubmitting = false }

        let perspective = customPerspective.isEmpty ? selectedPerspective : customPerspective

        do {
            try await socialManager.submitResponse(
                requestId: request.id,
                content: content,
                perspective: perspective.isEmpty ? nil : perspective,
                emojiStamp: nil,
                voiceUrl: nil,
                isAnonymous: isAnonymous,
                senderName: isAnonymous ? nil : senderName
            )
            HapticManager.success()
            showSuccess = true
        } catch {
            errorMessage = error.localizedDescription
            showError = true
            HapticManager.error()
        }
    }

    private func generateAIContent() async {
        let perspective = customPerspective.isEmpty ? selectedPerspective : customPerspective
        guard !perspective.isEmpty else {
            errorMessage = cn ? "请先选择一个视角" : "Please pick a perspective first"
            showError = true
            return
        }

        isGeneratingAI = true
        defer { isGeneratingAI = false }

        let provider = QwenProvider.shared
        let prompt = cn
            ? "用户想要「\(request.wish)」。请用「\(perspective)」的视角写一句简短有趣的鼓励，50字以内。"
            : "The user wants to \(request.wish). Write a short fun encouragement from the perspective of \"\(perspective)\", under 50 words."

        do {
            let result = try await provider.generate(prompt: prompt, perspectiveName: perspective, emoji: "")
            content = result.content
        } catch {
            errorMessage = cn ? "AI生成失败，请手动输入" : "AI generation failed, please type manually"
            showError = true
        }
    }
}
