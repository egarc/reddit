//
//  FavoritesState.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import MVVMC

struct FavoritesState: DomainState {

    /// The favorite posts.
    var posts: [Post]?

}

// MARK: -
// MARK: Equatable

extension FavoritesState: Equatable {

    static func ==(lhs: FavoritesState, rhs: FavoritesState) -> Bool {
        return lhs.posts == rhs.posts
    }

}

// MARK: -
// MARK: Loggable

extension FavoritesState: Loggable {

    var logDescription: String {
        return """
        FavoritesState {
            posts: \(String(describing: posts)),
        }
        """
    }

}
