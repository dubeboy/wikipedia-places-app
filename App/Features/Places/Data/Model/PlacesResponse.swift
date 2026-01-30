//
//  PlaceResponse.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

nonisolated struct PlacesResponse: Decodable {
    let locations: [LocationResponse]
}
