import Foundation

/// 'HTTPMethod'는 Http Method를 Enum을 활용하여 정의.
public enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
    
    var value: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}
