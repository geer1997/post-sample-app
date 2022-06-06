//
//  PostListViewModelProtocol.swift
//  zemoga_test
//
//  Created by Germano Rojas on 5/6/22.
//

import Foundation

protocol PostListViewModelProtocol {
    var delegate: PostListViewControllerProtocol? { get set }
    
    func loadPosts()
    func removeAllPosts()
}
