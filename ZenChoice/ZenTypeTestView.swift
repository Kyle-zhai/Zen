import SwiftUI

struct ZenTypeTestView: View {
    @Environment(ZenViewModel.self) private var viewModel
    let engine: ZenTypeEngine
    let onComplete: (ZenType) -> Void

    private var cn: Bool { viewModel.L.isChinese }

    @State private var currentIndex = 0
    @State private var questionAppeared = false

    var body: some View {
        let questions = engine.questions
        if questions.isEmpty { return AnyView(EmptyView()) }

        let question = questions[currentIndex]

        return AnyView(
            VStack(spacing: 0) {
                // Segmented progress bar
                HStack(spacing: 3) {
                    ForEach(0..<questions.count, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 1)
                            .fill(i <= currentIndex
                                  ? ZenTheme.gooseYellow
                                  : ZenTheme.mist.opacity(0.08))
                            .frame(height: 2)
                    }
                }
                .padding(.horizontal, 4)
                .animation(.easeInOut(duration: 0.3), value: currentIndex)

                Spacer().frame(height: 12)

                // Counter
                Text("\(currentIndex + 1)/\(questions.count)")
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                    .foregroundStyle(ZenTheme.mist.opacity(0.3))

                Spacer().frame(height: 40)

                // Question
                Text(cn ? question.questionCN : question.questionEN)
                    .font(.system(size: 18, weight: .medium, design: .monospaced))
                    .foregroundStyle(ZenTheme.ricePaper)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 20)
                    .id(currentIndex)
                    .opacity(questionAppeared ? 1 : 0)
                    .offset(y: questionAppeared ? 0 : 10)

                Spacer().frame(height: 36)

                // Options (A, B, C)
                VStack(spacing: 10) {
                    optionButton(
                        label: "A",
                        text: cn ? question.optionACN : question.optionAEN,
                        choice: "a",
                        questionId: question.id
                    )
                    optionButton(
                        label: "B",
                        text: cn ? question.optionBCN : question.optionBEN,
                        choice: "b",
                        questionId: question.id
                    )
                    optionButton(
                        label: "C",
                        text: cn ? question.optionCCN : question.optionCEN,
                        choice: "c",
                        questionId: question.id
                    )
                }
                .padding(.horizontal, 16)

                Spacer()
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.5)) { questionAppeared = true }
            }
        )
    }

    private func optionButton(label: String, text: String, choice: String, questionId: Int) -> some View {
        Button {
            HapticManager.selection()
            engine.recordAnswer(questionId: questionId, choice: choice)

            if currentIndex < engine.questions.count - 1 {
                questionAppeared = false
                withAnimation(.easeInOut(duration: 0.25)) {
                    currentIndex += 1
                }
                withAnimation(.easeOut(duration: 0.4).delay(0.15)) {
                    questionAppeared = true
                }
            } else {
                if let result = engine.calculateResult() {
                    HapticManager.success()
                    onComplete(result)
                }
            }
        } label: {
            HStack(spacing: 12) {
                Text(label)
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundStyle(ZenTheme.gooseYellow.opacity(0.6))
                    .frame(width: 20)

                Text(text)
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.ricePaper.opacity(0.8))
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(ZenTheme.cardSurface)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(ZenTheme.mist.opacity(0.06), lineWidth: 0.5)
                    )
            )
        }
    }
}
