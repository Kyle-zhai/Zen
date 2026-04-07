import SwiftUI

struct DailyFortuneView: View {
    @Environment(ZenViewModel.self) private var viewModel
    let fortuneEngine: FortuneEngine

    private var cn: Bool { viewModel.L.isChinese }

    @State private var phase: FortunePhase
    @State private var stampHit: Bool

    enum FortunePhase {
        case idle
        case drawing
        case revealed
    }

    init(fortuneEngine: FortuneEngine) {
        self.fortuneEngine = fortuneEngine
        // Start in revealed if within cooldown — no flash of idle
        let inCooldown = fortuneEngine.hasDrawnToday
        _phase = State(initialValue: inCooldown ? .revealed : .idle)
        _stampHit = State(initialValue: inCooldown)
    }

    var body: some View {
        Group {
            switch phase {
            case .idle:
                idleContent
            case .drawing:
                TerminalBootView(cn: cn) {
                    _ = fortuneEngine.drawFortune()
                    fortuneEngine.incrementFortuneCount()
                    viewModel.scheduleRefreshNotification()
                    stampHit = false
                    withAnimation(.easeInOut(duration: 0.4)) {
                        phase = .revealed
                    }
                }
            case .revealed:
                if let fortune = fortuneEngine.todayFortune {
                    revealedContent(fortune)
                } else if fortuneEngine.hasDrawnToday {
                    // Fortune data still loading — wait
                    ProgressView()
                        .tint(ZenTheme.gooseYellow)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    idleContent.onAppear { phase = .idle }
                }
            }
        }
        .onChange(of: fortuneEngine.hasDrawnToday) { _, drawn in
            if drawn, fortuneEngine.todayFortune != nil, phase == .idle {
                stampHit = true
                phase = .revealed
            }
        }
        .onChange(of: fortuneEngine.todayFortune?.id) { _, newId in
            if newId != nil, fortuneEngine.hasDrawnToday, phase == .idle {
                stampHit = true
                phase = .revealed
            }
        }
        .onAppear {
            if fortuneEngine.hasDrawnToday, fortuneEngine.todayFortune != nil {
                stampHit = true
                phase = .revealed
            }
        }
    }

    // MARK: - Idle

    @State private var idleAppeared = false
    @State private var drawBtnPressed = false

    private var idleContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                Spacer().frame(height: 32)

                // Terminal preview
                VStack(spacing: 0) {
                    TerminalTitleBar(title: cn ? "今日禅签" : "zen oracle")

                    VStack(alignment: .leading, spacing: 8) {
                        Spacer().frame(height: 16)

                        Text("Last login: \(loginDate)")
                            .font(.system(size: 11, weight: .regular, design: .monospaced))
                            .foregroundStyle(ZenTheme.terminalText.opacity(0.2))

                        HStack(spacing: 0) {
                            Text("$ ")
                                .foregroundStyle(ZenTheme.jade.opacity(0.7))
                            Text("zen-oracle --today")
                                .foregroundStyle(ZenTheme.terminalText.opacity(0.6))
                            Text("_")
                                .foregroundStyle(ZenTheme.terminalText.opacity(0.6))
                                .cursorBlink()
                        }
                        .font(.system(size: 13, weight: .regular, design: .monospaced))

                        Spacer().frame(height: 16)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(ZenTheme.terminalBg)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(ZenTheme.terminalStroke, lineWidth: 0.5))
                .padding(.horizontal, 20)
                .opacity(idleAppeared ? 1 : 0)
                .offset(y: idleAppeared ? 0 : 10)

                Spacer().frame(height: 36)

                // Draw button
                Button { startDraw() } label: {
                    Text(cn ? "求签" : "DRAW")
                        .font(.system(size: 15, weight: .bold, design: .monospaced))
                        .foregroundStyle(ZenTheme.inkBlack)
                        .tracking(2)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 48)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(ZenTheme.gooseYellow)
                        )
                }
                .scaleEffect(drawBtnPressed ? 0.95 : 1.0)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in withAnimation(.easeOut(duration: 0.06)) { drawBtnPressed = true } }
                        .onEnded { _ in withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) { drawBtnPressed = false } }
                )
                .opacity(idleAppeared ? 1 : 0)

                Spacer().frame(height: 80)
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) { idleAppeared = true }
        }
    }

    // MARK: - Revealed

    private func revealedContent(_ fortune: Fortune) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                Spacer().frame(height: 12)

                FortuneCardView(fortune: fortune, isChinese: cn)
                    .scaleEffect(stampHit ? 1.0 : 0.88)
                    .opacity(stampHit ? 1.0 : 0)
                    .onAppear {
                        if !stampHit {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                stampHit = true
                            }
                            HapticManager.heavyImpact()
                        }
                    }

                // Action buttons
                Button {
                    viewModel.generateFortuneCard(fortune: fortune)
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
                .opacity(stampHit ? 1 : 0)
                .animation(.easeOut(duration: 0.5).delay(0.3), value: stampHit)

                // Countdown to next fortune
                FortuneCooldownView(fortuneEngine: fortuneEngine, isChinese: cn)
                    .opacity(stampHit ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.5), value: stampHit)

                Spacer().frame(height: 80)
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func startDraw() {
        phase = .drawing
        HapticManager.impact()
    }

    private var loginDate: String {
        let f = DateFormatter()
        f.dateFormat = "EEE MMM d HH:mm:ss yyyy"
        f.locale = Locale(identifier: "en_US")
        return f.string(from: Date())
    }
}

// MARK: - Terminal Boot Animation

private struct TerminalBootView: View {
    let cn: Bool
    let onComplete: () -> Void

    @State private var startDate: Date?
    @State private var done = false

    private let totalDuration: Double = 3.5

    private var bootLines: [(delay: Double, cn: String, en: String, color: BootColor)] {
        [
            (0.0, "正在焚香启签...", "Lighting incense...", .white),
            (0.3, "[OK] 接引天机", "[OK] Channeling celestial wisdom", .green),
            (0.7, "[OK] 读取因果", "[OK] Reading karmic threads", .green),
            (1.0, "参悟禅机中...", "Contemplating the zen oracle...", .white),
            (1.4, "[OK] 签文已现", "[OK] Oracle manifested", .green),
            (1.8, "化墨成文...", "Inscribing the message...", .white),
            (2.2, "[OK] 禅签已成", "[OK] Zen oracle complete", .green),
            (2.6, "", "", .white),
            (2.8, ">>> 签文揭晓 <<<", ">>> Oracle Revealed <<<", .gold),
        ]
    }

    enum BootColor { case white, green, gold }

    var body: some View {
        VStack(spacing: 0) {
            TerminalTitleBar(title: cn ? "禅签 — 求签中" : "oracle — drawing")

            TimelineView(.animation(minimumInterval: 1.0 / 10.0)) { timeline in
                let elapsed = startDate.map { timeline.date.timeIntervalSince($0) } ?? 0

                VStack(alignment: .leading, spacing: 4) {
                    Spacer().frame(height: 16)

                    ForEach(Array(bootLines.enumerated()), id: \.offset) { _, line in
                        if elapsed >= line.delay && !line.cn.isEmpty {
                            let text = cn ? line.cn : line.en
                            let charCount = min(text.count, Int((elapsed - line.delay) * 30))
                            let visible = String(text.prefix(charCount))

                            Text(visible)
                                .font(.system(size: 12, weight: .regular, design: .monospaced))
                                .foregroundStyle(lineColor(line.color))
                                .transition(.opacity)
                        }
                    }

                    Spacer().frame(height: 16)

                    // Progress bar
                    let progress = min(elapsed / totalDuration, 1.0)
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 1)
                                .fill(ZenTheme.mist.opacity(0.08))
                                .frame(height: 2)
                            RoundedRectangle(cornerRadius: 1)
                                .fill(ZenTheme.gooseYellow.opacity(0.6))
                                .frame(width: geo.size.width * progress, height: 2)
                        }
                    }
                    .frame(height: 2)

                    Spacer().frame(height: 6)

                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 10, weight: .medium, design: .monospaced))
                        .foregroundStyle(ZenTheme.gooseYellow.opacity(0.4))

                    Spacer()
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onChange(of: elapsed >= totalDuration) { _, v in
                    if v && !done {
                        done = true
                        HapticManager.heavyImpact()
                        onComplete()
                    }
                }
            }
            .background(ZenTheme.terminalBg)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(ZenTheme.terminalStroke, lineWidth: 0.5))
        .padding(.horizontal, 20)
        .padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.clear)
        .onAppear { startDate = Date() }
    }

    private func lineColor(_ c: BootColor) -> Color {
        switch c {
        case .white: return ZenTheme.terminalText.opacity(0.5)
        case .green: return ZenTheme.jade.opacity(0.7)
        case .gold: return ZenTheme.gooseYellow
        }
    }
}

// MARK: - Fortune Cooldown Countdown

private struct FortuneCooldownView: View {
    let fortuneEngine: FortuneEngine
    let isChinese: Bool

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { timeline in
            let remaining = remainingTime(at: timeline.date)

            if remaining > 0 {
                VStack(spacing: 6) {
                    Rectangle()
                        .fill(ZenTheme.mist.opacity(0.06))
                        .frame(height: 1)
                        .padding(.horizontal, 20)

                    HStack(spacing: 6) {
                        Image(systemName: "hourglass")
                            .font(.system(size: 9))
                            .foregroundStyle(ZenTheme.gooseYellow.opacity(0.3))

                        Text(isChinese
                             ? "距离下次禅意生成还有 \(formatTime(remaining))"
                             : "Next oracle in \(formatTime(remaining))")
                            .font(.system(size: 10, weight: .regular, design: .monospaced))
                            .foregroundStyle(ZenTheme.mist.opacity(0.25))
                    }
                    .padding(.vertical, 4)
                }
            } else {
                Text(isChinese ? "每24小时仅可求签一次" : "One oracle per 24 hours")
                    .font(.system(size: 10, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.mist.opacity(0.2))
            }
        }
    }

    private func remainingTime(at now: Date) -> TimeInterval {
        guard let lastDraw = fortuneEngine.lastDrawDate else { return 0 }
        let elapsed = now.timeIntervalSince(lastDraw)
        return max(FortuneEngine.cooldownInterval - elapsed, 0)
    }

    private func formatTime(_ interval: TimeInterval) -> String {
        let total = Int(interval)
        let h = total / 3600
        let m = (total % 3600) / 60
        let s = total % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
}
