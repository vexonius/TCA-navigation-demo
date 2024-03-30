import ComposableArchitecture

@Reducer
struct AppsReducer {

    struct State: Equatable {

    }

    enum Action: Equatable {

        case updateSettings

    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }

}

