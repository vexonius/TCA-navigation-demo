typealias RequestParams = [(String, String?)]?

protocol BaseApiClientProtocol {

    @discardableResult
    func get<Response: Decodable>(path: String, parameters: RequestParams) async throws -> Response

    @discardableResult
    func post<Response: Decodable, Body: Encodable>(
        path: String,
        parameters: RequestParams,
        body: Body
    ) async throws -> Response

    @discardableResult
    func put<Response: Decodable, Body: Encodable>(
        path: String,
        parameters: RequestParams,
        body: Body?
    ) async throws -> Response

    @discardableResult
    func patch<Response: Decodable, Body: Encodable>(
        path: String,
        parameters: RequestParams,
        body: Body?
    ) async throws -> Response

    func delete<Body: Encodable>(path: String, body: Body?) async throws

}
