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
        var retryButtonTitle: String = String(localized: .placesButtonRetryTitle)
        var searchBarPrompt: String = String(localized: .placesSearchBarPrompt)
        var alertTitle: String = String(localized: .placesAlertTitle)
        var alertButtonTitle: String = String(localized: .placesAlertButtonTitleOk)
    }
    struct Constants {
        var debounceMs = 500
    }
}
