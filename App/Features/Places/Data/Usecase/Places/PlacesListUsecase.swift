//
//  PlacesListUsecase.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

protocol PlacesListUsecaseProtocol {
    func getPlaces() async throws -> [LocationModel]
}

final class PlacesListUsecase: PlacesListUsecaseProtocol {
    private let client: PlacesClientProtocol

    init(client: PlacesClientProtocol = PlacesClient()) {
        self.client = client
    }

    func getPlaces() async throws -> [LocationModel] {
        let response = try await client.getPlaces()
        return response.locations.map(LocationModel.init(from:))
    }
}

