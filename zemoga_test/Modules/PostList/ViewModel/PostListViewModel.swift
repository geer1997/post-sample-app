//
//  PostListViewModel.swift
//  zemoga_test
//
//  Created by Germano Rojas on 5/6/22.
//

import Foundation

class PostListViewModel: PostListViewModelProtocol {
    
    var delegate: PostListViewControllerProtocol?
    
    func loadPosts() {
        PostService().getPosts(completion: { (posts, error) in
            self.delegate?.finishLoadingPosts(posts, error: error)
        })
    }
    
    func removeAllPosts() {
        PostService().deleteAllPosts(completion: { (response, error) in
            print("===> deleted", response)
            self.delegate?.finishRemovingPosts(error: error)
        })
    }
}
