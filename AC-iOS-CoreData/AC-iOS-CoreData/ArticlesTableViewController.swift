//
//  ArticlesTableViewController.swift
//  AC-iOS-CoreData
//
//  Created by Erica Y Stevens on 6/22/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import UIKit
import CoreData

fileprivate let apiURLRoot = "https://api.nytimes.com/svc/topstories/v2/"
fileprivate let apiKeyQueryKey = "api-key"
fileprivate let apiKeyQueryValue = "f41c1b23419a4f55b613d0a243ed3243"

class ArticlesTableViewController: UITableViewController {
    
    var articles: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles()
        giveTVCellsDynamicHeights()
    }
    
    func giveTVCellsDynamicHeights() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
    }
    
    func getArticles() {
        APIRequestManager.manager.getData(endpoint: getTopStoriesURL()!) { (data: Data?) in
            if let validData = data {
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: validData, options: []) as? [String:AnyObject],
                        let results = jsonData["results"] as? [[String:AnyObject]]{
                        for result in results {
                            Article.populate(from: result)
                        }
                        if let loadedArticles = DataManager.manager.loadArticlesFromPersistentStore() {
                            self.articles = loadedArticles
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                } catch let error as NSError {
                    print("Error getting JSON: \(error)")
                }
            }
        }
    }
    
    func getTopStoriesURL() -> URL? {
        let topStoriesURL = "\(apiURLRoot)opinion.json"
        guard var urlComponents = URLComponents(string: topStoriesURL) else { return nil}
        
        let apiKeyQuery = URLQueryItem(name: apiKeyQueryKey, value: apiKeyQueryValue)
        urlComponents.queryItems = [apiKeyQuery]
        
        guard let url = urlComponents.url else { return nil }
        return url
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        
        let article = articles[indexPath.row]
        
        cell.articleTitleLabel.text = article.value(forKeyPath: "title") as? String
        cell.abstractSummaryLabel.text = article.value(forKeyPath: "abstract") as? String
        
        return cell
    }
}
