//
//  PlacesClient.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

protocol PlacesClientProtocol {
    func getPlaces() async throws -> PlacesResponse
}

final class PlacesClient: PlacesClientProtocol {
    private let manager: RequestManagerProtocol

    init(manager: RequestManagerProtocol = RequestManager()) {
        self.manager = manager
    }

    func getPlaces() async throws -> PlacesResponse {
        try await manager.perform(
            request: PlacesEndpoint.getPlaces
        )
    }
}
