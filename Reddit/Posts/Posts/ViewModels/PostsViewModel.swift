//
//  PostsViewModel.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import Foundation

final class PostsViewModel {

    // MARK: -
    // MARK: Private Properties

    private let store: PostsStore

    private var viewState: PostsViewState

    // MARK: -
    // MARK: Public Properties

    weak var delegate: PostsViewModelDelegate? = nil

    // MARK: -
    // MARK: Initialization

    init(store: PostsStore) {
        self.store = store
        self.viewState = PostsViewState(
            cellViewModels: [],
            isLoading: false)
    }

}

// MARK: -
// MARK: PostsViewModelProtocol

extension PostsViewModel: PostsViewModelProtocol {

    func fetchFrontPage() {
        store.fetchPosts(from: nil)
    }

    func fetchPosts(from subreddit: String) {
        store.fetchPosts(from: subreddit)
    }

    func refreshPosts() {
        store.refreshPosts()
    }

    func numberOfItems(inSection section: Int) -> Int {
        return viewState.cellViewModels.count
    }

    func itemViewModel(at indexPath: IndexPath) -> PostItemViewModel {
        return viewState.cellViewModels[indexPath.row]
    }

}

// MARK: -
// MARK: PostsStoreDelegate

extension PostsViewModel: PostsStoreDelegate {

    func didUpdateWithState(_ state: PostsState) {
        let showAuthor = !(state.subreddit?.isEmpty ?? true)
        let cellViewModels = state.requestState.items?.compactMap {
            PostItemViewModel(post: $0, showAuthor: showAuthor)
        }

        self.viewState = PostsViewState(
            cellViewModels: cellViewModels ?? [],
            isLoading: state.requestState == .loading)
        
        delegate?.didUpdateWithState(self.viewState)
    }

}
