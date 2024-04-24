import ComposableArchitecture

@Reducer
struct UsersReducer {

    @Dependency(\.usersClient) private var usersClient: any UsersClientProtocol

    struct State: Equatable {

        var users: [User]

    }

    enum Action: Equatable {

        case fetchUsers
        case updateUsers([User])

    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchUsers:
                return .run { send in
                    let response = try await usersClient.getUsers()
                    await send(.updateUsers(response.map { User(from: $0) }))
                }
            case .updateUsers(let users):
                state.users = users

                return .none
            }
        }
    }

}

