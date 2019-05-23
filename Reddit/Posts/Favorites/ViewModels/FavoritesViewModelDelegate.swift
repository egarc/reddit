//
//  FavoritesViewModelDelegate.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

protocol FavoritesViewModelDelegate: class {

    /// Called when the favorites view state is updated.
    ///
    /// - Parameter state: The favoritess view state.
    func didUpdateWithState(_ state: FavoritesViewState)

}
