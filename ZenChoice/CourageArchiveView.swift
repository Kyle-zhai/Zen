import SwiftUI

struct CourageArchiveView: View {
    @Environment(ZenViewModel.self) private var viewModel

    private var cn: Bool { viewModel.L.isChinese }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.archiveRecords.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()
                        Image(systemName: "book.closed")
                            .font(.system(size: 40))
                            .foregroundStyle(ZenTheme.mist.opacity(0.2))
                        Text(cn ? "尚无记录" : "No Records")
                            .font(ZenTheme.calligraphy(18))
                            .foregroundStyle(ZenTheme.mist.opacity(0.4))
                        Text(cn ? "你的勇气档案将在此显示" : "Your courage archive will appear here")
                            .font(ZenTheme.caption(13))
                            .foregroundStyle(ZenTheme.mist.opacity(0.3))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    List(viewModel.archiveRecords) { record in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("「\(record.wish)」")
                                .font(ZenTheme.bodyFont(15))
                                .foregroundStyle(ZenTheme.ricePaper)

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
                                        .foregroundStyle(ZenTheme.mist.opacity(0.5))
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
