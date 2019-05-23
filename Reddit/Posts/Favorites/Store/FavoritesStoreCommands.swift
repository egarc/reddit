//
//  FavoriteStoreCommands.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

protocol FavoritesStoreCommands {

    /// Fetch favorites from disk.
    ///
    /// - Returns: A dictionary of posts keyed by id.
    func fetchFavorites() -> [String: Post]

    /// Toggles favorite for a post.
    ///
    /// - Parameter post: A post.
    func toggleFavorite(for post: Post)

}
