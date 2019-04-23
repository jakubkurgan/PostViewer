//
//  PostsViewModel.swift
//  PostViewer
//
//  Created by Jakub Kurgan on 23/04/2019.
//  Copyright © 2019 Jakub Kurgan. All rights reserved.
//

import UIKit

class PostsViewModel {
    
    // MARK: - Properties
    
    var postList: [Post] = []
    weak var delegate: PostsViewControllerDelegate?
    
    // MARK: - Service
    
    func getPostList() {
        let lastUpdate = PostTable.getLastUpdate()
        if let lastUpdate = lastUpdate, Date().timeIntervalSince(lastUpdate) > 300 {
            getRemotePostList()
        } else if lastUpdate == nil {
            getRemotePostList()
        } else {
            getLocalPostList()
        }
    }
    
    private func getRemotePostList() {
        PostService.getPosts { [weak self] response in
            
            DispatchQueue.main.async {
                
                switch response {
                case .failure(let error):
                    self?.getLocalPostList(error: error)
                case .success(let data):
                    self?.postList = data
                    self?.delegate?.reloadData()
                    
                    do {
                        try PostTable.savePosts(postList: data)
                    } catch {
                        self?.delegate?.showError(error: error)
                    }
                }
            }
            
        }
    }
    
    private func getLocalPostList(error: Error? = nil) {
        do {
            let result = try PostTable.getLocalPosts()
            if let error = error, result.isEmpty {
                self.delegate?.showError(error: error)
            } else {
                self.postList = result
                self.delegate?.reloadData()
            }
        } catch {
            self.delegate?.showError(error: error)
        }
    }
}
