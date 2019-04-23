//
//  Data+Extension.swift
//  PostViewer
//
//  Created by Jakub Kurgan on 23/04/2019.
//  Copyright © 2019 Jakub Kurgan. All rights reserved.
//

import Foundation

extension Data {
    func decoded<T:Decodable>(using decoder: AnyDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
}

protocol AnyDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: AnyDecoder {}
