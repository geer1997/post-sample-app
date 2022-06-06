//
//  PostListViewControllerProtocol.swift
//  zemoga_test
//
//  Created by Germano Rojas on 5/6/22.
//

import Foundation

protocol PostListViewControllerProtocol {
    func finishLoadingPosts(_ posts: [Post], error: Error?)
    func finishRemovingPosts(error: Error?)
}
