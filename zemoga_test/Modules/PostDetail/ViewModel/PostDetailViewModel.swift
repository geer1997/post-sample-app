//
//  PostDetailViewModel.swift
//  zemoga_test
//
//  Created by Germano Rojas on 6/6/22.
//

import Foundation

class PostDetailViewModel: PostDetailViewModelProtocol {

    var delegate: PostDetailViewControllerProtocol?
    
    func loadUser(_ userId: Int) {
        UserService().getUser(userId, completion: { user, error  in
            guard let user = user else { return }
            self.delegate?.finishLoadingUser(user, error: error)
        })
    }
    
    func loadComments(_ postId: Int) {
        PostService().getPostComments(postId, completion: { (comments, error) in
            self.delegate?.finishLoadingComments(comments, error: error)
        })
    }
}
