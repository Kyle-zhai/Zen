import SwiftUI

struct ZenTypeCardView: View {
    let zenType: ZenType
    let isChinese: Bool
    var showQRCode: Bool = false

    private var cn: Bool { isChinese }

    var body: some View {
        VStack(spacing: 0) {
            TerminalTitleBar(title: "zentype — result")

            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 20)

                Text("$ zentype --analyze")
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.terminalText.opacity(0.25))
                    .padding(.horizontal, 20)

                Spacer().frame(height: 28)

                // Code name
                Text(cn ? zenType.codeCN : zenType.codeEN)
                    .font(.system(size: cn ? 28 : 22, weight: .black, design: .monospaced))
                    .foregroundStyle(ZenTheme.terminalText)
                    .padding(.horizontal, 20)

                Spacer().frame(height: 6)

                // Star name
                Text(cn ? zenType.starCN : zenType.starEN)
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundStyle(ZenTheme.gooseYellow.opacity(0.7))
                    .padding(.horizontal, 20)

                Spacer().frame(height: 20)

                // Tagline
                Text(cn ? zenType.taglineCN : zenType.taglineEN)
                    .font(.system(size: 13, weight: .regular, design: .monospaced))
                    .foregroundStyle(ZenTheme.terminalText.opacity(0.5))
                    .lineSpacing(4)
                    .padding(.horizontal, 20)

                Spacer().frame(height: 18)

                // Labels
                let labels = cn ? zenType.labelsCN : zenType.labelsEN
                HStack(spacing: 8) {
                    ForEach(Array(labels.enumerated()), id: \.offset) { _, label in
                        Text(label)
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                            .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(ZenTheme.gooseYellow.opacity(0.06))
                            )
                    }
                }
                .padding(.horizontal, 20)

                Spacer()

                Rectangle()
                    .fill(ZenTheme.terminalStroke)
                    .frame(height: 1)
                    .padding(.horizontal, 20)

                Spacer().frame(height: 12)

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
                        Text(cn ? "参悟你的命星" : "FIND YOUR STAR")
                            .font(.system(size: 8, weight: .bold, design: .monospaced))
                            .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                            .tracking(1)
                    }
                    Spacer()
                    if showQRCode { AppStoreQRCode(size: 40) }
                }
                .padding(.horizontal, 20)

                Spacer().frame(height: 16)
            }
            .background(ZenTheme.terminalBg)
        }
        .frame(width: 340, height: 440)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(ZenTheme.terminalStroke, lineWidth: 0.5))
        .shadow(color: .black.opacity(0.5), radius: 20, y: 10)
    }
}
