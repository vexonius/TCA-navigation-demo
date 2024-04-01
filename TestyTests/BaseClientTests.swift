import XCTest
@testable import Testy

final class BaseClientTests: XCTestCase {

    let client: any BaseApiClientProtocol = BaseApiClient()
    let parameters: RequestParams = nil

    func testGETRequest() async throws {
        let posts: [Post] = try await client.get(path: "/posts", parameters: parameters)

        XCTAssertNotNil(posts)
        XCTAssertEqual(posts.count, 100)
    }

    func testGETWithParamsRequest() async throws {
        let posts: [Post]? = try await client.get(path: "/posts", parameters: [("userId", String(1))])

        XCTAssertNotNil(posts)
        XCTAssertEqual(posts?.first?.userId, 1)
    }

    func testPOSTRequest() async throws {
        let body = Post(id: 0, title: "Hello", userId: nil)
        let post: Post? = try await client.post(path: "/posts", parameters: parameters, body: body)

        XCTAssertNotNil(post)
    }

    func testPUTRequest() async throws {
        let body = Post(id: 3, title: "Hej", userId: 3)
        let post: Post? = try await client.put(path: "/posts/3", parameters: parameters, body: body)

        XCTAssertNotNil(post)

        guard let post else { return }

        XCTAssertEqual(post.userId, 3)
    }

    func testPATCHRequest() async throws {
        let body = PostPatchBody(userId: 7)
        let post: Post? = try await client.patch(path: "/posts/3", parameters: parameters, body: body)

        XCTAssertNotNil(post)

        guard let post else { return }

        XCTAssertEqual(post.userId, 7)
    }

    func testDELETERequest() async throws {
        let body: Post? = nil
        try await client.delete(path: "/posts/3", body: body)
    }

}

extension BaseClientTests {

    struct Post: Encodable, Decodable {

        let id: Int
        let title: String
        let userId: Int?

    }

    struct PostPatchBody: Encodable {

        let userId: Int

    }

}
