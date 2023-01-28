//
//  GifListEndpoint.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import Foundation

enum GifListEndpoint {
    case trending
    case categories
    case search(String)
}

extension GifListEndpoint: Endpoints {
    
    var path: String {
        switch self {
        case .trending:
            return "/v1/gifs/trending"
        case .categories:
            return "/v1/gifs/categories"
        case .search:
            return "/v1/gifs/search"
        }
    }
    
    var method: RequestMethodType {
        return .get
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let queryParameter):
            return [
                URLQueryItem(name: "q", value: queryParameter)
            ]
        default: return []
        }
    }
    
    var header: [String]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
    
}
