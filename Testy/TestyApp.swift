import SwiftUI
import ComposableArchitecture

@main
struct TestyApp: App {

    var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppReducer.State()) { AppReducer()._printChanges() })
        }
    }

}
