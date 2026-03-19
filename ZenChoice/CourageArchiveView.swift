import SwiftUI

struct CourageArchiveView: View {
    @Environment(ZenViewModel.self) private var viewModel

    private var cn: Bool { viewModel.L.isChinese }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.archiveRecords.isEmpty {
                    ContentUnavailableView(
                        cn ? "尚无记录" : "No Records",
                        systemImage: "book.closed",
                        description: Text(cn ? "你的勇气档案将在此显示（最多保存30条）" : "Your courage archive will appear here (up to 30 entries)")
                    )
                } else {
                    List(viewModel.archiveRecords) { record in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("「\(record.wish)」")
                                .font(ZenTheme.bodyFont(15))
                                .foregroundStyle(ZenTheme.inkBlack)

                            HStack(spacing: 6) {
                                ForEach(record.dimensions) { dim in
                                    Text(dim.emoji)
                                        .font(.caption)
                                }
                            }

                            HStack {
                                if let date = record.createdAt {
                                    Text(date, style: .date)
                                        .font(ZenTheme.caption(12))
                                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                                }

                                Spacer()

                                if record.isLLMGenerated {
                                    Label("AI", systemImage: "sparkles")
                                        .font(ZenTheme.caption(11))
                                        .foregroundStyle(ZenTheme.gooseYellow)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle(cn ? "勇气档案" : "Courage Archive")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .onAppear {
                viewModel.loadLocalArchive()
            }
        }
    }
}

#Preview {
    CourageArchiveView()
        .environment(ZenViewModel())
}
