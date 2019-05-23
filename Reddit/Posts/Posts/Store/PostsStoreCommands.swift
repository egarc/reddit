//
//  PostsStoreCommands.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

protocol PostsStoreCommands {

    /// Fetches posts from a given subreddit. If no subreddit is specfied, the front page is fetched.
    ///
    /// - Parameter subreddit: The name of the subreddit.
    func fetchPosts(from subreddit: String?)

    /// Refreshes the current posts.
    func refreshPosts()

    /// Fetches the favorite posts.
    func fetchFavorites()

    /// Toggles favorite for a post.
    ///
    /// - Parameter post: A post.
    func toggleFavorite(for post: Post)

}
