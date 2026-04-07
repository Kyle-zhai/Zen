import SwiftUI

struct ContentView: View {
    @Environment(ZenViewModel.self) private var viewModel

    var body: some View {
        MainContentView()
    }
}

#Preview {
    ContentView()
        .environment(ZenViewModel())
}
