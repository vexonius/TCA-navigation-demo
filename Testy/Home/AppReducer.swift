import ComposableArchitecture
import _MapKit_SwiftUI
import CoreLocation
import MapKit

@Reducer
struct AppReducer {

    @Dependency(\.dismiss) private var dismiss

    @ObservableState
    struct State: Equatable {

        var notification: String?
        var toggle: Bool = false

        var router = StackState<AppRouter.State>()

    }

    enum Action: Equatable, ViewAction, BindableAction {

        case routeToOverview
        case pop

        case binding(BindingAction<State>)
        case view(View)
        case router(StackAction<AppRouter.State, AppRouter.Action>)

        enum View {

            case overviewTap
            case toggleTap

        }

    }

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .view(.toggleTap):
                state.toggle.toggle()

                return .none
            case .view(.overviewTap):
                state.router.append(.overview(.init()))

                return .none
            case .router(.element(_, action: .overview(.pop))):
                _ = state.router.popLast()

                return .none
            case .router(.element(_, action: .overview(.settings(.presented(.apps(.presented(.updateSettings))))))):
                state.notification = "Home was updated from Settings"

                return .none
            default:
                return .none
            }
        }
        .forEach(\.router, action: \.router)
    }

}
