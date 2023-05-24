//
//  Errors.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation

enum Errors: Error, LocalizedError {
    case invalidURL
    case invalidRequest
    case serverError
    case redirect
    case clientError(error: DataError)
    
    var errorDescription: String? {
        switch self {
        case let .clientError(error):
            return error.error
        default:
            return self.localizedDescription
        }
    }
}

struct DataError: Decodable {
    let error: String
}

