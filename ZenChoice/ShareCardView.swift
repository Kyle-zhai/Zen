import SwiftUI

struct ShareCardView: View {
    let wish: String
    let dimensionResult: DimensionResult
    let date: Date
    var isChinese: Bool = true

    private var formattedDate: String {
        let f = DateFormatter()
        f.dateFormat = "yyyy.M.d"
        return f.string(from: date)
    }

    /// Pick an accent color based on dimension ID hash for variety
    private var accentColor: Color {
        let colors: [Color] = [
            Color(hex: 0xFF6B6B), // coral
            Color(hex: 0x4ECDC4), // teal
            Color(hex: 0xFFE66D), // yellow
            Color(hex: 0xA8E6CF), // mint
            Color(hex: 0xDDA0DD), // plum
            Color(hex: 0x74B9FF), // sky
        ]
        let hash = abs(dimensionResult.dimensionId.hashValue)
        return colors[hash % colors.count]
    }

    var body: some View {
        VStack(spacing: 0) {
            // Top accent strip
            accentColor
                .frame(height: 6)

            VStack(spacing: 0) {
                Spacer().frame(height: 28)

                // Large emoji as visual anchor
                Text(dimensionResult.emoji)
                    .font(.system(size: 44))

                Spacer().frame(height: 16)

                // The wish — BIG and BOLD, the viral hook
                Text("\u{201C}\(wish)\u{201D}")
                    .font(.system(size: 22, weight: .heavy, design: .serif))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 28)

                Spacer().frame(height: 6)

                // Perspective tag pill
                Text(dimensionResult.dimensionTitle)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(accentColor)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        Capsule().fill(accentColor.opacity(0.12))
                    )

                Spacer().frame(height: 20)

                // Divider
                HStack(spacing: 6) {
                    Rectangle().fill(accentColor.opacity(0.4)).frame(width: 24, height: 1.5)
                    Circle().fill(accentColor.opacity(0.5)).frame(width: 4, height: 4)
                    Rectangle().fill(accentColor.opacity(0.4)).frame(width: 24, height: 1.5)
                }

                Spacer().frame(height: 16)

                // Encouragement excerpt — truncated for intrigue
                Text(dimensionResult.content)
                    .font(.system(size: 13, weight: .regular, design: .serif))
                    .foregroundStyle(ZenTheme.inkBlack.opacity(0.75))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(5)
                    .lineLimit(6)
                    .padding(.horizontal, 24)

                Spacer()

                // Bottom bar: branding + CTA
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(isChinese ? "禅择" : "ZenChoice")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundStyle(ZenTheme.inkBlack.opacity(0.7))
                        Text(formattedDate)
                            .font(.system(size: 9, weight: .light))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                    }

                    Spacer()

                    // Subtle CTA for virality
                    Text(isChinese ? "✦ 你也试试" : "✦ Try yours")
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule().fill(ZenTheme.inkBlack.opacity(0.75))
                        )
                }
                .padding(.horizontal, 24)

                Spacer().frame(height: 20)
            }
        }
        .frame(width: 340, height: 520)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(ZenTheme.distantMountain.opacity(0.06), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.08), radius: 16, y: 8)
    }
}

#Preview {
    ShareCardView(
        wish: "辞职去环游世界",
        dimensionResult: DimensionResult(
            id: UUID(),
            dimensionId: "evolution",
            dimensionTitle: "进化论视角",
            emoji: "🦕",
            content: "38亿年前，一个单细胞生物决定不再躺平，拼了命地分裂。它的后代爬上了岸，长出了腿，扛过了五次物种大灭绝，学会了直立行走，发明了外卖和Wi-Fi。这一切，就是为了让你——它最新的版本——坐在这里纠结要不要辞职？你对得起那个单细胞吗？去，别让38亿年的努力白费。"
        ),
        date: Date()
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
