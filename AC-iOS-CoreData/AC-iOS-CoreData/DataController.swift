//
//  DataController.swift
//  AC-iOS-CoreData
//
//  Created by Erica Y Stevens on 6/22/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import UIKit
import CoreData

//https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreData/InitializingtheCoreDataStack.html#//apple_ref/doc/uid/TP40001075-CH4-SW1
class DataController: NSObject {

    var managedObjectContext: NSManagedObjectContext
    var persistentContainer: NSPersistentContainer
    
    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "AC_iOS_CoreData")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }
}
