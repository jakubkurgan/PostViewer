//
//  PostsViewController.swift
//  PostViewer
//
//  Created by Jakub Kurgan on 23/04/2019.
//  Copyright © 2019 Jakub Kurgan. All rights reserved.
//

import UIKit

protocol PostsViewControllerDelegate: class {
    func reloadData()
    func showError(error: Error)
}

class PostsViewController: UITableViewController {
    
    private let viewModel: PostsViewModel = PostsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.delegate = self
        viewModel.getPostList()
    }
    
    func setupView() {
        title = "navigationTitle".localized
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 70.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.backgroundView = EmptyDataView(frame: tableView.frame)
        tableView.allowsSelection = false
    }
    
    @objc func refreshData() {
        viewModel.getPostList()
    }
}

extension PostsViewController: PostsViewControllerDelegate {
    func reloadData() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func showError(error: Error) {
        showAlert(message: error.localizedDescription)
        refreshControl?.endRefreshing()
    }
}

extension PostsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as? PostCell {
            let post = viewModel.postList[indexPath.row]
            cell.setup(title: post.title)
            
            return cell
        }
        
        return UITableViewCell()
    }
}


extension PostsViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "alertTitle".localized, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "alertOk".localized, style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
