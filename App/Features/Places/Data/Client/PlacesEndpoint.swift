//
//  PlacesEndpoint.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

enum PlacesEndpoint: EndpointProtocol {
    case getPlaces
    var path: String {
        switch self {
        case .getPlaces:
            "/abnamrocoesd/assignment-ios/main/locations.json"
        }
    }

    var requestType: HTTPMethod {
        switch self {
        case .getPlaces:
              .get
        }
    }
}
