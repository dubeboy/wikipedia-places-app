//
//  PlacesListViewModel+WikipediaEndpoint.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

import MapKit

extension PlacesListViewModel {
    enum WikipediaEndpoint: EndpointProtocol {
        case openWikipediaAppPlaceDetailsDeeplink(place: String, coordinates: CLLocationCoordinate2D)

        var path: String {
            switch self {
            case .openWikipediaAppPlaceDetailsDeeplink(let name, _):
                name
            }
        }

        var urlParams: [URLQueryItem] {
            switch self {
            case .openWikipediaAppPlaceDetailsDeeplink(_, let coordinates):
                [
                    URLQueryItem(name: "WMFPage", value: "Places"),
                    URLQueryItem(name: "lat", value: String(coordinates.latitude)),
                    URLQueryItem(name: "lon", value: String(coordinates.longitude)),
                ]
            }
        }

        var requestType: HTTPMethod {
            .get
        }

        var baseURL: URL {
            switch self {
            case .openWikipediaAppPlaceDetailsDeeplink:
                guard let serverURL = URL(string: "https://en.wikipedia.org/wiki/") else {
                    fatalError("Deep link URL is invalid")
                }
                return serverURL
            }
        }
    }
}
