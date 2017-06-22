//
//  Article+CoreDataProperties.swift
//  AC-iOS-CoreData
//
//  Created by Erica Y Stevens on 6/22/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var abstract: String?
    @NSManaged public var title: String?

}
