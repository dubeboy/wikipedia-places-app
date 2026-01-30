//
//  StubPlacesClient.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 30/01/2026.
//

import Foundation
@testable import Wikipedia_Places_App

final class StubPlacesClient: PlacesClientProtocol {
    var getPlacesServerResult: Result<PlacesResponse, Error> = .failure(WikipediaPlacesAppError.unknownError)
    func getPlaces() async throws -> PlacesResponse {
        try result(getPlacesServerResult)
    }
}
