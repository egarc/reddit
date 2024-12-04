//
//  PostsState.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import MVVMC

struct PostsState: DomainState {

    /// The subreddit that the user has entered.
    var subreddit: String?

    /// The page request state.
    var requestState: NetworkRequestState<Post> = .idle

    /// The keys of favorite posts.
    var favorites: [String]?

}

// MARK: -
// MARK: Equatable

extension PostsState: Equatable {

    static func ==(lhs: PostsState, rhs: PostsState) -> Bool {
        return lhs.subreddit == rhs.subreddit
            && lhs.requestState == rhs.requestState
            && lhs.favorites == rhs.favorites
    }

}

// MARK: -
// MARK: Loggable

extension PostsState: Loggable {

    var logDescription: String {
        return """
        PostsState {
            subreddit: \(String(describing: subreddit)),
            requestState: \(requestState),
            favorites: \(String(describing: favorites)),
        }
        """
    }

}
