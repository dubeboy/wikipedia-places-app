//
//  MockThrowableResult.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 30/01/2026.
//

import Foundation

func result<T>(_ result: Result<T, Error>) throws -> T {
    switch result {
    case .success(let data): data
    case .failure(let error): throw error
    }
}
