import XCTest
import ComposableArchitecture
@testable import Testy

final class UsersReducerTests: XCTestCase {

    @MainActor
    func testFetchingUsers() async {
        let store = TestStore(initialState: UsersReducer.State(users: []), reducer: UsersReducer.init) {
            $0.usersClient = UsersReducerMock()
        }

        await store.send(.fetchUsers)

        await store.receive(\.updateUsers, timeout: .seconds(1)) {
            $0.users = [
                User(id: 0, name: "Testy", username: "testy", email: "testy@mail.com"),
                User(id: 1, name: "Two", username: "two", email: "two@mail.com")
            ]
        }
    }

}


class UsersReducerMock: UsersClientProtocol {

    func getUsers() async throws -> [Testy.UserResponse] {
        [
            UserResponse(id: 0, name: "Testy", username: "testy", email: "testy@mail.com"),
            UserResponse(id: 1, name: "Two", username: "two", email: "two@mail.com")
        ]
    }


}
