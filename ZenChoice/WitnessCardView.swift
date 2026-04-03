import SwiftUI

struct WitnessCardView: View {
    let wish: String
    let aiSummary: String
    let responses: [CourageResponse]
    let isChinese: Bool

    private var cn: Bool { isChinese }

    var body: some View {
        VStack(spacing: 0) {
            // Top accent
            Rectangle()
                .fill(ZenTheme.gooseYellow)
                .frame(height: 6)

            VStack(spacing: 18) {
                // Title
                Text(cn ? "缘起契约" : "Bond of Courage")
                    .font(ZenTheme.calligraphy(20))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .padding(.top, 20)

                // Wish
                Text("「\(wish)」")
                    .font(.system(size: 18, weight: .heavy, design: .serif))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)

                // AI summary
                if !aiSummary.isEmpty {
                    VStack(spacing: 4) {
                        Text(aiSummary)
                            .font(.system(size: 12, weight: .regular, design: .serif))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
                            .lineLimit(3)
                            .multilineTextAlignment(.center)
                        Text(cn ? "— 禅意解读" : "— ZenChoice")
                            .font(ZenTheme.caption(10))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                    }
                    .padding(.horizontal, 20)
                }

                // Divider
                HStack(spacing: 6) {
                    Rectangle().fill(ZenTheme.gooseYellow).frame(width: 30, height: 1)
                    Text(cn ? "见证人" : "Witnesses")
                        .font(ZenTheme.caption(10))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                    Rectangle().fill(ZenTheme.gooseYellow).frame(width: 30, height: 1)
                }

                // Signatures
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(responses) { response in
                        HStack(spacing: 8) {
                            if let stamp = response.emojiStamp, !stamp.isEmpty {
                                Text(stamp).font(.title3)
                            }
                            Text(response.content)
                                .font(.system(size: 13, weight: .regular, design: .serif))
                                .foregroundStyle(ZenTheme.inkBlack)
                                .lineLimit(2)
                            Spacer()
                            Text("— \(response.isAnonymous ? (cn ? "匿名" : "Anon") : (response.senderName ?? ""))")
                                .font(ZenTheme.caption(11))
                                .foregroundStyle(.secondary)
                            if response.voiceUrl != nil {
                                Text("🎙").font(.caption)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)

                Spacer().frame(height: 8)

                // Footer
                VStack(spacing: 4) {
                    Text(cn ? "禅意 ZenChoice" : "ZenChoice")
                        .font(ZenTheme.caption(10))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                    Text(cn ? "扫码结缘加持" : "Scan to send blessings")
                        .font(ZenTheme.caption(9))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
                }
                .padding(.bottom, 16)
            }
        }
        .frame(width: 340)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.08), radius: 16, y: 8)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
