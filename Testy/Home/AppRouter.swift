import ComposableArchitecture

@Reducer(state: .equatable, action: .equatable)
enum AppRouter {

    case overview(OverviewReducer)
    case users(UsersReducer)
    case apps(AppsReducer)

}
