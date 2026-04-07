import SwiftUI

#if os(iOS)
enum PosterService {

    private static var currentScheme: ColorScheme {
        UITraitCollection.current.userInterfaceStyle == .dark ? .dark : .light
    }

    @MainActor
    static func renderShareCard(
        wish: String,
        dimensionResult: DimensionResult,
        isChinese: Bool = true
    ) -> UIImage? {
        let view = ShareCardView(
            wish: wish,
            dimensionResult: dimensionResult,
            date: Date(),
            isChinese: isChinese,
            showQRCode: true
        ).environment(\.colorScheme, currentScheme)
        let renderer = ImageRenderer(content: view)
        renderer.scale = 3.0
        return renderer.uiImage
    }

    @MainActor
    static func renderFortuneCard(fortune: Fortune, isChinese: Bool) -> UIImage? {
        let view = FortuneCardView(fortune: fortune, isChinese: isChinese, showQRCode: true)
            .environment(\.colorScheme, currentScheme)
        let renderer = ImageRenderer(content: view)
        renderer.scale = 3.0
        return renderer.uiImage
    }

    @MainActor
    static func renderZenTypeCard(zenType: ZenType, isChinese: Bool) -> UIImage? {
        let view = ZenTypeCardView(zenType: zenType, isChinese: isChinese, showQRCode: true)
            .environment(\.colorScheme, currentScheme)
        let renderer = ImageRenderer(content: view)
        renderer.scale = 3.0
        return renderer.uiImage
    }

    @MainActor
    static func renderZenTypeAdvancedCard(zenType: ZenType, isChinese: Bool, basicType: ZenType?) -> UIImage? {
        let view = ZenTypeAdvancedCardView(zenType: zenType, isChinese: isChinese, basicType: basicType, showQRCode: true)
            .environment(\.colorScheme, currentScheme)
        let renderer = ImageRenderer(content: view)
        renderer.scale = 3.0
        return renderer.uiImage
    }
}
#endif
