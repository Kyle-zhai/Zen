import SwiftUI

struct RespondView: View {
    @Environment(\.dismiss) private var dismiss
    let request: CourageRequest
    let socialManager: SocialManager
    let isChinese: Bool

    @State private var content = ""
    @State private var selectedPerspective = ""
    @State private var customPerspective = ""
    @State private var emojiStamp = ""
    @State private var isAnonymous = true
    @State private var senderName = ""
    @State private var isSubmitting = false
    @State private var showSuccess = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var voiceRecorder = VoiceRecorder()
    @State private var isGeneratingAI = false

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
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text(cn ? "你的朋友想要" : "Your friend wants to")
                            .font(ZenTheme.bodyFont(15))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
                        Text("「\(request.wish)」")
                            .font(ZenTheme.calligraphy(22))
                            .foregroundStyle(ZenTheme.inkBlack)
                            .multilineTextAlignment(.center)
                        Text(request.type == .encourage
                             ? (cn ? "为 ta 加持吧！" : "Send your blessing!")
                             : (cn ? "为 ta 见证这一刻" : "Witness this moment"))
                            .font(ZenTheme.bodyFont(14))
                            .foregroundStyle(ZenTheme.gooseYellow)
                    }
                    .padding(.top, 20)

                    // AI Summary (witness only)
                    if request.type == .witness, let summary = request.aiSummary, !summary.isEmpty {
                        Text(summary)
                            .font(ZenTheme.bodyFont(13))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.7)))
                            .padding(.horizontal)
                    }

                    // Perspective picker (encourage only)
                    if request.type == .encourage {
                        perspectivePicker
                    }

                    // Text input
                    VStack(alignment: .leading, spacing: 8) {
                        Text(request.type == .encourage
                             ? (cn ? "写一句加持" : "Write your blessing")
                             : (cn ? "写一句寄语" : "Leave a message"))
                            .font(ZenTheme.caption(12))
                            .foregroundStyle(.secondary)

                        TextField(cn ? "写点什么..." : "Write something...", text: $content, axis: .vertical)
                            .font(ZenTheme.bodyFont(15))
                            .lineLimit(3...6)
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.white))

                        // AI ghostwrite button (encourage only)
                        if request.type == .encourage {
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
                                .background(Capsule().stroke(ZenTheme.gooseYellow.opacity(0.5)))
                            }
                            .disabled(isGeneratingAI)
                        }
                    }
                    .padding(.horizontal)

                    // Emoji stamp (witness only)
                    if request.type == .witness {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(cn ? "选一个印章" : "Pick a stamp")
                                .font(ZenTheme.caption(12))
                                .foregroundStyle(.secondary)
                            TextField("emoji", text: $emojiStamp)
                                .font(.system(size: 40))
                                .frame(width: 60, height: 60)
                                .multilineTextAlignment(.center)
                                .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                        }
                        .padding(.horizontal)
                    }

                    // Voice recorder
                    voiceSection

                    // Anonymous / signed toggle
                    identitySection

                    // Submit button
                    Button {
                        Task { await submit() }
                    } label: {
                        HStack(spacing: 8) {
                            if isSubmitting {
                                ProgressView().tint(.white)
                            }
                            Text(isAnonymous
                                 ? (cn ? "匿名提交" : "Submit anonymously")
                                 : (cn ? "署名提交" : "Submit with name"))
                        }
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 14).fill(ZenTheme.inkBlack))
                    }
                    .disabled(content.isEmpty || isSubmitting)
                    .padding(.horizontal)

                    Spacer().frame(height: 40)
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
                Text(cn ? "你的加持已送达" : "Your blessing has been delivered")
            }
            .alert(cn ? "提示" : "Notice", isPresented: $showError) {
                Button(cn ? "知道了" : "OK") {}
            } message: {
                Text(errorMessage)
            }
        }
    }

    // MARK: - Perspective Picker

    private var perspectivePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(cn ? "选一个身份视角" : "Pick a perspective")
                .font(ZenTheme.caption(12))
                .foregroundStyle(.secondary)

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
                            .foregroundStyle(isSelected ? .white : ZenTheme.inkBlack)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(isSelected ? ZenTheme.inkBlack : .white)
                            )
                    }
                }

                // Custom input
                TextField(cn ? "自定义..." : "Custom...", text: $customPerspective)
                    .font(ZenTheme.caption(13))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                    .onChange(of: customPerspective) { _, val in
                        if !val.isEmpty { selectedPerspective = "" }
                    }
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Voice Section

    private var voiceSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(cn ? "录一段语音（可选，15秒）" : "Record voice (optional, 15s)")
                .font(ZenTheme.caption(12))
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                if voiceRecorder.isRecording {
                    Button { voiceRecorder.stopRecording() } label: {
                        Label(String(format: "%.1fs", voiceRecorder.recordingDuration), systemImage: "stop.circle.fill")
                            .foregroundStyle(.red)
                    }
                } else if voiceRecorder.recordedFileURL != nil {
                    Button {
                        if voiceRecorder.isPlaying {
                            voiceRecorder.stopPlaying()
                        } else {
                            voiceRecorder.playRecording()
                        }
                    } label: {
                        Label(
                            String(format: "%.1fs", voiceRecorder.recordingDuration),
                            systemImage: voiceRecorder.isPlaying ? "stop.circle" : "play.circle"
                        )
                        .foregroundStyle(ZenTheme.gooseYellow)
                    }

                    Button { voiceRecorder.deleteRecording() } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red.opacity(0.6))
                    }
                } else {
                    Button {
                        Task {
                            let granted = await voiceRecorder.requestPermission()
                            if granted {
                                voiceRecorder.startRecording()
                            }
                        }
                    } label: {
                        Label(cn ? "录音" : "Record", systemImage: "mic.circle")
                            .foregroundStyle(ZenTheme.distantMountain)
                    }
                }
            }
            .font(ZenTheme.bodyFont(14))
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
                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Actions

    private func generateAIContent() async {
        let perspective = customPerspective.isEmpty ? selectedPerspective : customPerspective
        guard !perspective.isEmpty else {
            errorMessage = cn ? "请先选择一个视角" : "Please pick a perspective first"
            showError = true
            return
        }

        isGeneratingAI = true
        defer { isGeneratingAI = false }

        let provider = QwenProvider()
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

    private func submit() async {
        isSubmitting = true
        defer { isSubmitting = false }

        var voiceUrl: String?

        // Upload voice if recorded
        if let voiceData = voiceRecorder.recordedData() {
            let tempResponseId = UUID()
            do {
                voiceUrl = try await socialManager.uploadVoice(
                    requestId: request.id,
                    responseId: tempResponseId,
                    fileData: voiceData
                )
            } catch {
                // Voice upload failed — submit without voice
            }
        }

        let perspective = request.type == .encourage
            ? (customPerspective.isEmpty ? selectedPerspective : customPerspective)
            : nil

        do {
            try await socialManager.submitResponse(
                requestId: request.id,
                content: content,
                perspective: perspective,
                emojiStamp: emojiStamp.isEmpty ? nil : emojiStamp,
                voiceUrl: voiceUrl,
                isAnonymous: isAnonymous,
                senderName: isAnonymous ? nil : senderName
            )
            HapticManager.success()
            showSuccess = true
        } catch {
            errorMessage = cn ? "提交失败，请重试" : "Submission failed, please retry"
            showError = true
            HapticManager.error()
        }
    }
}
