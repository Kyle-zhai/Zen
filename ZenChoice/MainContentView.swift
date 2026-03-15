import SwiftUI

struct MainContentView: View {
    @Environment(ZenViewModel.self) private var viewModel

    var body: some View {
        @Bindable var vm = viewModel

        ZStack {
            ZenBackground()

            VStack(spacing: 0) {
                headerBar

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
        .sheet(isPresented: $vm.showArchive) {
            CourageArchiveView().environment(viewModel)
        }
        #if os(iOS)
        .sheet(isPresented: $vm.showShareSheet) {
            if let img = vm.shareCardImage {
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
            Button { viewModel.showArchive = true } label: {
                Image(systemName: "book.closed")
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

    // MARK: - Input Area

    @ViewBuilder
    private func inputArea(wish: Binding<String>) -> some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                dot
                Text("今日何所想")
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                    .tracking(6)
                dot
            }

            VStack(spacing: 8) {
                TextField("今天想做什么…", text: wish, axis: .vertical)
                    .font(ZenTheme.bodyFont(17))
                    .foregroundStyle(ZenTheme.distantMountain)
                    .multilineTextAlignment(.center)
                    .lineLimit(1...3)
                    .tint(ZenTheme.gooseYellow)
                    .onChange(of: wish.wrappedValue) { _, newValue in
                        if newValue.count > 50 {
                            wish.wrappedValue = String(newValue.prefix(50))
                        }
                    }

                DottedLine()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.2))
                    .frame(height: 1)
            }
            .padding(.horizontal, 20)

            goButton
        }
    }

    // MARK: - Go Button

    private var goButton: some View {
        Button {
            Task { await viewModel.generateEncouragement() }
        } label: {
            HStack(spacing: 8) {
                if viewModel.isLoading {
                    ProgressView().tint(ZenTheme.gooseYellow)
                } else {
                    Image(systemName: "sparkles")
                    Text("去吧")
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
        .disabled(viewModel.isLoading || viewModel.wish.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        .padding(.top, 8)
    }

    // MARK: - Result Section

    private func resultSection(_ result: EncouragementResult) -> some View {
        VStack(spacing: 20) {
            // Wish echo
            Text("「\(result.wish)」")
                .font(ZenTheme.bodyFont(15))
                .foregroundStyle(ZenTheme.inkBlack)
                .padding(.top, 8)

            dividerDecoration

            // Dimension cards
            ForEach(Array(result.dimensions.enumerated()), id: \.element.id) { index, dim in
                ResultCardView(
                    dimensionResult: dim,
                    delay: Double(index) * 0.12,
                    onShare: { viewModel.generateShareCard(dimensionResult: dim) }
                )
            }

            // Subscriber upsell (if free)
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
            HStack(spacing: 10) {
                Image(systemName: "sparkle")
                    .foregroundStyle(ZenTheme.gooseYellow)
                VStack(alignment: .leading, spacing: 2) {
                    Text("解锁更多视角")
                        .font(ZenTheme.bodyFont(14))
                        .foregroundStyle(ZenTheme.inkBlack)
                    Text("自选维度 · 自选语气 · AI个性化生成")
                        .font(ZenTheme.caption(11))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(ZenTheme.gooseYellow.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(ZenTheme.gooseYellow.opacity(0.3), lineWidth: 1)
                    )
            )
        }
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        HStack(spacing: 16) {
            Button {
                withAnimation(.easeInOut(duration: 0.5)) { viewModel.reset() }
                HapticManager.selection()
            } label: {
                Label("再来一次", systemImage: "arrow.counterclockwise")
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
                Text("正在召唤勇气…")
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
