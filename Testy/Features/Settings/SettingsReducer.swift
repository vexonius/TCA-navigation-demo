import ComposableArchitecture

@Reducer
struct SettingsReducer {

    @ObservableState
    struct State: Equatable {

        @Presents var apps: AppsReducer.State?

    }

    enum Action: Equatable {

        case presentApps
        case apps(PresentationAction<AppsReducer.Action>)

    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .presentApps:
                state.apps = AppsReducer.State()

                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$apps, action: \.apps) {
            AppsReducer()
        }
    }

}

