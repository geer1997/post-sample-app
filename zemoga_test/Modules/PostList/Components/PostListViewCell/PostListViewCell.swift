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
    @IBOutlet weak var postIconStatus: UIImageView!
    
    var post: Post?
    
    func preparePostListCell(_ post: Post) {
        self.post = post
        postDescriptionLabel?.text = post.body
        postIconStatus.image = UIImage(systemName: "star.fill")
        postIconStatus.isHidden = !post.isFavorite
    }
}
