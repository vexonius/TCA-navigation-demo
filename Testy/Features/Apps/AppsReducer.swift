import ComposableArchitecture

@Reducer
struct AppsReducer {

    struct State: Equatable {

    }

    enum Action: Equatable, ViewAction {

        case updateSettings
        case view(View)

        enum View {

            case updateSettingsTap

        }

    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .view(.updateSettingsTap):
                return .send(.updateSettings)
            default:
                return .none
            }
        }
    }

}

