import Foundation

public protocol Request {
    typealias URLInfo = NetworkAPI.URLInfo
    typealias RequestInfo = NetworkAPI.RequestInfo
    
    associatedtype Parameter: Encodable
    associatedtype Response: Decodable

    var urlInfo: URLInfo { get }
    var requestInfo: RequestInfo<Parameter> { get }
}
