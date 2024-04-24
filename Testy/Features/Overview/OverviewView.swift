import SwiftUI
import ComposableArchitecture

@ViewAction(for: OverviewReducer.self)
struct OverviewView: View {

    @Bindable var store: StoreOf<OverviewReducer>

    var body: some View {
        VStack(spacing: 16) {
            Text("Pop")
                .onTapGesture {
                    send(.popTap)
                }
            Text("Settings")
                .onTapGesture {
                    send(.settingsTap)
                }
        }
        .sheet(item: $store.scope(state: \.settings, action: \.settings)) { store in
            SettingsView(store: store)
        }
    }

}

#Preview {

    OverviewView(store: StoreOf<OverviewReducer>(
        initialState: OverviewReducer.State(),
        reducer: OverviewReducer.init))

}



