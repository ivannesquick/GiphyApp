//
//  Endpoints.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import Foundation
import Foundation

protocol Endpoints {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethodType { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoints {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.giphy.com"
    }
    
    var apiKey: String {
        return "ocQIS90X1s7I5NAQ6mYcDoDODFMeIYte"
    }
    
    func request(offset: Int) -> URLRequest {
        
        
        var components = URLComponents()
        var baseQueryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(20)")
        ]
        
        baseQueryItems.append(contentsOf: queryItems)
        
        components.scheme = scheme
        components.host = host
        components.path = path
        
        components.queryItems = baseQueryItems
        
        guard let url = components.url else {
            fatalError(URLError(.unsupportedURL).localizedDescription)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequest
        
    }
}
