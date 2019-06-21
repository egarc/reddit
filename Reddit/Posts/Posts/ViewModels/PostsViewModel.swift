//
//  PostsViewModel.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import Foundation
import Common

final class PostsViewModel: ViewModel<PostsViewState> {

    // MARK: -
    // MARK: Private Properties

    private let store: PostsStore

    // MARK: -
    // MARK: Initialization

    init(store: PostsStore) {
        self.store = store

        super.init(initialState: PostsViewState(
            cellViewModels: [],
            isLoading: false))

        subscribe(to: store) { [weak self] in
            self?.processDomainStateChange(state: $0)
        }
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

    func fetchFavorites() {
        store.fetchFavorites()
    }

    func numberOfItems(inSection section: Int) -> Int {
        return state.cellViewModels.count
    }

    func itemViewModel(at indexPath: IndexPath) -> PostItemViewModelProtocol {
        return state.cellViewModels[indexPath.row]
    }

}

// MARK: -
// MARK: State Changes

private extension PostsViewModel {

    /// Translates `PostsState` into `PostsViewState` and updates
    /// self's state.
    ///
    /// - Parameter state: The `PostsState` to process.
    func processDomainStateChange(state: PostsState) {
        let showAuthor = !(state.subreddit?.isEmpty ?? true)
        let cellViewModels = state.requestState.items?.compactMap {
            PostItemViewModel(
                post: $0,
                showAuthor: showAuthor,
                favorite: state.favorites?.contains($0.id) ?? false,
                delegate: self)
        }

        let newState = PostsViewState(
            cellViewModels: cellViewModels ?? [],
            isLoading: state.requestState == .loading)

        write { self.state = newState }
    }

}

// MARK: -
// MARK: PostItemViewModelDelegate

extension PostsViewModel: PostItemViewModelDelegate {

    func postItemViewModelDidTapFavoriteButton(with post: Post) {
        store.toggleFavorite(for: post)
    }

}
