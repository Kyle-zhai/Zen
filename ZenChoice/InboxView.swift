import SwiftUI

struct InboxView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    @State private var isLoading = false
    @State private var selectedRequest: CourageRequest?
    @State private var responses: [CourageResponse] = []
    @State private var showDetail = false

    private var cn: Bool { viewModel.L.isChinese }
    private var manager: SocialManager { viewModel.socialManager }

    var body: some View {
        NavigationStack {
            Group {
                if manager.requests.isEmpty && !isLoading {
                    ContentUnavailableView(
                        cn ? "暂无善缘" : "No blessings yet",
                        systemImage: "tray",
                        description: Text(cn ? "去结果页分享，邀请朋友为你加持" : "Share from results to invite friends")
                    )
                } else {
                    List(manager.requests) { request in
                        Button {
                            selectedRequest = request
                            Task { await loadResponses(for: request) }
                        } label: {
                            requestRow(request)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(cn ? "善缘簿" : "Blessings")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(cn ? "完成" : "Done") { dismiss() }
                }
            }
            .task {
                isLoading = true
                try? await manager.fetchMyRequests()
                isLoading = false
            }
            .sheet(isPresented: $showDetail) {
                if let request = selectedRequest {
                    InboxDetailView(
                        request: request,
                        responses: responses,
                        socialManager: manager,
                        isChinese: cn
                    )
                }
            }
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
        }
    }

    private func requestRow(_ request: CourageRequest) -> some View {
        HStack(spacing: 12) {
            Text(request.type == .encourage ? "🙏" : "✍️")
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text("「\(request.wish)」")
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.inkBlack)

                HStack(spacing: 4) {
                    if request.type == .encourage {
                        Text(cn ? "收到 \(request.responseCount) 条加持" : "\(request.responseCount) blessings received")
                    } else {
                        Text(cn ? "\(request.responseCount)/\(request.maxResponses) 人已见证" : "\(request.responseCount)/\(request.maxResponses) witnessed")
                    }
                }
                .font(ZenTheme.caption(12))
                .foregroundStyle(.secondary)
            }

            Spacer()

            if let date = request.createdAt {
                Text(date, style: .relative)
                    .font(ZenTheme.caption(11))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }

    private func loadResponses(for request: CourageRequest) async {
        do {
            responses = try await manager.fetchResponses(requestId: request.id)
            showDetail = true
        } catch {
            // Failed to load
        }
    }
}

// MARK: - Detail View

struct InboxDetailView: View {
    let request: CourageRequest
    let responses: [CourageResponse]
    let socialManager: SocialManager
    let isChinese: Bool

    @Environment(\.dismiss) private var dismiss
    @State private var voiceRecorder = VoiceRecorder()

    private var cn: Bool { isChinese }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    Text("「\(request.wish)」")
                        .font(ZenTheme.calligraphy(20))
                        .foregroundStyle(ZenTheme.inkBlack)
                        .padding(.top, 20)

                    if responses.isEmpty {
                        Text(cn ? "还没有人响应" : "No responses yet")
                            .font(ZenTheme.bodyFont(14))
                            .foregroundStyle(.secondary)
                            .padding(.top, 40)
                    }

                    ForEach(responses) { response in
                        responseCard(response)
                    }

                    ShareLink(item: socialManager.shareLink(for: request)) {
                        Label(cn ? "再次分享" : "Share again", systemImage: "square.and.arrow.up")
                            .font(ZenTheme.bodyFont(14))
                            .foregroundStyle(ZenTheme.distantMountain)
                    }
                    .padding(.top, 20)

                    Spacer().frame(height: 40)
                }
                .padding(.horizontal)
            }
            .background(ZenBackground())
            .navigationTitle(request.type == .encourage ? (cn ? "加持详情" : "Blessings") : (cn ? "见证详情" : "Witnesses"))
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(cn ? "完成" : "Done") { dismiss() }
                }
            }
        }
    }

    private func responseCard(_ response: CourageResponse) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if let perspective = response.perspective, !perspective.isEmpty {
                    Text(perspective)
                        .font(ZenTheme.caption(12))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Capsule().fill(ZenTheme.gooseYellow.opacity(0.15)))
                }
                if let stamp = response.emojiStamp, !stamp.isEmpty {
                    Text(stamp).font(.title2)
                }
                Spacer()
                Text(response.isAnonymous ? (cn ? "匿名" : "Anonymous") : (response.senderName ?? ""))
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(.secondary)
            }

            Text(response.content)
                .font(ZenTheme.bodyFont(15))
                .foregroundStyle(ZenTheme.inkBlack)
                .lineSpacing(4)

            if let urlString = response.voiceUrl, let url = URL(string: urlString) {
                Button {
                    if voiceRecorder.isPlaying {
                        voiceRecorder.stopPlaying()
                    } else {
                        voiceRecorder.playRemote(url: url)
                    }
                } label: {
                    Label(
                        voiceRecorder.isPlaying ? (cn ? "停止" : "Stop") : (cn ? "播放语音" : "Play voice"),
                        systemImage: voiceRecorder.isPlaying ? "stop.circle" : "play.circle"
                    )
                    .font(ZenTheme.caption(13))
                    .foregroundStyle(ZenTheme.gooseYellow)
                }
            }
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 14).fill(.white.opacity(0.8)))
    }
}
