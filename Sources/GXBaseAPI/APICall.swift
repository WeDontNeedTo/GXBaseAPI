//
//  File.swift
//
//
//  Created by Danil on 08.12.2021.
//

import Foundation

public protocol APICall {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}

public extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw GXBaseAPIErros.notValidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = nil
        return request
    }

    func urlRequest<BodyData: Codable>(baseURL: String, bodyData: BodyData) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw GXBaseAPIErros.notValidURL
        }

        let body = try JSONEncoder().encode(bodyData)

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}
