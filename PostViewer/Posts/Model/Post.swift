//
//  Post.swift
//  PostViewer
//
//  Created by Jakub Kurgan on 23/04/2019.
//  Copyright © 2019 Jakub Kurgan. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
