//
//  PlacesListModel+Init.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

import MapKit

extension LocationModel {
    init(from response: LocationResponse) {
        id = "\(response.lat)-\(response.long)"
        lat = response.lat
        long = response.long
        name = response.name ?? ""
    }

    init(from mkItem: MKMapItem) {
        let coordinates = mkItem.location.coordinate
        id = "\(coordinates.latitude)-\(coordinates.longitude)"
        lat = coordinates.latitude
        long = coordinates.longitude
        name = mkItem.name ?? ""
    }
}
