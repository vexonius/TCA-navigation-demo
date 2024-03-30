import ComposableArchitecture

@Reducer
struct OverviewReducer {

    @ObservableState
    struct State: Equatable {

        @Presents var settings: SettingsReducer.State?

    }

    enum Action: Equatable {

        case pop
        case presentSettings
        case settings(PresentationAction<SettingsReducer.Action>)

    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .presentSettings:
                state.settings = SettingsReducer.State()

                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$settings, action: \.settings) {
            SettingsReducer()
        }
    }

}
