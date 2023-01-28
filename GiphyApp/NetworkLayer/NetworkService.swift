//
//  NetworkService.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import Foundation

final class NetworkService {
    static var shared: NetworkService {
        NetworkService()
    }
    
    func sendRequest<T: Decodable>(request: URLRequest,
                                   responseModel: T.Type,
                                   completion: @escaping ((Result<T, RequestError>) -> Void)) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            switch response.statusCode {
            case 200...299:
                guard let data = data else { return }
                guard let decodedResponse = try? JSONDecoder().decode(
                    responseModel,
                    from: data
                ) else {
                    completion(.failure(.decode))
                    return
                }
                completion(.success(decodedResponse))
            case 401:
                completion(.failure(.unauthorized))
            default:
                completion(.failure(.unexpectedStatusCode))
            }
        }.resume()
    }
}
