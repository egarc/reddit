//
//  PostsViewModelProtocol.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import Foundation

protocol PostsViewModelProtocol {

    /// Fetches the front page.
    func fetchFrontPage() async

    /// Fetches the first page of the given subreddit.
    ///
    /// - Parameter subreddit: A subreddit name.
    func fetchPosts(from subreddit: String) async

    /// Refreshes the current posts.
    func refreshPosts() async

    /// Fetches the favorite posts.
    func fetchFavorites()

    /// Returns the number of items.
    ///
    /// - Parameter section: The section.
    /// - Returns: A number of items.
    func numberOfItems(inSection section: Int) -> Int

    /// Returns the post item view model for a given index path.
    ///
    /// - Parameter indexPath: The index path.
    /// - Returns: A post item view model.
    func itemViewModel(at indexPath: IndexPath) -> PostItemViewModelProtocol

}
