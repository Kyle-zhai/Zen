import SwiftUI

#if os(iOS)
enum PosterService {

    @MainActor
    static func renderShareCard(
        wish: String,
        dimensionResult: DimensionResult
    ) -> UIImage? {
        let view = ShareCardView(
            wish: wish,
            dimensionResult: dimensionResult,
            date: Date()
        )
        let renderer = ImageRenderer(content: view)
        renderer.scale = 3.0
        return renderer.uiImage
    }
}
#endif
