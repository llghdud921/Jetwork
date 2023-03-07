import Foundation

protocol Sessionable {
    func creatSessionTask(request: URLRequest) async throws -> Data
    func creatSessionTask(request: URLRequest, completion: @escaping ((Result<Data, NetworkError>) -> Void))
}

/// 'Session'는 URLSession을 가지고 다우는 객체.
public final class Session: Sessionable {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession(configuration: .default)) {
        self.session = session
    }
    
    /// Request를 전달받아 Task를 생성하는 메서드. with Swift Concurrency
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
    
    /// Request를 전달받아 Task를 생성하는 메서드.
    ///
    func creatSessionTask(request: URLRequest, completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.nonHTTPURLResponse(response)))
                return
            }
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.unacceptableStatusCode(response.statusCode)))
                return
            }
            
            if let error = error {
                completion(.failure(.response))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
    
}
