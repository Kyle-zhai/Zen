import SwiftUI

struct MainContentView: View {
    @Environment(ZenViewModel.self) private var viewModel

    private var cn: Bool { viewModel.L.isChinese }

    @Namespace private var tabNS

    var body: some View {
        @Bindable var vm = viewModel

        ZStack {
            ZenBackground()

            VStack(spacing: 0) {
                headerBar
                tabSelector

                // Tab content with crossfade
                Group {
                    switch viewModel.selectedTab {
                    case .fortune:
                        DailyFortuneView(fortuneEngine: viewModel.fortuneEngine)
                            .environment(viewModel)
                            .id(AppTab.fortune)
                    case .encourage:
                        encourageContent
                            .id(AppTab.encourage)
                    case .zenType:
                        ZenTypeView(engine: viewModel.zenTypeEngine)
                            .environment(viewModel)
                            .id(AppTab.zenType)
                    }
                }
                .animation(.easeInOut(duration: 0.25), value: viewModel.selectedTab)
            }
        }
        .task { await viewModel.initialize() }
        .sheet(isPresented: $vm.showSettings) {
            SettingsView().environment(viewModel)
        }
        .sheet(isPresented: $vm.showPaywall, onDismiss: {
            viewModel.syncSubscriptionStatus()
        }) {
            PaywallView().environment(viewModel)
        }
        .sheet(isPresented: $vm.showArchive) {
            CourageArchiveView().environment(viewModel)
        }
        .sheet(isPresented: $vm.showRespondSheet) {
            if let request = vm.deepLinkRequest {
                RespondView(
                    request: request,
                    socialManager: viewModel.socialManager,
                    isChinese: cn
                )
            }
        }
        #if os(iOS)
        .sheet(isPresented: $vm.showShareSheet) {
            if let img = vm.shareCardImage {
                ShareSheetView(image: img)
            }
        }
        #endif
        .alert(cn ? "提示" : "Notice", isPresented: $vm.showError) {
            Button(cn ? "知道了" : "OK") {}
        } message: {
            Text(vm.errorMessage ?? "")
        }
    }

    // MARK: - Header

    private var headerBar: some View {
        VStack(spacing: 0) {
            ZStack {
                // Brand — pixel terminal style
                HStack(spacing: 6) {
                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .clipShape(RoundedRectangle(cornerRadius: 2))

                    Text(cn ? "禅意" : "ZenChoice")
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .foregroundStyle(ZenTheme.ricePaper)
                }

                // Side icons
                HStack {
                    headerIcon("book.closed") { viewModel.showArchive = true }
                    Spacer()
                    headerIcon("gearshape") { viewModel.showSettings = true }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 6)
            .padding(.bottom, 4)
        }
    }

    private func headerIcon(_ name: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: name)
                .font(.system(size: 14, weight: .light))
                .foregroundStyle(ZenTheme.mist.opacity(0.4))
        }
    }

    // MARK: - Tab Selector

    private var tabSelector: some View {
        HStack(spacing: 0) {
            tabButton(.fortune, label: cn ? "禅签" : "Oracle")
            tabButton(.encourage, label: cn ? "问禅" : "Ask Zen")
            tabButton(.zenType, label: cn ? "命星" : "Star")
        }
        .padding(.horizontal, 32)
        .padding(.top, 2)
        .padding(.bottom, 6)
    }

    private func tabButton(_ tab: AppTab, label: String) -> some View {
        let selected = viewModel.selectedTab == tab
        return Button {
            withAnimation(.easeInOut(duration: 0.15)) {
                viewModel.selectedTab = tab
            }
            HapticManager.selection()
        } label: {
            VStack(spacing: 5) {
                Text(label)
                    .font(.system(size: 12, weight: selected ? .bold : .regular, design: .monospaced))
                    .foregroundStyle(selected ? ZenTheme.gooseYellow : ZenTheme.mist.opacity(0.35))

                ZStack {
                    Rectangle().fill(.clear).frame(width: 20, height: 2)

                    if selected {
                        Rectangle()
                            .fill(ZenTheme.gooseYellow)
                            .frame(width: 20, height: 2)
                            .matchedGeometryEffect(id: "tabLine", in: tabNS)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
        }
    }

    // MARK: - Encourage Content

    private var encourageContent: some View {
        @Bindable var vm = viewModel

        return ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    inputArea(wish: $vm.wish)

                    if vm.showInkAnimation {
                        InkAnimationView(isChinese: cn)
                    }

                    if vm.showResult, let result = vm.currentResult {
                        resultSection(result)
                            .id("result")
                    }

                    Spacer().frame(height: 80)
                }
                .padding(.horizontal, 20)
            }
            #if os(iOS)
            .scrollDismissesKeyboard(.interactively)
            #endif
            .onChange(of: vm.showResult) { _, show in
                guard show else { return }
                withAnimation(.easeOut(duration: 0.5)) {
                    proxy.scrollTo("result", anchor: .top)
                }
            }
        }
    }

    // MARK: - Input Area

    @ViewBuilder
    private func inputArea(wish: Binding<String>) -> some View {
        VStack(spacing: 0) {
            Text(cn ? "心中所惑之事" : "What weighs on your mind")
                .font(.system(size: 12, weight: .regular, design: .monospaced))
                .foregroundStyle(ZenTheme.mist.opacity(0.3))
                .padding(.bottom, 18)

            // Input card
            TextField(cn ? "辞职、表白、出去跑步…" : "quit my job, ask them out…", text: wish, axis: .vertical)
                .font(.system(size: 15, weight: .regular, design: .monospaced))
                .foregroundStyle(ZenTheme.ricePaper.opacity(0.85))
                .multilineTextAlignment(.leading)
                .lineLimit(1...4)
                .tint(ZenTheme.gooseYellow)
                .onChange(of: wish.wrappedValue) { _, newValue in
                    if newValue.count > 50 {
                        wish.wrappedValue = String(newValue.prefix(50))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .zenCard(elevated: true)

            Spacer().frame(height: 26)

            goButton

            Spacer().frame(height: 10)

            Text(cn
                 ? "今日 \(viewModel.remainingUsage)/\(viewModel.dailyLimit)"
                 : "\(viewModel.remainingUsage)/\(viewModel.dailyLimit) today")
                .font(.system(size: 10, weight: .light, design: .monospaced))
                .foregroundStyle(viewModel.remainingUsage > 0
                                 ? ZenTheme.mist.opacity(0.25)
                                 : ZenTheme.cinnabar.opacity(0.5))
        }
    }

    // MARK: - Go Button

    @State private var buttonPressed = false

    private var goButton: some View {
        Button {
            #if os(iOS)
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            #endif
            Task { await viewModel.generateEncouragement() }
        } label: {
            Group {
                if viewModel.isLoading {
                    ProgressView().tint(ZenTheme.inkBlack)
                } else {
                    Text(cn ? "禅意初现" : "ZEN REVEALS")
                }
            }
            .font(.system(size: 15, weight: .bold, design: .monospaced))
            .foregroundStyle(ZenTheme.inkBlack)
            .tracking(1)
            .frame(width: 200)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(ZenTheme.gooseYellow)
            )
        }
        .disabled(viewModel.isLoading || viewModel.wish.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        .opacity(viewModel.wish.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1.0)
        .scaleEffect(buttonPressed ? 0.96 : 1.0)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in withAnimation(.easeOut(duration: 0.06)) { buttonPressed = true } }
                .onEnded { _ in withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) { buttonPressed = false } }
        )
    }

    // MARK: - Result Section

    private func resultSection(_ result: EncouragementResult) -> some View {
        VStack(spacing: 22) {
            // Wish
            Text(result.wish)
                .font(.system(size: 15, weight: .medium, design: .monospaced))
                .foregroundStyle(ZenTheme.ricePaper.opacity(0.7))
                .padding(.top, 10)

            ForEach(Array(result.dimensions.enumerated()), id: \.element.id) { index, dim in
                ResultCardView(
                    dimensionResult: dim,
                    delay: Double(index) * 0.12,
                    onShare: { viewModel.generateShareCard(dimensionResult: dim) }
                )
            }

            // Share hint for custom perspective
            if !viewModel.isSubscribed, !viewModel.hasShareReward {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 11))
                        .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                    Text(cn
                         ? "分享任意成果图，即可免费使用一次自定义视角"
                         : "Share any card to unlock one free custom perspective")
                        .font(.system(size: 11, weight: .regular, design: .monospaced))
                        .foregroundStyle(ZenTheme.mist.opacity(0.4))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(ZenTheme.gooseYellow.opacity(0.03))
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(ZenTheme.gooseYellow.opacity(0.08), lineWidth: 0.5))
                )
            }

            if !viewModel.isSubscribed {
                subscriberUpsell
            }

            actionButtons
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }

    // MARK: - Subscriber Upsell

    private var subscriberUpsell: some View {
        Button {
            viewModel.showPaywall = true
            HapticManager.selection()
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(cn ? "解锁更多视角" : "Unlock more perspectives")
                        .foregroundStyle(ZenTheme.gooseYellow)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(ZenTheme.gooseYellow.opacity(0.3))
                }
                .font(.system(size: 13, weight: .bold, design: .monospaced))

                Text(cn ? "更多次数 · 自选维度 · AI个性化" : "More uses · Custom dims · AI-powered")
                    .font(.system(size: 11, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.mist.opacity(0.3))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(ZenTheme.gooseYellow.opacity(0.04))
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(ZenTheme.gooseYellow.opacity(0.12), lineWidth: 0.5))
            )
        }
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.5)) { viewModel.reset() }
            HapticManager.selection()
        } label: {
            Text(cn ? "再来一次" : "RETRY")
                .font(.system(size: 13, weight: .regular, design: .monospaced))
                .foregroundStyle(ZenTheme.mist.opacity(0.4))
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
        }
    }
}

// MARK: - Terminal Loading Animation

private struct InkAnimationView: View {
    let isChinese: Bool
    @State private var startDate = Date()

    private let logLines: [(delay: Double, cn: String, en: String)] = [
        (0.0, "正在连接宇宙数据库...", "connecting to cosmic database..."),
        (0.4, "查询平行宇宙中的你...", "querying parallel universes..."),
        (0.8, "计算勇气指数...", "calculating courage index..."),
        (1.2, "编译命运碎片...", "compiling fate fragments..."),
        (1.6, "加载真相模块...", "loading truth module..."),
        (2.0, "渲染结果中...", "rendering results..."),
    ]

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 10.0)) { timeline in
            let elapsed = timeline.date.timeIntervalSince(startDate)

            VStack(alignment: .leading, spacing: 6) {
                ForEach(Array(logLines.enumerated()), id: \.offset) { _, line in
                    let lineElapsed = elapsed - line.delay
                    if lineElapsed > 0 {
                        let text = isChinese ? line.cn : line.en
                        let charsToShow = min(text.count, Int(lineElapsed * 25))
                        let visible = String(text.prefix(charsToShow))
                        let done = charsToShow >= text.count

                        HStack(spacing: 6) {
                            Text(done ? "✓" : "›")
                                .foregroundStyle(done ? ZenTheme.jade.opacity(0.5) : ZenTheme.gooseYellow.opacity(0.4))
                            Text(visible)
                                .foregroundStyle(ZenTheme.mist.opacity(0.4))
                        }
                        .font(.system(size: 12, weight: .regular, design: .monospaced))
                        .transition(.opacity)
                    }
                }

                Spacer().frame(height: 10)

                // Thin progress bar
                let progress = min(elapsed / 3.0, 1.0)
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 1)
                            .fill(ZenTheme.mist.opacity(0.08))
                            .frame(height: 2)
                        RoundedRectangle(cornerRadius: 1)
                            .fill(ZenTheme.gooseYellow.opacity(0.5))
                            .frame(width: geo.size.width * progress, height: 2)
                    }
                }
                .frame(height: 2)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(ZenTheme.cardSurface)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(ZenTheme.terminalStroke, lineWidth: 0.5))
            )
        }
        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
    }
}

// MARK: - Share Sheet (iOS)

#if os(iOS)
struct ShareSheetView: UIViewControllerRepresentable {
    let image: UIImage

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: [image], applicationActivities: nil)
    }

    func updateUIViewController(_: UIActivityViewController, context: Context) {}
}
#endif

#Preview {
    MainContentView()
        .environment(ZenViewModel())
}
