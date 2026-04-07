import SwiftUI
import UIKit

// MARK: - Design System — Terminal Aesthetic

enum ZenTheme {
    // Core palette
    static let inkBlack    = Color(hex: 0x0A0A0F)
    static let inkDark     = Color(hex: 0x14141E)
    static let inkMid      = Color(hex: 0x1E1E2C)
    static let mist        = Color(hex: 0x7A7A92)

    // Accents
    static let cinnabar    = Color(hex: 0xE84040)
    static let gooseYellow = Color(hex: 0xF0C060)
    static let jade        = Color(hex: 0x40C080)

    // Surfaces
    static let ivory       = Color(hex: 0x0A0A0F)

    // Adaptive colors (dark / light)
    static let ricePaper = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 216/255.0, green: 216/255.0, blue: 224/255.0, alpha: 1)
            : UIColor(red: 26/255.0, green: 26/255.0, blue: 34/255.0, alpha: 1)
    })

    static let cardSurface = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 22/255.0, green: 22/255.0, blue: 34/255.0, alpha: 1)
            : UIColor.white
    })

    static let terminalBg = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 28/255.0, green: 28/255.0, blue: 32/255.0, alpha: 1)
            : UIColor.white
    })

    static let terminalTitleBg = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 42/255.0, green: 42/255.0, blue: 46/255.0, alpha: 1)
            : UIColor(red: 237/255.0, green: 234/255.0, blue: 228/255.0, alpha: 1)
    })

    static let terminalText = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? .white
            : UIColor(red: 26/255.0, green: 26/255.0, blue: 34/255.0, alpha: 1)
    })

    static let terminalStroke = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor.white.withAlphaComponent(0.06)
            : UIColor.black.withAlphaComponent(0.08)
    })

    // Typography
    static func calligraphy(_ size: CGFloat) -> Font {
        .system(size: size, weight: .bold, design: .monospaced)
    }

    static func bodyFont(_ size: CGFloat = 15) -> Font {
        .system(size: size, weight: .regular, design: .monospaced)
    }

    static func caption(_ size: CGFloat = 12) -> Font {
        .system(size: size, weight: .light, design: .monospaced)
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

// MARK: - Background

struct ZenBackground: View {
    @Environment(\.colorScheme) private var colorScheme

    private var bg: Color {
        colorScheme == .dark ? ZenTheme.ivory : Color(hex: 0xF5F1EA)
    }

    var body: some View {
        bg.ignoresSafeArea()
    }
}

// MARK: - App Logo (replaces SealStamp)

struct SealStamp: View {
    let text: String
    var size: CGFloat = 32

    var body: some View {
        Image("AppLogo")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 2))
    }
}

// MARK: - Terminal Title Bar

struct TerminalTitleBar: View {
    var title: String = "terminal"

    var body: some View {
        HStack(spacing: 8) {
            Circle().fill(Color(hex: 0xFF5F56)).frame(width: 12, height: 12)
            Circle().fill(Color(hex: 0xFFBD2E)).frame(width: 12, height: 12)
            Circle().fill(Color(hex: 0x27C93F)).frame(width: 12, height: 12)
            Spacer()
            Text(title)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(ZenTheme.terminalText.opacity(0.3))
            Spacer()
            Color.clear.frame(width: 44, height: 12)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(ZenTheme.terminalTitleBg)
    }
}

// MARK: - Card Modifier

struct ZenCardStyle: ViewModifier {
    var elevated: Bool = false
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 2)
                    .fill(ZenTheme.cardSurface.opacity(colorScheme == .dark ? (elevated ? 0.95 : 0.85) : 1.0))
                    .shadow(color: .black.opacity(colorScheme == .dark ? (elevated ? 0.4 : 0.2) : (elevated ? 0.12 : 0.06)),
                            radius: elevated ? 8 : 4, y: elevated ? 3 : 1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(ZenTheme.gooseYellow.opacity(0.12), lineWidth: 1)
            )
    }
}

extension View {
    func zenCard(elevated: Bool = false) -> some View {
        modifier(ZenCardStyle(elevated: elevated))
    }
}

// MARK: - Gold Divider

struct GoldDivider: View {
    var width: CGFloat = 40

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<Int(width / 6), id: \.self) { _ in
                Rectangle()
                    .fill(ZenTheme.gooseYellow.opacity(0.3))
                    .frame(width: 4, height: 1)
            }
            Text("◆")
                .font(.system(size: 6, design: .monospaced))
                .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
            ForEach(0..<Int(width / 6), id: \.self) { _ in
                Rectangle()
                    .fill(ZenTheme.gooseYellow.opacity(0.3))
                    .frame(width: 4, height: 1)
            }
        }
    }
}

// MARK: - Cursor Blink

struct CursorBlink: ViewModifier {
    @State private var visible = true

    func body(content: Content) -> some View {
        content
            .opacity(visible ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    visible = false
                }
            }
    }
}

extension View {
    func cursorBlink() -> some View {
        modifier(CursorBlink())
    }
}

// MARK: - App Store QR Code

enum ZenAppStore {
    /// Update this with the real App Store URL once published.
    static let url = "https://apps.apple.com/app/zenchoice/id6744105853"
}

struct AppStoreQRCode: View {
    var size: CGFloat = 44

    var body: some View {
        if let img = Self.generate() {
            Image(uiImage: img)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 2))
        }
    }

    private static func generate() -> UIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = ZenAppStore.url.data(using: .ascii)
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("M", forKey: "inputCorrectionLevel")
        guard let output = filter.outputImage else { return nil }
        let scale = 256.0 / output.extent.width
        let scaled = output.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        let ctx = CIContext()
        guard let cgImage = ctx.createCGImage(scaled, from: scaled.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
