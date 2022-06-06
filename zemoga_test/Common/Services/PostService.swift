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
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
                    let postBuild = self.buildPostFromDictionary(post)
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

            guard
                error == nil
            else {
                completion(false, error)
                return
            }

            completion(true, nil)
        })
    }
    
    func removePost(_ postId: Int, completion: @escaping (Int?, Error?) -> ()) {
        APIService.request(url: "https://jsonplaceholder.typicode.com/posts/\(postId)", method: .delete, completion: {(response, error)  in

            guard
                error == nil
            else {
                completion(nil, error)
                return
            }
            
            completion(postId, nil)
        })
    }
    
    private func buildPostFromDictionary(_ dictionary: [String: Any]) -> Post? {

        let json = JSON(dictionary)
        var post: Post?

        managedContext.performAndWait {

            guard
                let idInt = json["id"].int16,
                let userId = json["userId"].int16
            else {
                return
            }

            post = Post(context: managedContext)

            post?.id = idInt
            post?.body = json["body"].string
            post?.title = json["title"].string
            post?.userId = userId

            do {
                try managedContext.save()
            } catch {
                print("===> Error creating post")
            }
        }

        return post
    }
    
    func getPostComments(_ postId: Int, completion: @escaping ([Comment], Error?) -> ()) {
        APIService.request(url: "https://jsonplaceholder.typicode.com/posts/\(postId)/comments", method: .get, completion: {(response, error)  in
            guard
                let data = response as? [[String : Any]],
                error == nil
            else {
                completion([], error)
                return
            }
            
            var comments: [Comment] = []
            
            data.forEach { comment in
                guard
                    let commentBuild = self.buildCommentFromDictionary(comment)
                else {
                    return
                }
                comments.append(commentBuild)
            }
            
            completion(comments, nil)
        })
    }
    
    private func buildCommentFromDictionary(_ dictionary: [String: Any]) -> Comment? {
        let json = JSON(dictionary)
        var comment: Comment?

        managedContext.performAndWait {

            guard
                let idInt = json["id"].int16,
                let postId = json["postId"].int16
            else {
                return
            }

            comment = Comment(context: managedContext)

            comment?.id = idInt
            comment?.postId = postId
            comment?.name = json["name"].string
            comment?.email = json["email"].string
            comment?.body = json["body"].string

            do {
                try managedContext.save()
            } catch {
                print("===> Error creating post")
            }
        }

        return comment
    }
}
