//
//  StubPlacesListUsecase+Data.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 30/01/2026.
//

import Foundation
@testable import Wikipedia_Places_App

extension PlacesResponse {
    static let extepectedResponse = PlacesResponse(
        locations: [
            LocationResponse(
                name: "Amsterdam",
                lat: 52.3547498,
                long: 4.8339215
            ),
            LocationResponse(
                name: "Mumbai",
                lat: 19.0823998,
                long: 72.8111468
            ),
            LocationResponse(
                name: "Copenhagen",
                lat: 55.6713442,
                long: 12.523785
            ),
            LocationResponse(
                name: nil,
                lat: 40.4380638,
                long: -3.7495758
            )
        ]
    )
}

extension Array where Element == LocationModel {
    static let extepectedResponse: [LocationModel] = PlacesResponse
        .extepectedResponse
        .locations
        .map(LocationModel.init(from:))
}
