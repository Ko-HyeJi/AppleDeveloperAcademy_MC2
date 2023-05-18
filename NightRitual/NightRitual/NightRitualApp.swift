import SwiftUI

@main
struct NightRitualApp: App {
    let data = DataModel()
    let viewModel = CameraViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(data)
                .environmentObject(viewModel)
        }
    }
}
