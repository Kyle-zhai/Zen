import SwiftUI

struct ResultCardView: View {
    let dimensionKey: String
    let reason: String
    let delay: Double

    @State private var appeared = false
    @State private var breathing = false

    private var dimension: ReasonDimension? {
        ReasonDimension.allCases.first { $0.rawValue == dimensionKey }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: dimension?.icon ?? "questionmark.circle")
                .font(.title3)
                .foregroundStyle(dimension?.accent ?? .gray)
                .frame(width: 36, height: 36)
                .background(
                    Circle()
                        .fill((dimension?.accent ?? .gray).opacity(0.12))
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(dimensionKey)
                    .font(ZenTheme.calligraphy(14))
                    .foregroundStyle(ZenTheme.inkBlack)

                Text(reason)
                    .font(ZenTheme.bodyFont(14))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.8))
                    .lineSpacing(4)
            }
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
            dimensionKey: "赛博频率",
            reason: "当日全球数据流总量将达到 π 的第42位小数循环，形成罕见的「数字共振窗口」。",
            delay: 0
        )
        ResultCardView(
            dimensionKey: "群体心理",
            reason: "社交媒体情绪指数预测，此日大众「同意阈值」达到峰值——提需求，不被拒。",
            delay: 0.12
        )
    }
    .padding()
    .background(ZenTheme.ivory)
}
