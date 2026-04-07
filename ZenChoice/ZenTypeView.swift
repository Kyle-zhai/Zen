import SwiftUI

struct ZenTypeView: View {
    @Environment(ZenViewModel.self) private var viewModel
    let engine: ZenTypeEngine

    private var cn: Bool { viewModel.L.isChinese }

    enum Phase { case entry, test, basicResult, advancedResult }

    @State private var phase: Phase = .entry
    @State private var resultAppear = false
    @State private var entryAppeared = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                Spacer().frame(height: 8)

                switch phase {
                case .entry:
                    entryView

                case .test:
                    ZenTypeTestView(engine: engine) { result in
                        if engine.testLevel == .basic {
                            resultAppear = false
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                phase = .basicResult
                            }
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2)) {
                                resultAppear = true
                            }
                        } else {
                            resultAppear = false
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                phase = .advancedResult
                            }
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2)) {
                                resultAppear = true
                            }
                        }
                    }
                    .environment(viewModel)

                case .basicResult:
                    basicResultView

                case .advancedResult:
                    advancedResultView
                }

                Spacer().frame(height: 80)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            if engine.advancedResult != nil {
                phase = .advancedResult
                resultAppear = true
            } else if engine.basicResult != nil {
                phase = .basicResult
                resultAppear = true
            }
        }
    }

    // MARK: - Entry

    @State private var startBtnPressed = false

    private var entryView: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 48)

            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 52, height: 52)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .opacity(entryAppeared ? 1 : 0)
                .offset(y: entryAppeared ? 0 : 10)

            Spacer().frame(height: 20)

            Text(cn ? "命星参悟" : "Zen Star Reading")
                .font(.system(size: 26, weight: .bold, design: .monospaced))
                .foregroundStyle(ZenTheme.ricePaper)
                .opacity(entryAppeared ? 1 : 0)
                .offset(y: entryAppeared ? 0 : 8)

            Spacer().frame(height: 8)

            Text(cn ? "你与哪颗AI命星共鸣" : "Which AI star resonates with you?")
                .font(.system(size: 12, weight: .regular, design: .monospaced))
                .foregroundStyle(ZenTheme.mist.opacity(0.35))
                .opacity(entryAppeared ? 1 : 0)

            Spacer().frame(height: 40)

            Button {
                engine.testLevel = .basic
                engine.currentAnswers = [:]
                withAnimation { phase = .test }
            } label: {
                Text(cn ? "开始参悟" : "BEGIN")
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .tracking(2)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(ZenTheme.gooseYellow)
                    )
            }
            .scaleEffect(startBtnPressed ? 0.95 : 1.0)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in withAnimation(.easeOut(duration: 0.06)) { startBtnPressed = true } }
                    .onEnded { _ in withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) { startBtnPressed = false } }
            )
            .opacity(entryAppeared ? 1 : 0)

            Spacer().frame(height: 12)

            Text(cn ? "八问禅机 · 约1分钟" : "8 questions · ~1 min")
                .font(.system(size: 11, weight: .regular, design: .monospaced))
                .foregroundStyle(ZenTheme.mist.opacity(0.2))

            Spacer().frame(height: 60)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) { entryAppeared = true }
        }
    }

    // MARK: - Basic Result

    private var basicResultView: some View {
        VStack(spacing: 24) {
            if let basic = engine.basicResult {
                resultSection(
                    result: basic,
                    title: cn ? "你的命星" : "Your Zen Star",
                    appear: resultAppear
                )

                // Short explanation
                Text(cn ? basic.summaryCN : basic.summaryEN)
                    .font(.system(size: 13, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.mist.opacity(0.6))
                    .lineSpacing(6)
                    .padding(.horizontal, 4)
                    .opacity(resultAppear ? 1 : 0)
            }

            // Advanced test entry
            advancedTestEntry

            // Actions
            basicActionButtons
        }
        .onAppear {
            if !resultAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    resultAppear = true
                }
            }
        }
    }

    // MARK: - Advanced Result (separate page)

    private var advancedResultView: some View {
        VStack(spacing: 24) {
            if let advanced = engine.advancedResult {
                // Header
                VStack(spacing: 6) {
                    Text(cn ? "深度命星" : "DEEP ZEN STAR")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                        .tracking(2)

                    Text(cn ? "三十问深度参悟" : "30-question deep reading")
                        .font(.system(size: 11, weight: .regular, design: .monospaced))
                        .foregroundStyle(ZenTheme.mist.opacity(0.25))
                }
                .opacity(resultAppear ? 1 : 0)

                // Advanced card (richer than basic)
                ZenTypeAdvancedCardView(
                    zenType: advanced,
                    isChinese: cn,
                    basicType: engine.basicResult
                )
                .scaleEffect(resultAppear ? 1.0 : 0.88)
                .opacity(resultAppear ? 1.0 : 0)

                // Summary section
                VStack(alignment: .leading, spacing: 10) {
                    Text(cn ? "分析摘要" : "ANALYSIS")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                        .tracking(1)

                    Text(cn ? advanced.summaryCN : advanced.summaryEN)
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .foregroundStyle(ZenTheme.mist.opacity(0.65))
                        .lineSpacing(7)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .zenCard(elevated: false)
                .opacity(resultAppear ? 1 : 0)

                // Comparison with basic result
                if let basic = engine.basicResult {
                    comparisonSection(basic: basic, advanced: advanced)
                        .opacity(resultAppear ? 1 : 0)
                }

                // Tagline highlight
                VStack(spacing: 8) {
                    Rectangle()
                        .fill(ZenTheme.mist.opacity(0.06))
                        .frame(height: 1)

                    Text(cn ? advanced.taglineCN : advanced.taglineEN)
                        .font(.system(size: 14, weight: .medium, design: .monospaced))
                        .foregroundStyle(ZenTheme.ricePaper.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)

                    Rectangle()
                        .fill(ZenTheme.mist.opacity(0.06))
                        .frame(height: 1)
                }
                .opacity(resultAppear ? 1 : 0)

                // Detailed reading gate
                detailedReadingSection(advanced)
                    .opacity(resultAppear ? 1 : 0)
            }

            // Actions
            advancedActionButtons
        }
        .onAppear {
            if !resultAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    resultAppear = true
                }
            }
        }
    }

    // MARK: - Comparison Section

    private func comparisonSection(basic: ZenType, advanced: ZenType) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(cn ? "命星对照" : "COMPARISON")
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                .tracking(1)

            if basic.id == advanced.id {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 13))
                        .foregroundStyle(ZenTheme.jade)
                    Text(cn
                         ? "初悟与深悟一致：\(basic.codeCN) · \(basic.starCN)"
                         : "Initial & deep readings agree: \(basic.codeEN) · \(basic.starEN)")
                        .font(.system(size: 12, weight: .regular, design: .monospaced))
                        .foregroundStyle(ZenTheme.mist.opacity(0.55))
                }
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Text(cn ? "初悟" : "Initial")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundStyle(ZenTheme.mist.opacity(0.35))
                            .frame(width: 36, alignment: .leading)
                        Text(cn ? "\(basic.codeCN) · \(basic.starCN)" : "\(basic.codeEN) · \(basic.starEN)")
                            .font(.system(size: 12, weight: .regular, design: .monospaced))
                            .foregroundStyle(ZenTheme.mist.opacity(0.5))
                    }
                    HStack(spacing: 8) {
                        Text(cn ? "深悟" : "Deep")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                            .frame(width: 36, alignment: .leading)
                        Text(cn ? "\(advanced.codeCN) · \(advanced.starCN)" : "\(advanced.codeEN) · \(advanced.starEN)")
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                            .foregroundStyle(ZenTheme.ricePaper.opacity(0.7))
                    }
                }

                Text(cn
                     ? "深层参悟揭示了不同的命星共鸣"
                     : "The deep reading revealed a different star resonance")
                    .font(.system(size: 11, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.mist.opacity(0.35))
                    .lineSpacing(4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .zenCard(elevated: false)
    }

    // MARK: - Result Section (shared card component)

    private func resultSection(result: ZenType, title: String, appear: Bool) -> some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                .tracking(2)

            ZenTypeCardView(zenType: result, isChinese: cn)
        }
        .scaleEffect(appear ? 1.0 : 0.88)
        .opacity(appear ? 1.0 : 0)
    }

    // MARK: - Advanced Test Entry

    @State private var advBtnPressed = false

    private var advancedTestEntry: some View {
        VStack(spacing: 12) {
            Rectangle()
                .fill(ZenTheme.mist.opacity(0.06))
                .frame(height: 1)

            VStack(spacing: 8) {
                Text(cn ? "想要更深层的参悟？" : "Seek a deeper reading?")
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundStyle(ZenTheme.ricePaper.opacity(0.7))

                Text(cn ? "三十道禅问，参悟你的深层命星" : "30 questions to reveal your deeper zen star")
                    .font(.system(size: 11, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.mist.opacity(0.35))
                    .multilineTextAlignment(.center)
            }

            Button {
                engine.startAdvancedTest()
                withAnimation { phase = .test }
            } label: {
                Text(cn ? "深度参悟" : "DEEP READING")
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .tracking(1)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 32)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(ZenTheme.gooseYellow)
                    )
            }
            .scaleEffect(advBtnPressed ? 0.95 : 1.0)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in withAnimation(.easeOut(duration: 0.06)) { advBtnPressed = true } }
                    .onEnded { _ in withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) { advBtnPressed = false } }
            )

            Text(cn ? "三十问禅机 · 约5分钟" : "30 questions · ~5 min")
                .font(.system(size: 10, weight: .regular, design: .monospaced))
                .foregroundStyle(ZenTheme.mist.opacity(0.2))

            Rectangle()
                .fill(ZenTheme.mist.opacity(0.06))
                .frame(height: 1)
        }
        .opacity(resultAppear ? 1 : 0)
    }

    // MARK: - Detailed Reading

    private func detailedReadingSection(_ result: ZenType) -> some View {
        Group {
            if !viewModel.isSubscribed {
                Button {
                    viewModel.showPaywall = true
                } label: {
                    HStack(spacing: 8) {
                        Text(cn ? "解锁禅意深度解读" : "Unlock zen deep reading")
                            .foregroundStyle(ZenTheme.gooseYellow)
                        Spacer()
                        Image(systemName: "lock.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                    }
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(ZenTheme.gooseYellow.opacity(0.06))
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(ZenTheme.gooseYellow.opacity(0.12), lineWidth: 0.5))
                    )
                }
            } else {
                // Radar chart — multi-dimensional profile
                let level: ZenTypeEngine.TestLevel = engine.advancedResult != nil ? .advanced : .basic
                let normalized = engine.normalizedScores(for: level)
                if !normalized.isEmpty {
                    ZenRadarChartView(
                        scores: normalized,
                        types: engine.allTypes,
                        isChinese: cn,
                        highlightType: result.id
                    )
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text(cn ? "深度解读" : "DEEP READING")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                        .tracking(1)

                    Text(cn ? result.detailCN : result.detailEN)
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .foregroundStyle(ZenTheme.mist.opacity(0.65))
                        .lineSpacing(7)
                }
                .padding(16)
                .zenCard(elevated: true)
            }
        }
    }

    // MARK: - Action Buttons

    private var basicActionButtons: some View {
        HStack(spacing: 16) {
            if let result = engine.basicResult {
                Button {
                    viewModel.generateZenTypeCard(zenType: result)
                } label: {
                    Text(cn ? "分享" : "SHARE")
                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(ZenTheme.gooseYellow.opacity(0.3), lineWidth: 1)
                        )
                }
            }

            Button {
                engine.resetTest()
                resultAppear = false
                withAnimation { phase = .entry }
            } label: {
                Text(cn ? "重测" : "RETRY")
                    .font(.system(size: 13, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.mist.opacity(0.4))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
            }
        }
        .opacity(resultAppear ? 1 : 0)
    }

    private var advancedActionButtons: some View {
        HStack(spacing: 16) {
            if let result = engine.advancedResult {
                Button {
                    viewModel.generateZenTypeAdvancedCard(zenType: result, basicType: engine.basicResult)
                } label: {
                    Text(cn ? "分享" : "SHARE")
                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(ZenTheme.gooseYellow.opacity(0.3), lineWidth: 1)
                        )
                }
            }

            // Back to basic result
            if engine.basicResult != nil {
                Button {
                    resultAppear = false
                    withAnimation {
                        phase = .basicResult
                    }
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.15)) {
                        resultAppear = true
                    }
                } label: {
                    Text(cn ? "初悟" : "INITIAL")
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .foregroundStyle(ZenTheme.mist.opacity(0.4))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                }
            }

            Button {
                engine.resetTest()
                resultAppear = false
                withAnimation { phase = .entry }
            } label: {
                Text(cn ? "重测" : "RETRY")
                    .font(.system(size: 13, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.mist.opacity(0.4))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
            }
        }
        .opacity(resultAppear ? 1 : 0)
    }
}
