import SwiftUI
import ComposableArchitecture

struct UsersView: View {

    let store: StoreOf<UsersReducer>

    var body: some View {
        Text("Users")
    }

}

#Preview {

    UsersView(store: StoreOf<UsersReducer>(
        initialState: UsersReducer.State(),
        reducer: UsersReducer.init))

}



