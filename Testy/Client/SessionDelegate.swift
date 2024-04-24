import Foundation
import Dependencies
import Get

class SessionDelegate: APIClientDelegate, DependencyKey {

    static var liveValue: any APIClientDelegate = SessionDelegate()
    static var testValue: any APIClientDelegate = SessionDelegate()

    var token = ""

    func client(
        _ client: APIClient,
        shouldRetry task: URLSessionTask,
        error: any Error,
        attempts: Int
    ) async throws -> Bool {
        guard
            let response = task.response as? HTTPURLResponse,
            response.statusCode == 401,
            attempts < 2
        else { return false }

        return true
    }

    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }

}

extension DependencyValues {

    var sessionDelegate: APIClientDelegate {
        get { self[SessionDelegate.self] }
        set { self[SessionDelegate.self] = newValue }
    }

}
