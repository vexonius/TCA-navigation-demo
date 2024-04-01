import Foundation
import Dependencies
import Get

class BaseApiClient: BaseApiClientProtocol, DependencyKey {

    static var liveValue: any BaseApiClientProtocol = BaseApiClient()
    static var testValue: any BaseApiClientProtocol = BaseApiClient()

    private let basePath = "https://jsonplaceholder.typicode.com"

    private var baseURL: URL { URL(string: basePath)! }

    @Dependency(\.sessionDelegate) private var sessionDelegate: APIClientDelegate

    private lazy var client: APIClient = {
        APIClient(baseURL: baseURL){
            $0.delegate = sessionDelegate
        }
    }()

    func get<Response: Decodable>(path: String, parameters: RequestParams) async throws -> Response {
        let request = Request<Response>(url: baseURL.appending(path: path), method: .get, query: parameters)

        return try await send(request: request)
    }

    func post<Response: Decodable, Body: Encodable>(
        path: String,
        parameters: RequestParams,
        body: Body
    ) async throws -> Response {
        let request = Request<Response>(url: baseURL.appending(path: path), method: .post, query: parameters, body: body)

        return try await send(request: request)
    }

    func put<Response: Decodable, Body: Encodable>(
        path: String,
        parameters: RequestParams,
        body: Body?
    ) async throws -> Response {
        let request = Request<Response>(url: baseURL.appending(path: path), method: .put, query: parameters, body: body)

        return try await send(request: request)
    }

    func patch<Response: Decodable, Body: Encodable>(
        path: String,
        parameters: RequestParams,
        body: Body?
    ) async throws -> Response {
        let request = Request<Response>(url: baseURL.appending(path: path), method: .patch, query: parameters, body: body)

        return try await send(request: request)
    }

    func delete<Body: Encodable>(path: String, body: Body?) async throws {
        let request = Request(url: baseURL.appending(path: path), method: .delete, body: body)

        try await sendVoid(request: request)
    }

    private func send<T: Decodable>(request: Request<T>) async throws -> T {
        let response = try await client.send(request)

        dump(request)

        return response.value
    }

    private func sendVoid(request: Request<Void>) async throws {
        try await client.send(request)
    }

}

extension DependencyValues {

    var baseApiClient: any BaseApiClientProtocol {
        get { self[BaseApiClient.self] }
        set { self[BaseApiClient.self] = newValue }
    }

}
