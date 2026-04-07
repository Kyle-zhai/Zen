import SwiftUI

struct InviteCodeView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    @State private var inputCode: String = ""
    @State private var isRedeeming: Bool = false
    @State private var redeemMessage: String?
    @State private var redeemSuccess: Bool = false
    @State private var copied: Bool = false

    private var cn: Bool { viewModel.L.isChinese }
    private var inviteManager: InviteCodeManager { InviteCodeManager.shared }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {
                    headerSection
                    myCodeSection
                    redeemSection
                    statsSection
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
            }
            .background(ZenTheme.ricePaper.ignoresSafeArea())
            .navigationTitle(cn ? "邀请码" : "Invite Code")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(cn ? "完成" : "Done") { dismiss() }
                }
            }
        }
        .task {
            if let userId = viewModel.authManager.userId {
                await inviteManager.ensureCode(userId: userId)
                await inviteManager.checkAndApplyRewards(userId: userId)
                viewModel.syncSubscriptionStatus()
            }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: 10) {
            Text(cn ? "邀请好友，一起禅意" : "Invite Friends to ZenChoice")
                .font(ZenTheme.bodyFont(18))
                .foregroundStyle(ZenTheme.terminalText)

            Text(cn
                 ? "分享你的邀请码，好友可获得 30 天免费体验\n你将获得 +7 天 Pro 奖励"
                 : "Share your code — friends get 30 days free Pro\nYou earn +7 days Pro reward")
                .font(ZenTheme.caption(13))
                .foregroundStyle(ZenTheme.mist)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
    }

    // MARK: - My Code

    private var myCodeSection: some View {
        VStack(spacing: 16) {
            codeHeaderRow
            codeContentView
            freeProBadge
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(ZenTheme.cardSurface)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(ZenTheme.terminalStroke, lineWidth: 0.5)
                )
        )
    }

    private var codeHeaderRow: some View {
        HStack {
            Image(systemName: "ticket")
                .font(.system(size: 11))
                .foregroundStyle(ZenTheme.gooseYellow.opacity(0.6))
            Text(cn ? "我的邀请码" : "My Invite Code")
                .font(ZenTheme.caption(12))
                .foregroundStyle(ZenTheme.mist.opacity(0.7))
            Spacer()
            if let exp = inviteManager.codeExpiresAt {
                let days = max(0, Int(exp.timeIntervalSince(Date()) / 86400))
                Text(cn ? "\(days)天后过期" : "Expires in \(days)d")
                    .font(.system(size: 10, weight: .regular, design: .monospaced))
                    .foregroundStyle(days <= 1 ? ZenTheme.cinnabar.opacity(0.7) : ZenTheme.mist.opacity(0.4))
            }
        }
    }

    @ViewBuilder
    private var codeContentView: some View {
        if let code = inviteManager.myCode {
            codeDisplay(code)
        } else {
            codeLoadingView
        }
    }

    private func codeDisplay(_ code: String) -> some View {
        VStack(spacing: 14) {
            Text(code)
                .font(.system(size: 32, weight: .bold, design: .monospaced))
                .foregroundStyle(ZenTheme.gooseYellow)
                .kerning(6)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(ZenTheme.terminalBg)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(ZenTheme.gooseYellow.opacity(0.15), lineWidth: 1)
                        )
                )

            codeActionButtons(code)
        }
    }

    private func codeActionButtons(_ code: String) -> some View {
        HStack(spacing: 12) {
            Button {
                #if os(iOS)
                UIPasteboard.general.string = code
                #endif
                copied = true
                HapticManager.impact()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { copied = false }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: copied ? "checkmark" : "doc.on.doc")
                        .font(.system(size: 12))
                    Text(copied ? (cn ? "已复制" : "Copied") : (cn ? "复制" : "Copy"))
                        .font(ZenTheme.caption(13))
                }
                .foregroundStyle(copied ? ZenTheme.jade : ZenTheme.terminalText)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(ZenTheme.cardSurface)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(ZenTheme.terminalStroke, lineWidth: 0.5)
                        )
                )
            }

            shareButton(code)
        }
    }

    private func shareButton(_ code: String) -> some View {
        let shareText = cn
            ? "我在用「禅意 ZenChoice」，输入邀请码 \(code) 可获得 30 天免费 Pro！下载：\(ZenAppStore.url)"
            : "I'm using ZenChoice! Enter invite code \(code) for 30 days free Pro! Download: \(ZenAppStore.url)"
        return ShareLink(item: shareText) {
            HStack(spacing: 6) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 12))
                Text(cn ? "分享" : "Share")
                    .font(ZenTheme.caption(13))
            }
            .foregroundStyle(ZenTheme.gooseYellow)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(ZenTheme.gooseYellow.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(ZenTheme.gooseYellow.opacity(0.2), lineWidth: 0.5)
                    )
            )
        }
    }

    private var codeLoadingView: some View {
        VStack(spacing: 8) {
            ProgressView()
                .tint(ZenTheme.gooseYellow)
            Text(cn ? "正在生成邀请码…" : "Generating invite code…")
                .font(ZenTheme.caption(12))
                .foregroundStyle(ZenTheme.mist.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(ZenTheme.terminalBg)
        )
    }

    @ViewBuilder
    private var freeProBadge: some View {
        if inviteManager.hasFreePro, let text = inviteManager.freeProRemainingText {
            HStack(spacing: 6) {
                Image(systemName: "crown.fill")
                    .font(.system(size: 10))
                    .foregroundStyle(ZenTheme.gooseYellow)
                Text(cn ? "免费 Pro 剩余 \(text)" : "Free Pro: \(text) remaining")
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                    .foregroundStyle(ZenTheme.gooseYellow.opacity(0.8))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(ZenTheme.gooseYellow.opacity(0.08))
                    .overlay(Capsule().strokeBorder(ZenTheme.gooseYellow.opacity(0.15), lineWidth: 0.5))
            )
        }
    }

    // MARK: - Redeem

    private var redeemSection: some View {
        VStack(spacing: 14) {
            HStack {
                Image(systemName: "arrow.down.circle")
                    .font(.system(size: 11))
                    .foregroundStyle(ZenTheme.jade.opacity(0.6))
                Text(cn ? "输入好友的邀请码" : "Enter a Friend's Code")
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.mist.opacity(0.7))
                Spacer()
            }

            HStack(spacing: 10) {
                TextField(cn ? "输入邀请码" : "Enter code", text: $inputCode)
                    .font(.system(size: 18, weight: .medium, design: .monospaced))
                    .foregroundStyle(ZenTheme.terminalText)
                    .textCase(.uppercase)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(ZenTheme.terminalBg)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(ZenTheme.terminalStroke, lineWidth: 0.5)
                            )
                    )
                    #if os(iOS)
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
                    #endif

                Button {
                    Task { await redeemCode() }
                } label: {
                    if isRedeeming {
                        ProgressView()
                            .tint(ZenTheme.inkBlack)
                            .frame(width: 60, height: 38)
                    } else {
                        Text(cn ? "兑换" : "Redeem")
                            .font(ZenTheme.caption(14))
                            .foregroundStyle(ZenTheme.inkBlack)
                            .frame(width: 60, height: 38)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(inputCode.count >= 4 ? ZenTheme.gooseYellow : ZenTheme.mist.opacity(0.2))
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .disabled(inputCode.count < 4 || isRedeeming)
            }

            if let msg = redeemMessage {
                HStack(spacing: 6) {
                    Image(systemName: redeemSuccess ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                        .font(.system(size: 11))
                        .foregroundStyle(redeemSuccess ? ZenTheme.jade : ZenTheme.cinnabar)
                    Text(msg)
                        .font(ZenTheme.caption(12))
                        .foregroundStyle(redeemSuccess ? ZenTheme.jade : ZenTheme.cinnabar.opacity(0.8))
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(ZenTheme.cardSurface)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(ZenTheme.terminalStroke, lineWidth: 0.5)
                )
        )
        .animation(.easeInOut(duration: 0.3), value: redeemMessage)
    }

    // MARK: - Stats

    private var statsSection: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "chart.bar")
                    .font(.system(size: 11))
                    .foregroundStyle(ZenTheme.mist.opacity(0.5))
                Text(cn ? "邀请统计" : "Invite Stats")
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.mist.opacity(0.7))
                Spacer()
            }

            HStack(spacing: 0) {
                statItem(
                    value: "\(inviteManager.totalInvites)",
                    label: cn ? "成功邀请" : "Invited",
                    icon: "person.2"
                )
                Divider()
                    .frame(height: 30)
                    .background(ZenTheme.terminalStroke)
                statItem(
                    value: inviteManager.hasFreePro ? (inviteManager.freeProRemainingText ?? "-") : "-",
                    label: cn ? "Pro 剩余" : "Pro Left",
                    icon: "crown"
                )
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(ZenTheme.cardSurface)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(ZenTheme.terminalStroke, lineWidth: 0.5)
                )
        )
    }

    private func statItem(value: String, label: String, icon: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
            Text(value)
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .foregroundStyle(ZenTheme.terminalText)
            Text(label)
                .font(ZenTheme.caption(10))
                .foregroundStyle(ZenTheme.mist.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Actions

    private func redeemCode() async {
        guard let userId = viewModel.authManager.userId else {
            redeemMessage = cn ? "请先登录" : "Please sign in first"
            redeemSuccess = false
            return
        }

        isRedeeming = true
        let result = await inviteManager.redeemCode(inputCode, myUserId: userId)
        isRedeeming = false

        switch result {
        case .success(let days):
            redeemMessage = cn ? "兑换成功！获得 \(days) 天免费 Pro" : "Success! \(days) days free Pro granted"
            redeemSuccess = true
            inputCode = ""
            HapticManager.success()
            viewModel.syncSubscriptionStatus()
            // Immediately generate this user's own invite code for chain sharing
            await inviteManager.ensureCode(userId: userId)
        case .alreadyRedeemed:
            redeemMessage = cn ? "该邀请码已被使用" : "This code has already been used"
            redeemSuccess = false
        case .expired:
            redeemMessage = cn ? "邀请码已过期" : "This code has expired"
            redeemSuccess = false
        case .selfRedeem:
            redeemMessage = cn ? "不能使用自己的邀请码" : "Cannot use your own code"
            redeemSuccess = false
        case .notFound:
            redeemMessage = cn ? "邀请码不存在" : "Code not found"
            redeemSuccess = false
        case .alreadyHasFreePro:
            redeemMessage = cn ? "你已拥有免费 Pro，无需再次兑换" : "You already have free Pro"
            redeemSuccess = false
        case .error(let msg):
            redeemMessage = cn ? "兑换失败：\(msg)" : "Error: \(msg)"
            redeemSuccess = false
        }
    }
}

#Preview {
    InviteCodeView()
        .environment(ZenViewModel())
}
