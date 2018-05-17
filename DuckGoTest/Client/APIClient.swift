//
//  APIClient.swift
//  DuckGoTest
//
//  Created by Raphael Araújo on 2018-05-15.
//  Copyright © 2018 Raphael Araújo. All rights reserved.
//


import UIKit
import Alamofire

enum ClientConstants: String {
    case queryURL = "http://api.duckduckgo.com/?q=%@&format=json&pretty=1"
    // In case of the apiKey above doesn't work, you can try with  lQ3CFIdAuqFcm4bvHRFNDoN5iC09nXdCmb9de2gL
}

struct CustomError {
    var localizedDescription: String?
}

class APIClient {
    func searchFor(string: String, onCompletion: @escaping (_ completed: Bool, _ results: DuckGoResult?, _ error: CustomError?) -> Void) {
        let urlString = String(format: ClientConstants.queryURL.rawValue, string)
        print(urlString)
        if let url = URL(string: urlString) {
            Alamofire.request(url)
                .validate(statusCode: [200,202])
                .responseData { response in
                    switch response.result {
                    case .success:
                        if let data = response.value {
                            print(data)
                            do {
                                let results = try JSONDecoder().decode(DuckGoResult.self, from: data)
                                onCompletion(true, results, nil)
                            } catch (let e) {
                                let e = self.handleError(error: e)
                                onCompletion(false, nil, e)
                            }
                            
//                                onCompletion(true, data as? [String: Any], nil)
                        }
                    case .failure(let error):
                        let e = self.handleError(error: error)
                        print(error)
                        onCompletion(false, nil, e)
                    }
            }
        }
    }
    
    private func handleError(error: Error) -> CustomError {
        return CustomError(localizedDescription: error.localizedDescription)
    }
}
