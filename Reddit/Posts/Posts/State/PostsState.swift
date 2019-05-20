//
//  PostsState.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import Alamofire

struct PostsState {

    /// The subreddit that the user has entered.
    var subreddit: String?

    /// The page request state.
    var requestState: NetworkRequestState<Post> = .idle

}

// MARK: -
// MARK: Equatable

extension PostsState: Equatable {

    static func ==(lhs: PostsState, rhs: PostsState) -> Bool {
        return lhs.subreddit == rhs.subreddit
            && lhs.requestState == rhs.requestState
    }

}