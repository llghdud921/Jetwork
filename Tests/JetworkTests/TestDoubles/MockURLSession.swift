import Foundation
@testable import Jetwork

final class MockURLSession: URLSessionProtocol {
    
    var makeRequestFail: Bool
    
    init(makeRequestFail: Bool = false) {
        self.makeRequestFail = makeRequestFail
    }
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        let request = MockAPI.MockRequest()
        let url = request.urlInfo.url
        
        // Succeess Response
        let successResonse = HTTPURLResponse(url: url,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil)
        
        // Failure Response
        let failResonse = HTTPURLResponse(url: url,
                                             statusCode: 400,
                                             httpVersion: nil,
                                             headerFields: nil)
        
        guard let successResonse = successResonse,
              let failResonse = failResonse else {
            throw MockError.response
        }
        
        if makeRequestFail {
            return (MockData.bodyData, failResonse)
        } else {
            return (MockData.bodyData, successResonse)
        }
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let request = MockAPI.MockRequest()
        let url = request.urlInfo.url
        
        // Succeess Response
        let successResonse = HTTPURLResponse(url: url,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil)
        
        // Failure Response
        let failResonse = HTTPURLResponse(url: url,
                                             statusCode: 400,
                                             httpVersion: nil,
                                             headerFields: nil)
        
        let dataTask: URLSessionDataTask = MockURLSessionDataTask { data, response, error in
            if self.makeRequestFail {
                completionHandler(nil, failResonse, MockError.response)
            } else {
                completionHandler(MockData.bodyData, successResonse, nil)
            }
        }
        return dataTask
    }
}
