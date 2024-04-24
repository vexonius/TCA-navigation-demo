protocol UsersClientProtocol {

    func getUsers() async throws -> [UserResponse]

}
