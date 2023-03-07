import Foundation

public extension NetworkAPI {
    
    /// method, headers, parameter 와 같은 Reqeust 정보를 담는 타입.
    ///
    struct RequestInfo<T: Encodable> {
        var method: HTTPMethod
        var headers: [HTTPHeader]?
        var parameters: T?

        public init(method: HTTPMethod,
                    headers: [HTTPHeader]? = nil,
                    parameters: T? = nil) {
            self.method = method
            self.headers = headers
            self.parameters = parameters
        }
    }
}

extension NetworkAPI.RequestInfo {
    
    /// Reqeust 정보를 가지고 URLRequest를 구현하는 메서드
    ///
    /// - Parameter url : NetworkAPI.URLInfo 타입으로 가공된 URL
    /// - Parameter cachePolicy: URLRequest CachePolicy를 지정
    /// 
    func requests(url: URL, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy)
        request.httpMethod = method.value
        request.httpBody = parameters.flatMap { try? JSONEncoder().encode($0) }
        headers?.forEach { httpHeader in
            request.setValue(httpHeader.value, forHTTPHeaderField: httpHeader.name.description)
        }
        return request
    }
}
