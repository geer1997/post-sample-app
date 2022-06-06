//
//  UserService.swift
//  zemoga_test
//
//  Created by Germano Rojas on 6/6/22.
//

import Foundation
import CoreData
import SwiftyJSON

class UserService {
    func getUser(_ userId: Int, completion: @escaping (User?, Error?) -> ()) {
        APIService.request(url: "https://jsonplaceholder.typicode.com/users/\(userId)", method: .get, completion: {(response, error)  in
            guard
                let data = response as? [String : Any],
                error == nil
            else {
                completion(nil, error)
                return
            }
            
            guard
                let user: User = self.buildUserFromDictionary(data)
            else {return}
            
            completion(user, nil)
        })
    }
    
    private func buildUserFromDictionary(_ dictionary: [String: Any]) -> User? {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let json = JSON(dictionary)
        var user: User?

        managedContext.performAndWait {

            guard
                let idInt = json["id"].int16
            else {
                return
            }

            user = User(context: managedContext)

            user?.id = idInt
            user?.name = json["name"].string
            user?.username = json["username"].string
            user?.email = json["email"].string
            user?.phone = json["phone"].string
            user?.website = json["website"].string
            

            do {
                try managedContext.save()
            } catch {
                print("===> Error creating user")
            }
        }

        return user
    }
}
