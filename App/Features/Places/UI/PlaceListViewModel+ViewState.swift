//
//  PlaceListViewModel+ViewState.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

extension PlacesListViewModel {
    enum ViewState: Equatable {
        case loaded
        case loading
        case searching
        case error(error: WikipediaPlacesAppError)
    }
}
