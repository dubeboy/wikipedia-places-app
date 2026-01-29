//
//  PlacesListViewModel+Configuration.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

import Foundation

extension PlacesListViewModel {
    struct Configuration {
        var strings = Strings()
        var constants = Constants()
    }
    struct Strings {
        var title = String(localized: .placesTitle)
    }
    struct Constants {
        var debounceMs = 500
    }
}
