import SwiftUI

struct MainContentView: View {
    @Environment(ZenViewModel.self) private var viewModel

    var body: some View {
        @Bindable var vm = viewModel

        ZStack {
            ZenBackground()

            VStack(spacing: 0) {
                headerBar
                modePicker

                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 32) {
                            Spacer().frame(height: 24)

                            inputArea(wish: $vm.wish)

                            if vm.showInkAnimation {
                                InkAnimationView()
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
        }
        .task { await viewModel.initialize() }
        .sheet(isPresented: $vm.showSettings) {
            SettingsView().environment(viewModel)
        }
        .sheet(isPresented: $vm.showPaywall) {
            PaywallView().environment(viewModel)
        }
        .sheet(isPresented: $vm.showHistory) {
            HistorySheet().environment(viewModel)
        }
        #if os(iOS)
        .sheet(isPresented: $vm.showShareSheet) {
            if let img = vm.posterImage {
                ShareSheetView(image: img)
            }
        }
        #endif
        .alert("提示", isPresented: $vm.showError) {
            Button("知道了") {}
        } message: {
            Text(vm.errorMessage ?? "")
        }
    }

    // MARK: - Header

    private var headerBar: some View {
        HStack {
            Button { viewModel.showHistory = true } label: {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.title3)
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
            }

            Spacer()

            VStack(spacing: 2) {
                Text("禅择")
                    .font(ZenTheme.calligraphy(28))
                    .foregroundStyle(ZenTheme.inkBlack)
                Text("ZENCHOICE")
                    .font(ZenTheme.caption(10))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                    .tracking(4)
            }

            Spacer()

            Button { viewModel.showSettings = true } label: {
                Image(systemName: "gearshape")
                    .font(.title3)
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }

    // MARK: - Mode Picker

    private var modePicker: some View {
        HStack(spacing: 4) {
            ForEach(DivinationMode.allCases, id: \.self) { mode in
                Button {
                    guard viewModel.selectedMode != mode else { return }
                    withAnimation(.easeInOut(duration: 0.3)) {
                        viewModel.selectedMode = mode
                    }
                    if viewModel.showResult {
                        withAnimation { viewModel.reset() }
                    }
                    HapticManager.selection()
                } label: {
                    Text(mode.rawValue)
                        .font(ZenTheme.bodyFont(14))
                        .foregroundStyle(
                            viewModel.selectedMode == mode
                                ? ZenTheme.inkBlack
                                : ZenTheme.distantMountain.opacity(0.4)
                        )
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(
                            Capsule()
                                .fill(
                                    viewModel.selectedMode == mode
                                        ? ZenTheme.gooseYellow.opacity(0.3)
                                        : .clear
                                )
                        )
                }
            }
        }
        .padding(.vertical, 10)
        .background(
            Capsule()
                .fill(ZenTheme.inkBlack.opacity(0.04))
        )
        .padding(.horizontal, 40)
        .padding(.top, 6)
    }

    // MARK: - Input Area

    @ViewBuilder
    private func inputArea(wish: Binding<String>) -> some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                dot
                Text(viewModel.selectedMode.subtitle)
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                    .tracking(6)
                    .animation(.none, value: viewModel.selectedMode)
                dot
            }

            VStack(spacing: 8) {
                TextField(viewModel.selectedMode.placeholder, text: wish, axis: .vertical)
                    .font(ZenTheme.bodyFont(17))
                    .foregroundStyle(ZenTheme.distantMountain)
                    .multilineTextAlignment(.center)
                    .lineLimit(1...3)
                    .tint(ZenTheme.gooseYellow)

                DottedLine()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.2))
                    .frame(height: 1)
            }
            .padding(.horizontal, 20)

            divinationButton
        }
    }

    // MARK: - Divination Button

    private var divinationButton: some View {
        Button {
            Task { await viewModel.divine() }
        } label: {
            HStack(spacing: 8) {
                if viewModel.isLoading {
                    ProgressView().tint(ZenTheme.gooseYellow)
                } else {
                    Image(systemName: "sparkles")
                    Text(viewModel.selectedMode.buttonTitle)
                }
            }
            .font(ZenTheme.calligraphy(18))
            .foregroundStyle(ZenTheme.gooseYellow)
            .padding(.horizontal, 44)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(ZenTheme.inkBlack)
                    .shadow(color: ZenTheme.inkBlack.opacity(0.3), radius: 12, y: 6)
            )
        }
        .disabled(viewModel.isLoading)
        .padding(.top, 8)
    }

    // MARK: - Result Section (branches by mode)

    private func resultSection(_ result: DivinationResult) -> some View {
        VStack(spacing: 24) {
            switch result.mode {
            case .todayAuspice:
                todayResultHeader(result)
            case .findBestDay:
                bestDayResultHeader(result)
            }

            let keys = result.record.freeReasons.keys.sorted()
            ForEach(keys, id: \.self) { key in
                let idx = keys.firstIndex(of: key) ?? 0
                ResultCardView(
                    dimensionKey: key,
                    reason: result.record.freeReasons[key] ?? "",
                    delay: Double(idx) * 0.12
                )
            }

            premiumSection(result.record)

            actionButtons
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }

    // MARK: - Mode 1 Result Header (Today's Auspice)

    private func todayResultHeader(_ result: DivinationResult) -> some View {
        VStack(spacing: 10) {
            Text("天机已定")
                .font(ZenTheme.caption(12))
                .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                .tracking(8)

            Text(result.verdict ?? "吉")
                .font(ZenTheme.calligraphy(52))
                .foregroundStyle(
                    result.isAuspicious
                        ? ZenTheme.gooseYellow
                        : ZenTheme.distantMountain.opacity(0.5)
                )
                .shadow(
                    color: result.isAuspicious
                        ? ZenTheme.gooseYellow.opacity(0.3)
                        : .clear,
                    radius: 12
                )

            Text(result.verdictDescription)
                .font(ZenTheme.bodyFont(14))
                .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))

            dividerDecoration

            Text(
                result.isAuspicious
                    ? "今天宜「\(result.record.wish)」"
                    : "今天「\(result.record.wish)」需三思"
            )
            .font(ZenTheme.bodyFont(15))
            .foregroundStyle(ZenTheme.inkBlack)

            Text(result.record.formattedDate)
                .font(ZenTheme.caption(12))
                .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
        }
        .padding(.top, 8)
    }

    // MARK: - Mode 2 Result Header (Best Day + Time)

    private func bestDayResultHeader(_ result: DivinationResult) -> some View {
        VStack(spacing: 8) {
            Text("天机已定")
                .font(ZenTheme.caption(12))
                .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                .tracking(8)

            Text(result.record.formattedDate)
                .font(ZenTheme.calligraphy(26))
                .foregroundStyle(ZenTheme.inkBlack)

            dividerDecoration

            if let time = result.recommendedTime {
                HStack(spacing: 6) {
                    Image(systemName: "clock.fill")
                        .font(.caption)
                        .foregroundStyle(ZenTheme.gooseYellow)
                    Text("最佳时辰")
                        .font(ZenTheme.caption(12))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                }

                Text(time)
                    .font(ZenTheme.calligraphy(20))
                    .foregroundStyle(ZenTheme.gooseYellow)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(ZenTheme.inkBlack.opacity(0.06))
                    )
            }

            Text("最适合「\(result.record.wish)」的日子")
                .font(ZenTheme.bodyFont(14))
                .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
                .padding(.top, 4)
        }
        .padding(.top, 8)
    }

    // MARK: - Premium Section

    private func premiumSection(_ record: DecisionRecord) -> some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "lock.shield.fill")
                    .foregroundStyle(ZenTheme.gooseYellow)
                Text("玄学深度报告")
                    .font(ZenTheme.calligraphy(16))
                    .foregroundStyle(ZenTheme.inkBlack)
                Spacer()
            }

            ZStack {
                Text(record.premiumReport ?? "")
                    .font(.system(size: 13, design: .monospaced))
                    .foregroundStyle(ZenTheme.distantMountain)
                    .padding()
                    .blur(radius: viewModel.isPaid ? 0 : 8)

                if !viewModel.isPaid {
                    Button {
                        viewModel.showPaywall = true
                        HapticManager.selection()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "eye.slash.fill").font(.title2)
                            Text("解锁深度报告").font(ZenTheme.bodyFont(14))
                            Text("探索属于你的八字玄机")
                                .font(ZenTheme.caption(11))
                                .opacity(0.7)
                        }
                        .foregroundStyle(ZenTheme.inkBlack)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 40)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.ultraThinMaterial)
                        )
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(ZenTheme.ivory)
                .shadow(color: ZenTheme.inkBlack.opacity(0.06), radius: 10, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(ZenTheme.gooseYellow.opacity(0.3), lineWidth: 1)
        )
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        HStack(spacing: 16) {
            Button {
                viewModel.generatePoster()
            } label: {
                Label("生成海报", systemImage: "square.and.arrow.up")
                    .font(ZenTheme.bodyFont(14))
                    .foregroundStyle(ZenTheme.ivory)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Capsule().fill(ZenTheme.distantMountain))
            }

            Button {
                withAnimation(.easeInOut(duration: 0.5)) { viewModel.reset() }
                HapticManager.selection()
            } label: {
                Label("再算一卦", systemImage: "arrow.counterclockwise")
                    .font(ZenTheme.bodyFont(14))
                    .foregroundStyle(ZenTheme.distantMountain)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        Capsule().stroke(ZenTheme.distantMountain.opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }

    // MARK: - Decorations

    private var dividerDecoration: some View {
        HStack(spacing: 6) {
            Rectangle().fill(ZenTheme.gooseYellow).frame(width: 30, height: 2)
            Circle().fill(ZenTheme.gooseYellow).frame(width: 5, height: 5)
            Rectangle().fill(ZenTheme.gooseYellow).frame(width: 30, height: 2)
        }
    }

    private var dot: some View {
        Circle()
            .fill(ZenTheme.distantMountain.opacity(0.15))
            .frame(width: 4, height: 4)
    }
}

// MARK: - Ink Animation

private struct InkAnimationView: View {
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            ZenTheme.inkBlack.opacity(0.5),
                            ZenTheme.inkBlack.opacity(0.15),
                            .clear,
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 120
                    )
                )
                .frame(width: 250, height: 250)
                .scaleEffect(pulse ? 1.08 : 0.92)
                .blur(radius: 25)

            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .fill(ZenTheme.inkBlack.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .offset(
                        x: CGFloat([-30, 25, -10][i]),
                        y: CGFloat([20, -15, 30][i])
                    )
                    .scaleEffect(pulse ? 1.1 : 0.85)
                    .blur(radius: 12)
            }

            VStack(spacing: 6) {
                ProgressView()
                    .tint(ZenTheme.distantMountain.opacity(0.5))
                Text("卦象生成中…")
                    .font(ZenTheme.caption(13))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
            }
        }
        .frame(height: 200)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 1.4).repeatForever(autoreverses: true)
            ) {
                pulse = true
            }
        }
        .transition(
            .asymmetric(
                insertion: .scale(scale: 0.01).combined(with: .opacity),
                removal: .opacity
            )
        )
    }
}

// MARK: - Dotted Line

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: 0, y: rect.midY))
            p.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        }
    }
}

// MARK: - History Sheet

struct HistorySheet: View {
    @Environment(ZenViewModel.self) private var viewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.history.isEmpty {
                    ContentUnavailableView(
                        "尚无记录",
                        systemImage: "tray",
                        description: Text("你的择日历史将在此显示")
                    )
                } else {
                    List(viewModel.history) { record in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(record.wish)
                                .font(ZenTheme.bodyFont(15))
                                .foregroundStyle(ZenTheme.inkBlack)
                            Text(record.formattedDate)
                                .font(ZenTheme.caption(12))
                                .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("历史记录")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
        }
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
