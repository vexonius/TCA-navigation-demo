import ComposableArchitecture

@Reducer
struct SettingsReducer {

    @ObservableState
    struct State: Equatable {

        @Presents var apps: AppsReducer.State?

        var notification: String?

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
            case .apps(.presented(.updateSettings)):
                state.notification = "Settings updated from Apps screen"

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

