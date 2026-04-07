import SwiftUI

struct ResultCardView: View {
    let dimensionResult: DimensionResult
    let delay: Double
    let onShare: () -> Void

    @State private var appeared = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 8) {
                Text(dimensionResult.emoji)
                    .font(.system(size: 15))

                Text(dimensionResult.dimensionTitle)
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundStyle(ZenTheme.ricePaper.opacity(0.85))

                Spacer()

                Button {
                    onShare()
                    HapticManager.selection()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(ZenTheme.mist.opacity(0.3))
                }
            }

            // Content
            Text(dimensionResult.content)
                .font(.system(size: 13, weight: .regular, design: .monospaced))
                .foregroundStyle(ZenTheme.mist.opacity(0.7))
                .lineSpacing(6)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(ZenTheme.cardSurface.opacity(0.9))
        )
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(ZenTheme.gooseYellow.opacity(0.25))
                .frame(width: 2)
                .padding(.vertical, 12)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(ZenTheme.mist.opacity(0.06), lineWidth: 0.5)
        )
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 16)
        .onAppear {
            withAnimation(.easeOut(duration: 0.4).delay(delay)) {
                appeared = true
            }
        }
    }
}
