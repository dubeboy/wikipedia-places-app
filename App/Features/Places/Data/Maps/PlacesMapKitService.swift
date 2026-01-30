//
//  PlacesMapKitService.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 30/01/2026.
//

import MapKit
import Foundation

protocol PlacesMapKitServiceProtocol {
    func openWikipediaApp(deeplinkUrl: EndpointProtocol)
    func fetchUserCustomLocations(query: String) async throws -> [LocationModel]
}

final class PlacesMapKitService: PlacesMapKitServiceProtocol {
    func openWikipediaApp(deeplinkUrl: EndpointProtocol) {
        guard let deeplink = try? deeplinkUrl.createURLRequest().url else {
            return
        }

        UIApplication.shared.open(deeplink, options: [:], completionHandler: nil)
    }
    
    func fetchUserCustomLocations(query: String) async throws -> [LocationModel] {
        let request = MKLocalSearch.Request(naturalLanguageQuery: query)
        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        return response.mapItems.map(LocationModel.init(from:))
    }
}
