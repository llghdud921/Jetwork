//
//  URLSessionProtocol.swift
//  OdockOdock
//
//  Created by 이호영 on 2023/03/07.
//

import Foundation

public protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
