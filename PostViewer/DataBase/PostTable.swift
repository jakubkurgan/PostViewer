//
//  PostTable.swift
//  PostViewer
//
//  Created by Jakub Kurgan on 23/04/2019.
//  Copyright © 2019 Jakub Kurgan. All rights reserved.
//

import UIKit
import CoreData

struct PostTable {
    
    static func savePosts(postList: [Post]) throws {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let postTable = NSEntityDescription.entity(forEntityName: "PostModel", in: managedContext)!
        let infoTable = NSEntityDescription.entity(forEntityName: "Info", in: managedContext)!
        let infoObject = NSManagedObject(entity: infoTable, insertInto: managedContext)
        
        if !postList.isEmpty {
            infoObject.setValue(Date(), forKey: "lastUpdate")
        }
        
        postList.forEach { (post) in
            let postObject =  NSManagedObject(entity: postTable, insertInto: managedContext)
            postObject.setValue(NSNumber(value: post.id), forKey: "id")
            postObject.setValue(NSNumber(value: post.userId), forKey: "userId")
            postObject.setValue(post.title, forKey: "title")
            postObject.setValue(post.body, forKey: "body")
        }
        
        try managedContext.save()
    }
    
    static func getLocalPosts() throws -> [Post] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let postFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PostModel")
        let postList = try managedContext.fetch(postFetch) as? [PostModel]
        
        let result = (postList ?? []).map { Post(userId: Int($0.userId),
                                                 id: Int($0.id),
                                                 title: $0.title ?? "",
                                                 body: $0.body ?? "") }
        
        return result
    }
    
    static func getLastUpdate() -> Date? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let InfoFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Info")
            
            let infoList = try? managedContext.fetch(InfoFetch) as? [Info]
            
            return infoList?.sorted { $0.lastUpdate! > $1.lastUpdate! }.first?.lastUpdate
        } else {
            return nil
        }
    }
}
