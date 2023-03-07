import Foundation

protocol Endpointable {
    func request<T: Request>(target: T) async throws -> T.Response
}

/// 'Endpoint'는 Request를 Session에 접근하는 객체.
public class Endpoint: Endpointable {
    
    public static let shared = Endpoint()
    
    private let session: Sessionable
    
    internal init(session: Sessionable = Session()) {
        self.session = session
    }
    
    /// Request를 Session에 전달하고 Response를 반환.
    ///
    public func request<T: Request>(target: T) async throws -> T.Response {
    
        let url = target.urlInfo.url
        let request = target.requestInfo.requests(url: url)

        let data = try await session.creatSessionTask(request: request)
        return try JSONDecoder().decode(T.Response.self, from: data)
    }
}
