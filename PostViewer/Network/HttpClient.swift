//
//  HttpClient.swift
//  PostViewer
//
//  Created by Jakub Kurgan on 23/04/2019.
//  Copyright © 2019 Jakub Kurgan. All rights reserved.
//

import Foundation

enum HttpClientError: Error {
    case invalidURL
    case noData
}
extension HttpClientError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "invalidUrlErrorMessage".localized
        case .noData:
            return "noDataErrorMesssage".localized
        }
    }
}

struct HttpClient {
    
    private let session = URLSession.shared
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com")
    
    func request(method: String, path: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = baseURL?.appendingPathComponent(path) else {
            completion(.failure(HttpClientError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(HttpClientError.noData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
