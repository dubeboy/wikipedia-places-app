//
//  EndpointProtocol.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 28/01/2026.
//

import Foundation

protocol EndpointProtocol {
    var path: String { get }
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var httpBody: Encodable? { get }
    var urlParams: [URLQueryItem] { get }
    var requestType: HTTPMethod { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

extension EndpointProtocol {
    var baseURL: URL {
        guard let serverURL = URL(string: "https://raw.githubusercontent.com/") else {
            fatalError("URL is invalid")
        }
        return serverURL
    }

    var headers: [String: String] {
        [:]
    }

    var httpBody: Encodable? {
        nil
    }

    var urlParams: [URLQueryItem] {
        []
    }

    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host()
        components.path = path

        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = requestType.rawValue

        if !urlParams.isEmpty {
            components.queryItems = urlParams
        }

        if let httpBody {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(httpBody)
        }

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        let contentTypeHeader = "Content-Type"
        if urlRequest.value(forHTTPHeaderField: contentTypeHeader) == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: contentTypeHeader)
        }

        return urlRequest
    }
}

