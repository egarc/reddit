//
//  FavoritesViewModelProtocol.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import UIKit

protocol FavoritesViewModelProtocol {

    /// Fetches the favorite posts.
    func fetchFavorites()

    /// Returns the number of items.
    ///
    /// - Parameter section: The section.
    /// - Returns: A number of items.
    func numberOfItems(inSection section: Int) -> Int

    /// Returns the post item view model for a given index path.
    ///
    /// - Parameter indexPath: The index path.
    /// - Returns: A post item view model.
    func itemViewModel(at indexPath: IndexPath) -> PostItemViewModelProtocol

}

