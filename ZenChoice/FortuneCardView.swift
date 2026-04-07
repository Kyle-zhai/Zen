import SwiftUI

// MARK: - Artistic Quote View

struct ArtisticQuoteView: View {
    let text: String
    let isChinese: Bool
    @Environment(\.colorScheme) private var colorScheme

    private var inkColor: Color {
        colorScheme == .dark ? .white : .black
    }

    var body: some View {
        if isChinese {
            chineseLayout
        } else {
            englishLayout
        }
    }

    // Chinese: bold monospaced, clauses split at punctuation with indent on continuation
    private var chineseLayout: some View {
        let clauses = text.split(omittingEmptySubsequences: false, whereSeparator: { "，。、；！？".contains($0) })
            .map { String($0).trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        return VStack(alignment: .leading, spacing: 16) {
            ForEach(Array(clauses.enumerated()), id: \.offset) { idx, clause in
                Text(clause)
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .foregroundStyle(inkColor)
                    .tracking(1)
                    .padding(.leading, idx > 0 ? 28 : 0)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // English: Snell Roundhand — elegant Copperplate script
    private var englishLayout: some View {
        Text(text)
            .font(.custom("Snell Roundhand", size: text.count > 35 ? 20 : (text.count > 25 ? 23 : 26)))
            .foregroundStyle(inkColor)
            .lineSpacing(6)
            .minimumScaleFactor(0.7)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct FortuneCardView: View {
    let fortune: Fortune
    let isChinese: Bool
    var showQRCode: Bool = false

    private var cn: Bool { isChinese }

    var body: some View {
        VStack(spacing: 0) {
            TerminalTitleBar(title: "zen-oracle — \(formattedDate)")

            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 20)

                Text("$ zen-oracle --today")
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.terminalText.opacity(0.25))
                    .padding(.horizontal, 20)

                Spacer().frame(height: 24)

                // Fortune items
                fortuneRow(
                    label: cn ? "宜" : "DO",
                    text: cn ? fortune.should : fortune.shouldEN,
                    color: ZenTheme.jade
                )

                Spacer().frame(height: 14)

                fortuneRow(
                    label: cn ? "忌" : "SKIP",
                    text: cn ? fortune.shouldNot : fortune.shouldNotEN,
                    color: ZenTheme.cinnabar
                )

                Spacer().frame(height: 14)

                fortuneRow(
                    label: cn ? "幸运" : "LUCK",
                    text: cn ? fortune.luckyDecision : fortune.luckyDecisionEN,
                    color: ZenTheme.gooseYellow
                )

                Spacer().frame(height: 28)

                // Zen quote — artistic calligraphy
                ArtisticQuoteView(
                    text: cn ? fortune.zenQuote : fortune.zenQuoteEN,
                    isChinese: cn
                )
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Rectangle()
                    .fill(ZenTheme.terminalStroke)
                    .frame(height: 1)
                    .padding(.horizontal, 20)

                Spacer().frame(height: 12)

                cardFooter(cta: cn ? "你也来求签" : "DRAW YOURS")

                Spacer().frame(height: 16)
            }
            .background(ZenTheme.terminalBg)
        }
        .frame(width: 340, height: 480)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(ZenTheme.terminalStroke, lineWidth: 0.5))
        .shadow(color: .black.opacity(0.5), radius: 20, y: 10)
    }

    private func fortuneRow(label: String, text: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(label)
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .foregroundStyle(color)
                .frame(width: cn ? 26 : 36, alignment: .trailing)

            Text(text)
                .font(.system(size: 13, weight: .regular, design: .monospaced))
                .foregroundStyle(ZenTheme.terminalText.opacity(0.75))
                .lineSpacing(4)
        }
        .padding(.horizontal, 20)
    }

    private func cardFooter(cta: String) -> some View {
        HStack(spacing: 6) {
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
                .clipShape(RoundedRectangle(cornerRadius: 2))
            VStack(alignment: .leading, spacing: 2) {
                Text(cn ? "禅意" : "ZenChoice")
                    .font(.system(size: 10, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.terminalText.opacity(0.2))
                Text(cta)
                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                    .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                    .tracking(1)
            }
            Spacer()
            if showQRCode { AppStoreQRCode(size: 40) }
        }
        .padding(.horizontal, 20)
    }

    private var formattedDate: String {
        let f = DateFormatter()
        f.dateFormat = "yyyy.M.d"
        f.locale = Locale(identifier: isChinese ? "zh_CN" : "en_US")
        return f.string(from: Date())
    }
}
