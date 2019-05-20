//
//  PostItemViewModel.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

final class PostItemViewModel: PostItemViewModelProtocol {

    // MARK: -
    // MARK: Public Properties

    let state: PostItemState

    // MARK: -
    // MARK: Initialization

    init(post: Post, showAuthor: Bool) {
        self.state = PostItemState(
            title: post.title,
            detail: showAuthor ? post.author : post.subreddit,
            url: post.url)
    }

}
