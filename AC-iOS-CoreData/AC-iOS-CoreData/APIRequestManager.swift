//
//  APIRequestManager.swift
//  AC-iOS-CoreData
//
//  Created by Erica Y Stevens on 6/22/17.
//  Copyright © 2017 Erica Y Stevens. All rights reserved.
//

import Foundation

class APIRequestManager {
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(endpoint: String, callback: @escaping (Data?) -> Void){
        guard let myURL = URL(string: endpoint) else { return }
        getData(endpoint: myURL, callback: callback)
    }
    
    func getData(endpoint: URL, callback: @escaping (Data?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: endpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error during DataTask Session: \(error!)")
            }
            
            guard let validData = data else { return }
            callback(validData)
        }.resume()
    }
}
