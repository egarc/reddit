//
//  FavoritesStore.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import UIKit

class FavoritesStore {

    // MARK: -
    // MARK: Private Properties

    fileprivate let favoritesKey = "favorites"

    private var state: FavoritesState
    
    // MARK: -
    // MARK: Public Properties

    weak var delegate: FavoritesStoreDelegate? = nil

    // MARK: -
    // MARK: Initialization

    init() {
        self.state = FavoritesState()
    }
    
}

extension FavoritesStore: FavoritesStoreCommands {
    
    /// Fetches favorites from disk.
    @discardableResult
    func fetchFavorites() -> [String: Post] {
        guard
            let storedfavorites = UserDefaults.standard.data(forKey: favoritesKey),
            let favorites = try? PropertyListDecoder().decode([String: Post].self, from: storedfavorites)
            else {
                return [:]
        }

        var newState = self.state
        newState.posts = Array(favorites.values)
        self.state = newState
        self.delegate?.didUpdateWithState(newState)

        return favorites
    }

    func toggleFavorite(for post: Post) {
        var favorites = fetchFavorites()

        if favorites.values.contains(post) {
            favorites[post.id] = nil
        } else {
            favorites[post.id] = post
        }

        do {
            UserDefaults.standard.set(try PropertyListEncoder().encode(favorites), forKey: favoritesKey)

            var newState = self.state
            newState.posts = Array(favorites.values)
            self.state = newState

            DispatchQueue.main.async {
                self.delegate?.didUpdateWithState(newState)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}
