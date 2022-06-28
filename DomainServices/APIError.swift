//
//  APIError.swift
//  DomainServices
//
//  Created by Tran Tuyen on 27/06/2022.
//

import Foundation

public enum APIError: Error {
    case notFound
    case convertJSON
    case other(NSError)
    
    public var errorMessage: String {
        switch self {
        case .notFound:
            return "Not Found"
        case .convertJSON:
            return "Parse Object Error"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
