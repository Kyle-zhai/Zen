import SwiftUI

enum ZenTheme {
    static let distantMountain = Color(hex: 0x2D3436)
    static let gooseYellow     = Color(hex: 0xF6E58D)
    static let inkBlack        = Color(hex: 0x1E272E)
    static let ivory           = Color(hex: 0xF5F6FA)

    static func calligraphy(_ size: CGFloat) -> Font {
        .system(size: size, weight: .bold, design: .serif)
    }

    static func bodyFont(_ size: CGFloat = 15) -> Font {
        .system(size: size, weight: .regular, design: .rounded)
    }

    static func caption(_ size: CGFloat = 12) -> Font {
        .system(size: size, weight: .light, design: .rounded)
    }
}

// MARK: - Color Hex Init

extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}

// MARK: - Zen Background

struct ZenBackground: View {
    var body: some View {
        ZStack {
            ZenTheme.ivory.ignoresSafeArea()

            // Subtle paper grain
            RadialGradient(
                colors: [
                    ZenTheme.distantMountain.opacity(0.03),
                    .clear,
                ],
                center: .topLeading,
                startRadius: 50,
                endRadius: 500
            )
            .ignoresSafeArea()

            RadialGradient(
                colors: [
                    ZenTheme.inkBlack.opacity(0.04),
                    .clear,
                ],
                center: .bottomTrailing,
                startRadius: 30,
                endRadius: 600
            )
            .ignoresSafeArea()

            // Ink wash bottom edge
            VStack {
                Spacer()
                LinearGradient(
                    colors: [.clear, ZenTheme.inkBlack.opacity(0.06)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 220)
            }
            .ignoresSafeArea()

            // Top-left brush stroke hint
            Ellipse()
                .fill(ZenTheme.distantMountain.opacity(0.025))
                .frame(width: 300, height: 180)
                .blur(radius: 50)
                .offset(x: -100, y: -300)
        }
    }
}

// MARK: - Dimension Icon Mapping

enum ReasonDimension: String, CaseIterable {
    case cyber   = "赛博频率"
    case social  = "群体心理"
    case bio     = "生物节律"
    case symbol  = "数字符号"

    var icon: String {
        switch self {
        case .cyber:  return "wifi"
        case .social: return "person.3.fill"
        case .bio:    return "heart.circle.fill"
        case .symbol: return "hexagon.fill"
        }
    }

    var accent: Color {
        switch self {
        case .cyber:  return .cyan
        case .social: return .orange
        case .bio:    return .pink
        case .symbol: return .purple
        }
    }
}
