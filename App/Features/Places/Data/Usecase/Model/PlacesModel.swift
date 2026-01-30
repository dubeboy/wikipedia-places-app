//
//  PlacesModel.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

nonisolated struct LocationModel: Equatable, Identifiable {
    let id: String
    let name: String
    let lat: Double
    let long: Double
}
