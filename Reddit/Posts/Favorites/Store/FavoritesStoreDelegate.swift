//
//  FavoritesStoreDelegate.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

protocol FavoritesStoreDelegate: class {

    /// Called when the posts state is updated.
    ///
    /// - Parameter state: The new posts state.
    func didUpdateWithState(_ state: FavoritesState)

}
