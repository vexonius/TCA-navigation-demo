import SwiftUI
import ComposableArchitecture

@ViewAction(for: AppsReducer.self)
struct AppsView: View {

    let store: StoreOf<AppsReducer>

    var body: some View {
        NavigationView {
            VStack {
                Text("Apps")
                    .navigationTitle("Apps")
                
                Button("Update settings") {
                    send(.updateSettingsTap)
                }
            }
        }
    }

}

#Preview {

    AppsView(store: StoreOf<AppsReducer>(
        initialState: AppsReducer.State(),
        reducer: AppsReducer.init))

}



