import SwiftUI
import MapKit
import ComposableArchitecture

@ViewAction(for: AppReducer.self)
struct AppView: View {

    @Bindable var store: StoreOf<AppReducer>

    var body: some View {
        NavigationStack(path: $store.scope(state: \.router, action: \.router)) {
            VStack {
                Button("Push Overview") {
                    send(.overviewTap)
                }

                Toggle(isOn: $store.toggle) {
                    Text("Toggle me")
                }
                .padding(.horizontal)
            }
        } destination: { store in
            switch store.case {
            case .overview(let store):
                OverviewView(store: store)
                    .navigationTitle("Overview")
            case .apps(let store):
                AppsView(store: store)
                    .navigationTitle("Apps")
            default:
                EmptyView()
            }
        }
        .safeAreaInset(edge: .bottom) {
            if let notification = store.notification {
                Text(notification)
                    .padding(.bottom, 24)
            }
        }
    }

}

#Preview {

    AppView(store:
        Store(
            initialState: AppReducer.State(),
            reducer: AppReducer.init))

}
