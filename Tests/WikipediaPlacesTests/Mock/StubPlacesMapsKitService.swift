//
//  StubPlacesMapsKitService.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 30/01/2026.
//

import Foundation
@testable import Wikipedia_Places_App

final class StubPlacesMapsKitService: PlacesMapKitServiceProtocol {
    var timesOpenWikipedia: Int = 0
    var query: String? = nil
    var deeplinkUrl: (any EndpointProtocol)? = nil
    var getPlacesResult: Result<[LocationModel], Error> = .failure(WikipediaPlacesAppError.unknownError)

    func openWikipediaApp(deeplinkUrl: any EndpointProtocol) {
        timesOpenWikipedia += 1
        self.deeplinkUrl = deeplinkUrl
    }
    
    func fetchUserCustomLocations(query: String) async throws -> [LocationModel] {
        self.query = query
        return try result(getPlacesResult)
    }
}
