import ComposableArchitecture
import _MapKit_SwiftUI
import CoreLocation
import MapKit

@Reducer
struct AppReducer {

    @Dependency(\.dismiss) private var dismiss

    @ObservableState
    struct State: Equatable {

        var username = ""
        var toggle = false
        var notification: String?


        var router = StackState<AppRouter.State>()

    }

    enum Action: Equatable, BindableAction {

        case binding(BindingAction<State>)

        case routeToOverview
        case pop
        case router(StackAction<AppRouter.State, AppRouter.Action>)

    }

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .routeToOverview:
                state.router.append(.overview(.init()))

                return .run { send in
                    await send(.pop)
                }
            case .router(.element(_, action: .overview(.pop))):
                _ = state.router.popLast()

                return .none
            case .router(.element(_, action: .overview(.settings(.presented(.apps(.presented(.updateSettings))))))):
                state.notification = "Home update from Apps"

                return .none
            default:
                return .none
            }
        }
        .forEach(\.router, action: \.router)
    }

}
