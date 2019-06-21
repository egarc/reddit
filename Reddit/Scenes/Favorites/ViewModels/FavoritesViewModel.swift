//
//  FavoritesViewModel.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import UIKit
import Common

final class FavoritesViewModel: ViewModel<FavoritesViewState> {

    // MARK: -
    // MARK: Private Properties

    private let store: FavoritesStore

    // MARK: -
    // MARK: Initialization

    init(store: FavoritesStore) {
        self.store = store

        super.init(initialState: FavoritesViewState(cellViewModels: []))

        subscribe(to: store) { [weak self] in
            self?.processDomainStateChange(state: $0)
        }
    }
    
}

// MARK: -
// MARK: FavoritesViewModelProtocol

extension FavoritesViewModel: FavoritesViewModelProtocol {

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

private extension FavoritesViewModel {

    /// Translates `FavoritesState` into `FavoritesViewState` and updates
    /// self's state.
    ///
    /// - Parameter state: The `FavoritesState` to process.
    func processDomainStateChange(state: FavoritesState) {
        let cellViewModels = state.posts?.compactMap {
            PostItemViewModel(
                post: $0,
                showAuthor: false,
                favorite: true,
                delegate: self)
        }

        write { self.state = FavoritesViewState(cellViewModels: cellViewModels ?? []) }
    }

}

// MARK: -
// MARK: FavoritesStore

extension FavoritesViewModel: PostItemViewModelDelegate {

    func postItemViewModelDidTapFavoriteButton(with post: Post) {
        store.toggleFavorite(for: post)
    }

}
