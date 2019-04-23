//
//  PostService.swift
//  PostViewer
//
//  Created by Jakub Kurgan on 23/04/2019.
//  Copyright © 2019 Jakub Kurgan. All rights reserved.
//

import Foundation

struct PostService {
    static func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        HttpClient().request(method: "get", path: "posts") { result in
            switch result {
            case .success(let data):
                do {
                    completion(.success(try JSONHelper.decodeToArray(from: data)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
