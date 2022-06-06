//
//  PostListViewController.swift
//  zemoga_test
//
//  Created by Germano Rojas on 5/6/22.
//

import Foundation
import UIKit

class PostListViewController: UIViewController, PostListViewControllerProtocol {
    
    @IBOutlet weak var postListTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    private var viewModel: PostListViewModelProtocol = PostListViewModel()
    
    var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupTableView()
        loadPosts()
        self.title = "Posts"
        self.navigationController?.navigationBar.backgroundColor = .green
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let posts = posts else { return }
        self.posts = sortFavoritesPosts(posts)
        postListTableView.reloadData()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupTableView() {
        postListTableView.delegate = self
        postListTableView.dataSource = self
        postListTableView.registerCells()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.loadPosts), for: .valueChanged)
        postListTableView.addSubview(refreshControl)
    }
    
    @objc func loadPosts() {
        viewModel.loadPosts()
    }
    
    private func sortFavoritesPosts(_ posts: [Post]) -> [Post] {
        return posts.sorted { $0.isFavorite && !$1.isFavorite }
    }
    
    @IBAction func deleteAllPosts(_ sender: Any) {
        viewModel.removeAllPosts()
    }

}

extension PostListViewController {
    func finishLoadingPosts(_ posts: [Post], error: Error?) {
        self.posts = posts
        postListTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func finishRemovingPosts(error: Error?) {
        self.posts = []
        postListTableView.reloadData()
    }
    
    func finishRemovingPost(_ postId: Int, error: Error?) {
        guard let postIndex = posts?.firstIndex(where: { $0.id == postId}) else { return }
        posts?.remove(at: postIndex)
        postListTableView.reloadData()
    }
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.postCell(for: indexPath),
            let post = posts?[indexPath.row] as? Post
        else {
            fatalError("no cell for this index path")
        }
        
        cell.preparePostListCell(post)

        cell.layoutIfNeeded()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let post = posts?[indexPath.row]
        else { return }
        let postDetailController = PostDetailViewController()
        
        postDetailController.preparePostDetail(post: post)
        
        self.navigationController?.pushViewController(postDetailController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let post = posts?[indexPath.row] else { return }
        if (editingStyle == .delete) {
            viewModel.removePost(Int(post.id))
        }
    }
}

private extension UITableView {
    func postCell(for indexPath: IndexPath) -> PostListViewCell? {
        return dequeueReusableCell(withIdentifier: PostListViewCell.identifier, for: indexPath) as? PostListViewCell
    }
    
    func registerCells() {
        register(UINib(nibName: String(describing: PostListViewCell.self), bundle: Bundle(for: PostListViewCell.self)), forCellReuseIdentifier: PostListViewCell.identifier)
    }
}
