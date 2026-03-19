import SwiftUI

#if os(iOS)
enum PosterService {

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
            isChinese: isChinese
        )
        let renderer = ImageRenderer(content: view)
        renderer.scale = 3.0
        return renderer.uiImage
    }
}
#endif
