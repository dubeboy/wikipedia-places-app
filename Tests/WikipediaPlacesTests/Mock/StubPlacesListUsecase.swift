//
//  StubPlacesListUsecase.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 30/01/2026.
//

import Foundation
@testable import Wikipedia_Places_App

final class StubPlacesListUsecase: PlacesListUsecaseProtocol {
    var getPlacesResult: Result<[LocationModel], Error> = .failure(WikipediaPlacesAppError.unknownError)
    func getPlaces() async throws -> [LocationModel] {
        try result(getPlacesResult)
    }
}
