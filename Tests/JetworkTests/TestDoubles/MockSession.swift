import Foundation
@testable import Jetwork

class MockSession: Sessionable {
    
    var makeRequestFail = false
    
    func creatSessionTask(request: URLRequest) async throws -> Data {
        
        if makeRequestFail {
            throw MockError.response
        } else {
            return MockData.bodyData
        }
    }
    
    func creatSessionTask(request: URLRequest, completion: @escaping ((Result<Data, Jetwork.NetworkError>) -> Void)) {
        if makeRequestFail {
            completion(.failure(NetworkError.noData))
        } else {
            completion(.success(MockData.bodyData))
        }
    }
}
