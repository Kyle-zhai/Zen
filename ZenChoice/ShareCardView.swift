import SwiftUI

struct ShareCardView: View {
    let wish: String
    let dimensionResult: DimensionResult
    let date: Date

    private var formattedDate: String {
        let f = DateFormatter()
        f.dateFormat = "yyyy.M.d"
        return f.string(from: date)
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 32)

            // User's wish
            Text("「\(wish)」")
                .font(.system(size: 15, weight: .medium, design: .serif))
                .foregroundStyle(ZenTheme.distantMountain)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            Spacer().frame(height: 24)

            // Encouragement content
            Text(dimensionResult.content)
                .font(.system(size: 14, weight: .regular, design: .serif))
                .foregroundStyle(ZenTheme.inkBlack.opacity(0.85))
                .multilineTextAlignment(.leading)
                .lineSpacing(6)
                .padding(.horizontal, 24)

            Spacer().frame(height: 20)

            // Dimension attribution
            HStack(spacing: 4) {
                Spacer()
                Text("──")
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
                Text("\(dimensionResult.dimensionTitle) \(dimensionResult.emoji)")
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
            }
            .padding(.horizontal, 24)

            Spacer()

            // Footer: app name + date
            HStack {
                Text("·")
                Text("禅择 ZenChoice")
                    .font(.system(size: 10, weight: .light))
                Text("·")
                Text(formattedDate)
                    .font(.system(size: 10, weight: .light))
                Text("·")
            }
            .foregroundStyle(ZenTheme.distantMountain.opacity(0.35))

            Spacer().frame(height: 20)
        }
        .frame(width: 340, height: 460)
        .background(ZenTheme.ivory)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(ZenTheme.distantMountain.opacity(0.08), lineWidth: 1)
        )
    }
}

#Preview {
    ShareCardView(
        wish: "辞职",
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
    .background(Color.gray.opacity(0.2))
}
