//
//  PostService.swift
//  zemoga_test
//
//  Created by Germano Rojas on 5/6/22.
//

import Foundation
import CoreData
import SwiftyJSON

class PostService {
    func getPosts(completion: @escaping ([Post], Error?) -> ()) {
        APIService.request(url: "https://jsonplaceholder.typicode.com/posts", method: .get, completion: {(response, error)  in
            guard
                let data = response as? [[String : Any]],
                error == nil
            else {
                completion([], error)
                return
            }
            
            var posts: [Post] = []
            
            data.forEach { post in
                guard
                    let postBuild = self.buildPostFromDictionary(post) as? Post
                else {
                    return
                }
                posts.append(postBuild)
            }
            
            completion(posts, nil)
        })
    }
    
    func deleteAllPosts(completion: @escaping (Bool, Error?) -> ()) {
        APIService.request(url: "https://jsonplaceholder.typicode.com/posts", method: .delete, completion: {(response, error)  in
            print("===> response data", response)
            guard
                error == nil
            else {
                completion(false, error)
                return
            }

            completion(true, nil)
        })
    }
    
    private func buildPostFromDictionary(_ dictionary: [String: Any]) -> Any? {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let json = JSON(dictionary)
        var post: Post?

        managedContext.performAndWait {

            guard let idInt = json["id"].int16 else {
                return
            }

            post = Post(context: managedContext)

            post?.id = idInt
            post?.body = json["body"].string
            post?.title = json["title"].string

            do {
                try managedContext.save()
            } catch {
                print("===> Error creating post")
            }
        }

        return post
    }
}
