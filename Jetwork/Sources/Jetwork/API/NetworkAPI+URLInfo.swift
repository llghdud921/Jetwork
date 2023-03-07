import Foundation

public extension NetworkAPI {
    
    /// URL을 구성하는 데 필요한 URL 정보를 담는 타입.
    ///
    struct URLInfo {
        let scheme: String
        let host: String
        let port: Int?
        let path: String
        let query: [String: String]?
        
        public init(scheme: String = "https",
                    host: String,
                    port: Int? = nil,
                    path: String,
                    query: [String: String]? = nil) {
            self.scheme = scheme
            self.host = host
            self.port = port
            self.path = path
            self.query = query
        }
    }
}

extension NetworkAPI.URLInfo {
    
    /// URL 정보를 가지고 URL 객체를 생성하는 프로퍼티.
    ///
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = query?.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else {
            fatalError()
        }
        return url
    }
}
