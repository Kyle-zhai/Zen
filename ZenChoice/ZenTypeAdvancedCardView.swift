import SwiftUI

struct ZenTypeAdvancedCardView: View {
    let zenType: ZenType
    let isChinese: Bool
    var basicType: ZenType?
    var showQRCode: Bool = false

    private var cn: Bool { isChinese }

    var body: some View {
        VStack(spacing: 0) {
            TerminalTitleBar(title: "zentype — deep analysis")

            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 16)

                Text("$ zentype --deep-analyze --verbose")
                    .font(.system(size: 11, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.terminalText.opacity(0.2))
                    .padding(.horizontal, 20)

                Spacer().frame(height: 20)

                // Code name (large)
                Text(cn ? zenType.codeCN : zenType.codeEN)
                    .font(.system(size: cn ? 30 : 24, weight: .black, design: .monospaced))
                    .foregroundStyle(ZenTheme.terminalText)
                    .padding(.horizontal, 20)

                Spacer().frame(height: 4)

                // Star name
                Text(cn ? zenType.starCN : zenType.starEN)
                    .font(.system(size: 14, weight: .medium, design: .monospaced))
                    .foregroundStyle(ZenTheme.gooseYellow.opacity(0.8))
                    .padding(.horizontal, 20)

                Spacer().frame(height: 14)

                // Tagline
                Text(cn ? zenType.taglineCN : zenType.taglineEN)
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.terminalText.opacity(0.45))
                    .lineSpacing(4)
                    .padding(.horizontal, 20)

                Spacer().frame(height: 16)

                // Summary
                Text(cn ? zenType.summaryCN : zenType.summaryEN)
                    .font(.system(size: 11, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.terminalText.opacity(0.35))
                    .lineSpacing(5)
                    .padding(.horizontal, 20)
                    .lineLimit(5)

                Spacer().frame(height: 16)

                // Labels
                let labels = cn ? zenType.labelsCN : zenType.labelsEN
                HStack(spacing: 6) {
                    ForEach(Array(labels.enumerated()), id: \.offset) { _, label in
                        Text(label)
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                            .foregroundStyle(ZenTheme.gooseYellow.opacity(0.6))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(ZenTheme.gooseYellow.opacity(0.08))
                            )
                    }
                }
                .padding(.horizontal, 20)

                // Comparison line
                if let basic = basicType, basic.id != zenType.id {
                    Spacer().frame(height: 12)
                    HStack(spacing: 6) {
                        Text(cn ? "初级" : "Basic")
                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                            .foregroundStyle(ZenTheme.terminalText.opacity(0.2))
                        Text(cn ? basic.codeCN : basic.codeEN)
                            .font(.system(size: 9, weight: .regular, design: .monospaced))
                            .foregroundStyle(ZenTheme.terminalText.opacity(0.2))
                        Text("→")
                            .font(.system(size: 9, design: .monospaced))
                            .foregroundStyle(ZenTheme.gooseYellow.opacity(0.3))
                        Text(cn ? "深度" : "Deep")
                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                            .foregroundStyle(ZenTheme.gooseYellow.opacity(0.4))
                        Text(cn ? zenType.codeCN : zenType.codeEN)
                            .font(.system(size: 9, weight: .regular, design: .monospaced))
                            .foregroundStyle(ZenTheme.gooseYellow.opacity(0.4))
                    }
                    .padding(.horizontal, 20)
                }

                Spacer()

                Rectangle()
                    .fill(ZenTheme.terminalStroke)
                    .frame(height: 1)
                    .padding(.horizontal, 20)

                Spacer().frame(height: 10)

                // Footer
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
                        Text(cn ? "深度命星" : "DEEP ZEN STAR")
                            .font(.system(size: 8, weight: .bold, design: .monospaced))
                            .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                            .tracking(1)
                    }
                    Spacer()
                    if showQRCode { AppStoreQRCode(size: 40) }
                }
                .padding(.horizontal, 20)

                Spacer().frame(height: 14)
            }
            .background(ZenTheme.terminalBg)
        }
        .frame(width: 340, height: 540)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(ZenTheme.terminalStroke, lineWidth: 0.5))
        .shadow(color: .black.opacity(0.5), radius: 20, y: 10)
    }
}
