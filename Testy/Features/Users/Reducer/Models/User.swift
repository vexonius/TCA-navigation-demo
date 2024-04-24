struct User: Equatable {

    let id: Int
    let name: String
    let username: String
    let email: String

}

extension User {

    init(from model: UserResponse) {
        id = model.id
        name = model.name
        username = model.username
        email = model.email
    }

}
