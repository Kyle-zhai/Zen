import SwiftUI

struct ResultCardView: View {
    let dimensionResult: DimensionResult
    let delay: Double
    let onShare: () -> Void

    @State private var appeared = false
    @State private var breathing = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Text(dimensionResult.emoji)
                    .font(.title2)

                Text(dimensionResult.dimensionTitle)
                    .font(ZenTheme.calligraphy(15))
                    .foregroundStyle(ZenTheme.inkBlack)

                Spacer()

                Button {
                    onShare()
                    HapticManager.selection()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.caption)
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                }
            }

            Text(dimensionResult.content)
                .font(ZenTheme.bodyFont(14))
                .foregroundStyle(ZenTheme.distantMountain.opacity(0.85))
                .lineSpacing(6)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.white)
                .shadow(color: ZenTheme.inkBlack.opacity(0.04), radius: 8, y: 3)
        )
        .opacity(appeared ? (breathing ? 1.0 : 0.94) : 0)
        .offset(y: appeared ? 0 : 20)
        .onAppear {
            withAnimation(.easeOut(duration: 0.6).delay(delay)) {
                appeared = true
            }
            withAnimation(
                .easeInOut(duration: 3)
                    .repeatForever(autoreverses: true)
                    .delay(delay + 0.6)
            ) {
                breathing = true
            }
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        ResultCardView(
            dimensionResult: DimensionResult(
                id: UUID(),
                dimensionId: "evolution",
                dimensionTitle: "进化论视角",
                emoji: "🦕",
                content: "38亿年前，一个单细胞生物决定不再躺平……"
            ),
            delay: 0,
            onShare: {}
        )
    }
    .padding()
    .background(ZenTheme.ivory)
}
