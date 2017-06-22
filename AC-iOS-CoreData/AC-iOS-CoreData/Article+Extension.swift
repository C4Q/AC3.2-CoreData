//
//  Article+Extension.swift
//  AC-iOS-CoreData
//
//  Created by Erica Y Stevens on 6/22/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import Foundation
import CoreData

extension Article {
    static func populate(from dict: [String:Any]) {
        if let title = dict["title"] as? String,
            let abstract = dict["abstract"] as? String {
            DataManager.manager.saveArticleInfoToCoreData(title: title, abstract: abstract)
        }
    }
}
