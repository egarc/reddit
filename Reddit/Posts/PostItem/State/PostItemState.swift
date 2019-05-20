//
//  PostItemState.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

struct PostItemState {

    /// The post title.
    let title: String

    /// The subreddit if it's the front page, or the author if we're in a subreddit.
    let detail: String?

    /// The URL of the post content.
    let url: String

}
