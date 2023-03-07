import Foundation

protocol Sessionable {
    func creatSessionTask(request: URLRequest) async throws -> Data
}

/// 'Session'는 URLSession을 가지고 다우는 객체.
public class Session: Sessionable {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession(configuration: .default)) {
        self.session = session
    }
    
    /// Request를 전달받아 Task를 생성하는 메서드.
    ///
    func creatSessionTask(request: URLRequest) async throws -> Data {
        let (data, response) = try await self.session.data(for: request, delegate: nil)
        
        guard let urlResponse = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTPURLResponse(response)
        }
        
        guard 200..<300 ~= urlResponse.statusCode else {
            throw NetworkError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return data
    }
    
}
