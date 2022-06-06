//
//  APIService.swift
//  zemoga_test
//
//  Created by Germano Rojas on 5/6/22.
//

import Foundation
import Alamofire

class APIService {
    
    static func request(url: String, method: HTTPMethod, completion: @escaping (Any?, Error?) -> Void) {
        let afURL = URL(string: url)
        AF.request(afURL!, method: .get).responseJSON(completionHandler: { response in
            completion(response.value, nil)
        })
            
    }
}
