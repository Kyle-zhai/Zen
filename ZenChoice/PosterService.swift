import SwiftUI

// MARK: - Poster Rendering

#if os(iOS)
enum PosterService {

    @MainActor
    static func render(record: DecisionRecord) -> UIImage? {
        let view = PosterContentView(record: record)
        let renderer = ImageRenderer(content: view)
        renderer.scale = 3.0
        return renderer.uiImage
    }
}
#endif

// MARK: - Poster View (9:16)

struct PosterContentView: View {
    let record: DecisionRecord

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    ZenTheme.inkBlack,
                    Color(hex: 0x2C3E50),
                    ZenTheme.distantMountain,
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            RadialGradient(
                colors: [.white.opacity(0.05), .clear],
                center: .center,
                startRadius: 20,
                endRadius: 250
            )

            VStack(spacing: 0) {
                Spacer().frame(height: 56)

                // Logo
                VStack(spacing: 4) {
                    Text("禅择")
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundStyle(.white)
                    Text("Z E N C H O I C E")
                        .font(.system(size: 10, weight: .light))
                        .foregroundStyle(.white.opacity(0.5))
                        .tracking(3)
                }

                Spacer().frame(height: 44)

                // Wish
                Text("「\(record.wish)」")
                    .font(.system(size: 14, weight: .regular, design: .serif))
                    .foregroundStyle(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                Spacer().frame(height: 28)

                // Date – hero element
                VStack(spacing: 10) {
                    Rectangle()
                        .fill(ZenTheme.gooseYellow.opacity(0.6))
                        .frame(width: 40, height: 1)

                    Text(record.formattedDate)
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .foregroundStyle(ZenTheme.gooseYellow)

                    Rectangle()
                        .fill(ZenTheme.gooseYellow.opacity(0.6))
                        .frame(width: 40, height: 1)
                }

                Spacer().frame(height: 36)

                // Featured reason
                if let key = record.freeReasons.keys.sorted().first,
                   let reason = record.freeReasons[key]
                {
                    VStack(spacing: 8) {
                        Text(key)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.white.opacity(0.5))
                            .tracking(2)

                        Text(reason)
                            .font(.system(size: 13, weight: .regular, design: .serif))
                            .foregroundStyle(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                            .padding(.horizontal, 30)
                    }
                }

                Spacer()

                // QR placeholder
                VStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.white)
                        .frame(width: 64, height: 64)
                        .overlay(
                            VStack(spacing: 2) {
                                Image(systemName: "qrcode")
                                    .font(.system(size: 30))
                                Text("扫码")
                                    .font(.system(size: 7))
                            }
                            .foregroundStyle(ZenTheme.inkBlack)
                        )

                    Text("禅择 · 择你所择")
                        .font(.system(size: 10, weight: .light))
                        .foregroundStyle(.white.opacity(0.4))
                }

                Spacer().frame(height: 36)
            }
        }
        .frame(width: 360, height: 640)
    }
}

#Preview {
    PosterContentView(
        record: DecisionRecord(
            id: UUID(),
            userId: UUID(),
            wish: "面试顺利",
            recommendedDate: Date(),
            freeReasons: [
                "赛博频率": "当日全球数据流总量将达到 π 的第42位小数循环。",
                "群体心理": "社交媒体情绪指数达到峰值。",
                "生物节律": "你的身心灵三相交汇。",
                "数字符号": "日期数字之和为吉数。",
            ],
            premiumReport: nil,
            createdAt: .now
        )
    )
    .frame(width: 360, height: 640)
}
