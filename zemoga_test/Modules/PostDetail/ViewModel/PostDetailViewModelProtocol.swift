//
//  PostDetailViewModelProtocol.swift
//  zemoga_test
//
//  Created by Germano Rojas on 6/6/22.
//

import Foundation

protocol PostDetailViewModelProtocol {
    var delegate: PostDetailViewControllerProtocol? { get set }
    
    func loadUser(_ userId: Int)
    func loadComments(_ postId: Int)
}
