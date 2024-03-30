import SwiftUI
import ComposableArchitecture

struct OverviewView: View {

    @Bindable var store: StoreOf<OverviewReducer>

    var body: some View {
        VStack(spacing: 16) {
            Text("Pop")
                .onTapGesture {
                    store.send(.pop)
                }
            Text("Settings")
                .onTapGesture {
                    store.send(.presentSettings)
                }
        }
        .sheet(
            item: $store.scope(state: \.settings, action: \.settings)
        ) { store in
            SettingsView(store: store)
        }
    }

}

#Preview {

    OverviewView(store: StoreOf<OverviewReducer>(
        initialState: OverviewReducer.State(),
        reducer: OverviewReducer.init))

}



