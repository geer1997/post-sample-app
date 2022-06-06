//
//  PostDetailViewControllerProtocol.swift
//  zemoga_test
//
//  Created by Germano Rojas on 6/6/22.
//

import Foundation

protocol PostDetailViewControllerProtocol {
    func finishLoadingUser(_ user: User, error: Error?)
    func finishLoadingComments(_ comments: [Comment], error: Error?)
}
