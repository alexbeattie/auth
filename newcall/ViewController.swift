//
//  ViewController.swift
//  newcall
//
//  Created by Alex Beattie on 5/10/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    struct responseData: Decodable {
        var D: ResultsData
    }
    struct ResultsData: Decodable {
        var Results: [resultsArr]
    }
    struct resultsArr: Decodable {
        var AuthToken: String
        var Expires: String
    }
    
  
    
    func dataRequest(completionHandler: @escaping (responseData) -> ()) {
//        let urlToRequest = "https://sparkapi.com/v1/session?ApiKey=vc_c15909466_key_1&ApiSig=a2b8a9251df6e00bf32dd16402beda91"

        let baseUrl = URL(string: "https://sparkapi.com/v1/session?ApiKey=vc_c15909466_key_1&ApiSig=a2b8a9251df6e00bf32dd16402beda91")!
        let request = NSMutableURLRequest(url: baseUrl)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
           
            guard let data = data else { return }
            print(data)
            if let error = error {
                print(error)
            }
//            var names: [Int] = []
            do {
                let decoder = JSONDecoder()
                let listing = try decoder.decode(responseData.self, from: data)
//                listing.D.Results
                
                print(listing.D.Results)
//                names.first
//                print(names.first)
                guard let authToken = listing.D.Results[0].AuthToken as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The AuthToken is: " + authToken)
            } catch let err {
                print(err)
            }
        }
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataRequest { (listing) -> () in
            

            
        }
        
        
//        var appData: [resultsArr]?
//        print(appData)

        
            
        
        
        
        
           
    }

}

