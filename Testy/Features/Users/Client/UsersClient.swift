import Dependencies

class UsersClient: UsersClientProtocol, DependencyKey {

    static let liveValue: any UsersClientProtocol = UsersClient()
    static let testValue: any UsersClientProtocol = UsersClient()

    @Dependency(\.baseApiClient) var client: any BaseApiClientProtocol

    func getUsers() async throws -> [UserResponse] {
        try await client.get(path: "/users", parameters: [])
    }

}

extension DependencyValues {

    var usersClient: UsersClientProtocol {
        get { self[UsersClient.self] }
        set { self[UsersClient.self] = newValue }
    }

}
