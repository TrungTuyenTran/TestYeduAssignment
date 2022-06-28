//
//  Constants.swift
//  Repository
//
//  Created by Tran Tuyen on 27/06/2022.
//

import Foundation

struct Constants {
    static let baseUrl = "https://dummyapi.io/data/v1/"
    static let baseHeader = ["app-id": "62b291fd2191a308ab5a5f9c"]
}

enum API {
    case users
    
    var url: String {
        switch self {
        case .users:
            return Constants.baseUrl + "user"
        }
    }
}
