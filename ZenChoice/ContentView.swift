import SwiftUI

struct ContentView: View {
    @Environment(ZenViewModel.self) private var viewModel

    var body: some View {
        Group {
            if !viewModel.authManager.isLoggedIn {
                AuthView()
            } else if viewModel.authManager.needsProfileSetup {
                ProfileSetupView()
            } else {
                MainContentView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.authManager.isLoggedIn)
        .animation(.easeInOut(duration: 0.3), value: viewModel.authManager.needsProfileSetup)
    }
}

#Preview {
    ContentView()
        .environment(ZenViewModel())
}
