//
//  WikipediaPlacesAppError.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 28/01/2026.
//

import Foundation

enum WikipediaPlacesAppError: LocalizedError {
    case unknownError
    case serverError(statusCode: Int)

    var errorDescription: String? {
        let config = Common.Configuration().strings
        return switch self {
        case .unknownError:
            config.unexpectedError
        case .serverError(statusCode: let statusCode):
            config.serverError(statusCode)
        }
    }
}
