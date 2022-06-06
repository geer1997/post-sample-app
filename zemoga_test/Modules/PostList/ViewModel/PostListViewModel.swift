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
            self.delegate?.finishRemovingPosts(error: error)
        })
    }
    
    func removePost(_ postId: Int) {
        PostService().removePost(postId, completion: { (response, error) in
            guard let postIdReponse = response else { return }
            self.delegate?.finishRemovingPost(postIdReponse, error: error)
        })
    }
}
