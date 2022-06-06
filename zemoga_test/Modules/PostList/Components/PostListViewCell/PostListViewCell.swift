//
//  PostListViewCell.swift
//  zemoga_test
//
//  Created by Germano Rojas on 5/6/22.
//

import Foundation
import UIKit

class PostListViewCell: UITableViewCell {
    static let identifier: String = "post_cell"
    
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    func preparePostListCell(_ postDescription: String) {
        postDescriptionLabel?.text = postDescription
    }
}
