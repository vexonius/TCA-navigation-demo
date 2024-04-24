import Combine
import Dependencies

class UsersClient: UsersClientProtocol, DependencyKey {

    static let liveValue: any UsersClientProtocol = UsersClient()
    static let testValue: any UsersClientProtocol = UsersClient()

    func getUsers() async throws -> [UserResponse] {
        try await Task.sleep(for: .seconds(2))

        return [
            UserResponse(id: 0, name: "Tuki", username: "tuki", email: "tuki@mail.com")
        ]
    }

}

extension DependencyValues {

    var usersClient: UsersClientProtocol {
        get { self[UsersClient.self] }
        set { self[UsersClient.self] = newValue }
    }

}
