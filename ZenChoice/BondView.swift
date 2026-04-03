import SwiftUI

struct BondView: View {
    @Environment(ZenViewModel.self) private var viewModel

    @State private var isLoading = false
    @State private var showInviteSheet = false
    @State private var showEncourageSheet = false
    @State private var selectedFriend: FriendDisplay?

    private var cn: Bool { viewModel.L.isChinese }

    var body: some View {
        NavigationStack {
            ZStack {
                ZenBackground()

                if isLoading {
                    ProgressView()
                } else if viewModel.socialManager.friendDisplayList.isEmpty {
                    emptyState
                } else {
                    friendList
                }
            }
            .navigationTitle(cn ? "善缘" : "Bonds")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showInviteSheet = true
                    } label: {
                        Image(systemName: "person.badge.plus")
                            .foregroundStyle(ZenTheme.gooseYellow)
                    }
                }
            }
            .sheet(isPresented: $showInviteSheet) {
                inviteSheet
            }
            .sheet(item: $selectedFriend) { friend in
                AnonymousEncourageView(friend: friend)
                    .environment(viewModel)
            }
            .task {
                isLoading = true
                try? await viewModel.socialManager.fetchBonds()
                isLoading = false
            }
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.2.circle")
                .font(.system(size: 48))
                .foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
            Text(cn ? "还没有善缘" : "No bonds yet")
                .font(ZenTheme.bodyFont(16))
                .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
            Text(cn ? "邀请好友结善缘，互相匿名鼓励" : "Invite friends to form bonds and encourage each other")
                .font(ZenTheme.caption(13))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Button {
                showInviteSheet = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "plus.circle")
                    Text(cn ? "结善缘" : "Add Bond")
                }
                .font(ZenTheme.calligraphy(16))
                .foregroundStyle(ZenTheme.gooseYellow)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(ZenTheme.inkBlack)
                )
            }
            .padding(.top, 8)
        }
    }

    // MARK: - Friend List

    private var friendList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.socialManager.friendDisplayList) { friend in
                    friendRow(friend)
                }
            }
            .padding()
        }
    }

    private func friendRow(_ friend: FriendDisplay) -> some View {
        HStack(spacing: 14) {
            // Avatar placeholder
            Circle()
                .fill(ZenTheme.distantMountain.opacity(0.1))
                .frame(width: 44, height: 44)
                .overlay {
                    Text(String(friend.nickname.prefix(1)))
                        .font(ZenTheme.calligraphy(18))
                        .foregroundStyle(ZenTheme.inkBlack)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(friend.nickname)
                    .font(ZenTheme.bodyFont(16))
                    .foregroundStyle(ZenTheme.inkBlack)

                if friend.resonanceCount > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: "heart.circle.fill")
                            .font(.caption2)
                            .foregroundStyle(ZenTheme.gooseYellow)
                        Text(cn ? "共鸣 \(friend.resonanceCount) 次" : "\(friend.resonanceCount) resonance")
                            .font(ZenTheme.caption(11))
                            .foregroundStyle(ZenTheme.gooseYellow)
                    }
                }
            }

            Spacer()

            // Anonymous encourage button
            Button {
                selectedFriend = friend
            } label: {
                Image(systemName: "text.bubble")
                    .font(.body)
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white.opacity(0.8))
        )
    }

    // MARK: - Invite Sheet

    private var inviteSheet: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "link.badge.plus")
                    .font(.system(size: 48))
                    .foregroundStyle(ZenTheme.gooseYellow)

                Text(cn ? "分享链接结善缘" : "Share link to form a bond")
                    .font(ZenTheme.bodyFont(16))
                    .foregroundStyle(ZenTheme.inkBlack)

                Text(cn ? "好友打开链接后，双方自动结为善缘\n可以互相匿名鼓励" : "When your friend opens the link,\nyou'll be connected as bonds")
                    .font(ZenTheme.caption(13))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                if let link = viewModel.socialManager.bondInviteLink() {
                    ShareLink(item: link) {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                            Text(cn ? "分享链接" : "Share Link")
                        }
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(ZenTheme.inkBlack)
                        )
                    }
                }

                Spacer()
            }
            .navigationTitle(cn ? "结善缘" : "New Bond")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(cn ? "关闭" : "Close") {
                        showInviteSheet = false
                    }
                }
            }
        }
    }
}
