//
//  RequestManager.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 28/01/2026.
//

import Foundation

protocol RequestManagerProtocol {
    func perform<T: Decodable>(request: EndpointProtocol) async throws -> T
}

nonisolated
final class RequestManager: RequestManagerProtocol {
    func perform<T: Decodable>(request: any EndpointProtocol) async throws -> T {
        let request = try request.createURLRequest()
        let decoder = JSONDecoder()
        let (data, urlResponse) = try await URLSession.shared.data(for: request)
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            throw WikipediaPlacesAppError.unknownError
        }
        guard (200...299).contains(urlResponse.statusCode) else {
            throw WikipediaPlacesAppError.serverError(statusCode: urlResponse.statusCode)
        }
        return try decoder.decode(T.self, from: data)
    }
}
