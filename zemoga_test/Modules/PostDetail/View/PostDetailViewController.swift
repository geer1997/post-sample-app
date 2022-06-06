//
//  PostDetailViewController.swift
//  zemoga_test
//
//  Created by Germano Rojas on 6/6/22.
//

import Foundation
import UIKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionUILabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userMail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userWebsite: UILabel!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    var post: Post?
    var viewModel: PostDetailViewModelProtocol = PostDetailViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        guard let post = post else { return }
        self.descriptionUILabel?.text = post.body
    }
    
    override func viewDidLoad() {
        viewModel.delegate = self
        setupCommentsTable()
    }
    
    func preparePostDetail(post: Post) {
        self.post = post
        viewModel.loadUser(Int(post.userId))
        viewModel.loadComments(Int(post.userId))
    }
    
    private func setUserProperties() {
        guard let userProps = post?.user else { return }
        userName.text = userProps.name
        userMail.text = userProps.email
        userPhone.text = userProps.phone
        userWebsite.text = userProps.website
    }
    
    private func setupCommentsTable() {
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.registerCells()
    }
    
}

extension PostDetailViewController: PostDetailViewControllerProtocol {
    
    func finishLoadingUser(_ user: User, error: Error?) {
        self.post?.user = user
        self.setUserProperties()

    }
    
    func finishLoadingComments(_ comments: [Comment], error: Error?) {
        comments.forEach { comment in
            self.post?.addToComments(comment)
        }
        commentsTableView.reloadData()
    }
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return post?.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "COMMENTS"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.commentCell(for: indexPath),
            let comments = post?.comments,
            let comment = comments[indexPath.row] as? Comment,
            let commentDescription = comment.body
        else {
            fatalError("no cell for this index path")
        }
        
        cell.prepareCommentCell(commentDescription)

        cell.layoutIfNeeded()

        return cell
    }
}

private extension UITableView {
    func commentCell(for indexPath: IndexPath) -> CommentViewCell? {
        return dequeueReusableCell(withIdentifier: CommentViewCell.identifier, for: indexPath) as? CommentViewCell
    }
    
    func registerCells() {
        register(UINib(nibName: String(describing: CommentViewCell.self), bundle: Bundle(for: CommentViewCell.self)), forCellReuseIdentifier: CommentViewCell.identifier)
    }
}
