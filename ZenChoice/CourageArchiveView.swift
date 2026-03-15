import SwiftUI

struct CourageArchiveView: View {
    @Environment(ZenViewModel.self) private var viewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.archiveRecords.isEmpty {
                    ContentUnavailableView(
                        "尚无记录",
                        systemImage: "book.closed",
                        description: Text("你的勇气档案将在此显示")
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

                                if record.isShared {
                                    Label("已分享", systemImage: "checkmark.circle.fill")
                                        .font(ZenTheme.caption(11))
                                        .foregroundStyle(.green.opacity(0.6))
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("勇气档案")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .task {
                await viewModel.loadArchive()
            }
        }
    }
}

#Preview {
    CourageArchiveView()
        .environment(ZenViewModel())
}
