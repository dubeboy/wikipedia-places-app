//
//  StubRequestManager.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 30/01/2026.
//

import Foundation
@testable import Wikipedia_Places_App

final class StubRequestManager: RequestManagerProtocol {
    var result: Data?

    func perform<T>(request: EndpointProtocol) async throws -> T where T : Decodable {
        guard let data = result else {
            throw WikipediaPlacesAppError.unknownError
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
