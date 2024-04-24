import ComposableArchitecture

@Reducer
struct SettingsReducer {

    @ObservableState
    struct State: Equatable {

        @Presents var apps: AppsReducer.State?

    }

    enum Action: Equatable, ViewAction {

        case view(View)
        case apps(PresentationAction<AppsReducer.Action>)

        enum View {

            case presentAppsTap

        }

    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .view(.presentAppsTap):
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

