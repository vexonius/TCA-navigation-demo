import ComposableArchitecture

@Reducer
struct OverviewReducer {

    @ObservableState
    struct State: Equatable {

        @Presents var settings: SettingsReducer.State?

    }

    enum Action: Equatable, ViewAction {

        case pop
        case view(View)
        case settings(PresentationAction<SettingsReducer.Action>)

        enum View {

            case popTap
            case settingsTap

        }

    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .view(.settingsTap):
                state.settings = SettingsReducer.State()

                return .none
            case .view(.popTap):
                return .send(.pop)
            default:
                return .none
            }
        }
        .ifLet(\.$settings, action: \.settings) {
            SettingsReducer()
        }
    }

}
