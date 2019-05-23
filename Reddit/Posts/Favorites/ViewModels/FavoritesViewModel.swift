//
//  FavoritesViewModel.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import UIKit

final class FavoritesViewModel {

    // MARK: -
    // MARK: Private Properties

    private let store: FavoritesStore

    private var viewState: FavoritesViewState

    // MARK: -
    // MARK: Public Properties

    weak var delegate: FavoritesViewModelDelegate? = nil

    // MARK: -
    // MARK: Initialization

    init(store: FavoritesStore) {
        self.store = store
        self.viewState = FavoritesViewState(cellViewModels: [])
    }
    
}

// MARK: -
// MARK: FavoritesViewModelProtocol

extension FavoritesViewModel: FavoritesViewModelProtocol {

    func fetchFavorites() {
        store.fetchFavorites()
    }

    func numberOfItems(inSection section: Int) -> Int {
        return viewState.cellViewModels.count
    }

    func itemViewModel(at indexPath: IndexPath) -> PostItemViewModelProtocol {
        return viewState.cellViewModels[indexPath.row]
    }

}

// MARK: -
// MARK: FavoritesStoreDelegate

extension FavoritesViewModel: FavoritesStoreDelegate {

    func didUpdateWithState(_ state: FavoritesState) {
        let cellViewModels = state.posts?.compactMap {
            PostItemViewModel(
                post: $0,
                showAuthor: false,
                favorite: true,
                delegate: self)
        }

        self.viewState = FavoritesViewState(cellViewModels: cellViewModels ?? [])
        delegate?.didUpdateWithState(self.viewState)
    }

}

// MARK: -
// MARK: FavoritesStore

extension FavoritesViewModel: PostItemViewModelDelegate {

    func postItemViewModelDidTapFavoriteButton(with post: Post) {
        store.toggleFavorite(for: post)
    }

}
