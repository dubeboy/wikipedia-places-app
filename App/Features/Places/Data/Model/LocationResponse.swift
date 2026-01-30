//
//  LocationResponse.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

nonisolated struct LocationResponse: Decodable {
    let name: String?
    let lat: Double
    let long: Double
}
