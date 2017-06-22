//
//  DataManager.swift
//  AC-iOS-CoreData
//
//  Created by Erica Y Stevens on 6/22/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    static let manager = DataManager()
    private override init() {}
    
    func saveArticleInfoToCoreData(title: String, abstract: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedContext)!
        
        let article = NSManagedObject(entity: entity, insertInto: managedContext)
        
        article.setValue(title, forKey: "title")
        article.setValue(abstract, forKey: "abstract")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error saving article to Core Data: \(error.userInfo)")
        }
    }
    
    func loadArticlesFromPersistentStore() -> [NSManagedObject]? {
        var objects: [NSManagedObject] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Article")
        
        do {
            objects = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
            print("Error fetching articles from persistent container: \(error.userInfo)")
        }
        return objects
    }
}
