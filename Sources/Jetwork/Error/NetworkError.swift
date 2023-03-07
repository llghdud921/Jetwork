import Foundation

/// 'NetworkError' 은 Network에서 발생하는 에러들을 정의.
public enum NetworkError: Error {
    case nonHTTPURLResponse(URLResponse?)
    case unacceptableStatusCode(Int)
    case unexpectedObject(Any)
}
