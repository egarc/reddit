//
//  FavoritesViewState.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import MVVMC

struct FavoritesViewState: ViewState {

    /// The favorite post item view models.
    var cellViewModels: [PostItemViewModel] = []

}

// MARK: -
// MARK: Equatable

extension FavoritesViewState: Equatable {

    static func ==(lhs: FavoritesViewState, rhs: FavoritesViewState) -> Bool {
        return lhs.cellViewModels == rhs.cellViewModels
    }

}

// MARK: -
// MARK: Loggable

extension FavoritesViewState: Loggable {

    var logDescription: String {
        return """
        FavoritesViewState {
            cellViewModels: \(cellViewModels),
        }
        """
    }

}
