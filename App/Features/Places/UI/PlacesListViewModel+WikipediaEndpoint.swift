//
//  PlacesListViewModel+WikipediaEndpoint.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

import Foundation

extension PlacesListViewModel {
    enum WikipediaEndpoint: EndpointProtocol {
        case openWikipediaAppPlaceDetailsDeeplink(place: LocationModel)

        var path: String {
            switch self {
            case .openWikipediaAppPlaceDetailsDeeplink(let place):
                "/wiki/\(place.name)"
            }
        }

        var urlParams: [URLQueryItem] {
            switch self {
            case .openWikipediaAppPlaceDetailsDeeplink(let place):
                [
                    URLQueryItem(name: "WMFPage", value: "Places"),
                    URLQueryItem(name: "lat", value: String(place.lat)),
                    URLQueryItem(name: "lon", value: String(place.long)),
                ]
            }
        }

        var requestType: HTTPMethod {
            .get
        }

        var baseURL: URL {
            switch self {
            case .openWikipediaAppPlaceDetailsDeeplink:
                guard let serverURL = URL(string: "https://en.wikipedia.org") else {
                    fatalError("Deep link URL is invalid")
                }
                return serverURL
            }
        }
    }
}
