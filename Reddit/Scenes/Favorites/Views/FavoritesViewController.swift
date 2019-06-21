//
//  FavoritesViewController.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import UIKit
import SafariServices
import Common

class FavoritesViewController: UITableViewController {

    // MARK: -
    // MARK: Public Properties

    var viewModel: FavoritesViewModel?

    // MARK: -
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel?.subscribe(from: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchFavorites()
    }

}

// MARK: -
// MARK: UITableViewDataSource

extension FavoritesViewController {

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

extension FavoritesViewController {

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

private extension FavoritesViewController {

    /// Perform any additional one-time view setup after the view has loaded.
    func setupView() {
        tableView.register(
            UINib(nibName: "PostItemCell", bundle: .main),
            forCellReuseIdentifier: PostItemCell.reuseIdentifier)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }

}

// MARK: -
// MARK: FavoritesViewModelDelegate

extension FavoritesViewController: StatefulView {

    func render(state: FavoritesViewState) {
        tableView.reloadData()
    }

}
