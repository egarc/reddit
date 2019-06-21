//
//  PostItemViewModel.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

final class PostItemViewModel: PostItemViewModelProtocol {

    // MARK: -
    // MARK: Private Properties

    private let post: Post

    private let showAuthor: Bool

    private let favorite: Bool

    // MARK: -
    // MARK: Public Properties

    weak var delegate: PostItemViewModelDelegate?

    let state: PostItemState

    // MARK: -
    // MARK: Initialization

    init(post: Post, showAuthor: Bool, favorite: Bool, delegate: PostItemViewModelDelegate) {
        self.post = post
        self.showAuthor = showAuthor
        self.favorite = favorite
        self.delegate = delegate

        self.state = PostItemState(
            title: post.title,
            detail: showAuthor ? post.author : post.subreddit,
            url: post.url,
            favorite: favorite)
    }

    // MARK: -
    // MARK: PostItemViewModelProtocol

    func postItemViewModelDidTapFavoriteButton() {
        delegate?.postItemViewModelDidTapFavoriteButton(with: post)
    }

}

// MARK: -
// MARK: 

extension PostItemViewModel: Equatable {

    static func ==(lhs: PostItemViewModel, rhs: PostItemViewModel) -> Bool {
        return lhs.post == rhs.post
            && lhs.showAuthor == rhs.showAuthor
            && lhs.favorite == rhs.favorite
    }

}
