//
//  PagingResponse.swift
//  Repository
//
//  Created by Tran Tuyen on 27/06/2022.
//

import Foundation

public struct PagingResponse<T: Codable> : Codable {
    public let total: Int
    public let page: Int
    public let limit: Int
    public let data: [T]
}
