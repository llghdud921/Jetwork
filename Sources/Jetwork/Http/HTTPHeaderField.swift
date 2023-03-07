import Foundation

/// 'HTTPHeaderField'는 Http header의 Field를 객체로 정의.
public enum HTTPHeaderField {
    case contentType
    case accept
    case authorization
    case custom(String)
    
    var description: String {
        switch self {
        case .contentType:
            return "Content-Type"
        case .accept:
            return "Accept"
        case .authorization:
            return "Authorization"
        case .custom(let headerString):
            return headerString
        }
    }
}
