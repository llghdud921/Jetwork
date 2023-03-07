import Foundation

protocol Endpointable {
    func request<T: Request>(target: T) async throws -> T.Response
    func request<T: Request>(target: T, completion: @escaping (Result<T.Response, NetworkError>) -> Void)
}

/// 'Endpoint'는 Request를 Session에 접근하는 객체.
public final class Endpoint: Endpointable {
    
    public static let shared = Endpoint()
    
    private let session: Sessionable
    
    internal init(session: Sessionable = Session()) {
        self.session = session
    }
    
    /// Request를 Session에 전달하고 Response를 반환. with Swift Concurrency
    ///
    public func request<T: Request>(target: T) async throws -> T.Response {
    
        let url = target.urlInfo.url
        let request = target.requestInfo.requests(url: url)

        let data = try await session.creatSessionTask(request: request)
        return try JSONDecoder().decode(T.Response.self, from: data)
    }
    
    /// Request를 Session에 전달하고 Response를 반환.
    ///
    public func request<T: Request>(target: T, completion: @escaping (Result<T.Response, NetworkError>) -> Void) {
    
        let url = target.urlInfo.url
        let request = target.requestInfo.requests(url: url)

        session.creatSessionTask(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decoding))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }

        
    }

}
