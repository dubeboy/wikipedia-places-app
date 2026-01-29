//
//  Common+Configuration.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 28/01/2026.
//

import Foundation

enum Common {}

extension Common {
    struct Configuration {
        var strings = AppStrings()
    }
}

extension Common {
    struct AppStrings {
        var unexpectedError = String(localized: .commonUnexpectedError)
        var serverError: (_ statusCode: Int) -> String = { statusCode in
            return String(localized: .commonSeverError)
        }
    }
}
