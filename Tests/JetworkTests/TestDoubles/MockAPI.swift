import Foundation
@testable import Jetwork

enum MockAPI { }

extension MockAPI {
    struct MockRequest: Request {
        typealias Parameter = EmptyParameter
        typealias Response = MockResponse
        
        var urlInfo: URLInfo = .MockAPI(path: "/test")
        var requestInfo: Jetwork.NetworkAPI.RequestInfo<Jetwork.EmptyParameter> = .init(method: .get)
    }
}

extension NetworkAPI.URLInfo {
    
    /// MockAPI host 지정
    static func MockAPI(path: String) -> Self {
        return .init(host: "test.api.com", path: path)
    }
}
