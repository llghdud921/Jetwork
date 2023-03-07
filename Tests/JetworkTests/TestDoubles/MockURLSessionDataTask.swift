import Foundation
@testable import Jetwork

class MockURLSessionDataTask: URLSessionDataTask {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    private let completion: CompletionHandler

    init(completion: @escaping CompletionHandler) {
        self.completion = completion
    }

    override func resume() {
        // create some data
        completion(nil, nil, nil)
    }
}
