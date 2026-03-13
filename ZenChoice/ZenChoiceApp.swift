import SwiftUI

@main
struct ZenChoiceApp: App {
    @State private var viewModel = ZenViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
