import SwiftUI
import ComposableArchitecture

struct SettingsView: View {

    @Bindable var store: StoreOf<SettingsReducer>

    var body: some View {
        NavigationView {
            VStack {
                Text("Apps")
                    .onTapGesture {
                        store.send(.presentApps)
                    }
            }
            .safeAreaInset(edge: .bottom) {
                if let notification = store.notification {
                    Text(notification)
                        .padding(.bottom, 24)
                }
            }
            .navigationTitle("Settings")
            .sheet(item: $store.scope(state: \.apps, action: \.apps)) { store in
                AppsView(store: store)
            }
        }
    }

}

#Preview {

    SettingsView(store: StoreOf<SettingsReducer>(
        initialState: SettingsReducer.State(),
        reducer: SettingsReducer.init))

}



