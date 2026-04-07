import SwiftUI

@main
struct ZenChoiceApp: App {
    @State private var viewModel = ZenViewModel()

    init() {
        CloudSyncManager.shared.start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
                .onOpenURL { url in
                    viewModel.handleDeepLink(url: url)
                }
        }
    }
}
