import SwiftUI
import ComposableArchitecture

struct AppsView: View {

    let store: StoreOf<AppsReducer>

    var body: some View {
        NavigationView {
            VStack {
                Text("Apps")
                    .navigationTitle("Apps")
                
                Button("Update settings") {
                    store.send(.updateSettings)
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



