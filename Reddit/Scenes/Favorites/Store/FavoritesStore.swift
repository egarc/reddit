//
//  FavoritesStore.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import UIKit
import MVVMC

class FavoritesStore: Store<FavoritesState> {

    // MARK: -
    // MARK: Private Properties

    fileprivate let favoritesKey = "favorites"

    // MARK: -
    // MARK: Initialization

    init() {
        super.init(initialState: FavoritesState(posts: []))
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

        write {
            var newState = self.state
            newState.posts = Array(favorites.values)
            self.state = newState
        }

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
            write {
                var newState = self.state
                newState.posts = Array(favorites.values)
                self.state = newState
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}
