//
//  CategoryList.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import Foundation

struct CategoryList: Decodable {
    let data: [Category]
    let pagination: Pagination
}

struct Category: Decodable {
    let name: String
}

struct Pagination: Decodable {
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
    }
}
