//
//  TableViewController.swift
//  reddit
//
//  Created by Eric Garcia on 5/17/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import UIKit
import SafariServices
import Common

class PostsViewController: UITableViewController {

    // MARK: -
    // MARK: Public Properties

    var viewModel: PostsViewModel?

    // MARK: -
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel?.fetchFrontPage()
        viewModel?.subscribe(from: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchFavorites()
    }

    // MARK: -
    // MARK: IBOutlets

    @IBOutlet var textField: UITextField?

    @IBOutlet var activityIndicatorView: UIActivityIndicatorView?

    @IBOutlet var emptyStateLabel: UILabel?

    // MARK: -
    // MARK: IBActions
    
    @objc func refreshPosts() {
        viewModel?.refreshPosts()
    }

}

// MARK: -
// MARK: UITableViewDataSource

extension PostsViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems(inSection: 0) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostItemCell.reuseIdentifier,
            for: indexPath)

        guard let postItemCell = cell as? PostItemCell else { return cell }
        postItemCell.viewModel = viewModel?.itemViewModel(at: indexPath)
        return postItemCell
    }

}

// MARK: -
// MARK: UITableViewDelegate

extension PostsViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        guard
            let vm = viewModel?.itemViewModel(at: indexPath),
            let url = URL(string: vm.state.url) else {
                return
        }

        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }

}

// MARK: -
// MARK: Views and Constraints

private extension PostsViewController {

    /// Perform any additional one-time view setup after the view has loaded.
    func setupView() {
        tableView.register(
            UINib(nibName: "PostItemCell", bundle: .main),
            forCellReuseIdentifier: PostItemCell.reuseIdentifier)

        definesPresentationContext = true

        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }

}

// MARK: -
// MARK: UITextFieldDelegate

extension PostsViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel?.fetchPosts(from: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }

}

// MARK: -
// MARK: StatefulView

extension PostsViewController: StatefulView {

    func render(state: PostsViewState) {
        if state.isLoading {
            activityIndicatorView?.startAnimating()
            tableView.refreshControl?.beginRefreshing()
        } else {
            activityIndicatorView?.stopAnimating()
            tableView.refreshControl?.endRefreshing()
        }
        tableView.reloadData()

        emptyStateLabel?.isHidden = state.cellViewModels.count != 0 || state.isLoading
    }

}

