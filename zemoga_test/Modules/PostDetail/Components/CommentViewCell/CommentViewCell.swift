//
//  CommentViewCell.swift
//  zemoga_test
//
//  Created by Germano Rojas on 6/6/22.
//

import Foundation
import UIKit

class CommentViewCell: UITableViewCell {
    static let identifier: String = "comment_cell"
    
    @IBOutlet weak var commentDescriptionLabel: UILabel!
    
    func prepareCommentCell(_ commentDescription: String) {
        commentDescriptionLabel?.text = commentDescription
    }
}
