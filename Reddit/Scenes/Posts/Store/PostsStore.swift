//
//  PostsStore.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import Common

class PostsStore: Store<PostsState> {

    // MARK: -
    // MARK: Private Properties

    private let favoritesStore: FavoritesStore

    // MARK: -
    // MARK: Initialization

    init(favoritesStore: FavoritesStore) {
        self.favoritesStore = favoritesStore

        super.init(initialState: PostsState(
            subreddit: nil,
            requestState: .idle,
            favorites: []))

        subscribeToChildStores()
    }

}

// MARK: -
// MARK: PostsStoreCommands

extension PostsStore: PostsStoreCommands {

    func fetchPosts(from subreddit: String?) async {
        write {
            var newState = self.state
            newState.subreddit = subreddit
            newState.requestState = .loading
            self.state = newState
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: Requests.subreddit(subreddit).asURLRequest())
            let decoder = JSONDecoder()
            let page = try decoder.decode(Page.self, from: data)
            write {
                self.state.requestState = .success(page.posts)
            }
        } catch let error {
            write {
                self.state.requestState = .failure(error)
            }
        }
    }

    func refreshPosts() async {
        await fetchPosts(from: state.subreddit)
    }

    func fetchFavorites() {
        favoritesStore.fetchFavorites()
    }

    func toggleFavorite(for post: Post) {
        favoritesStore.toggleFavorite(for: post)
    }

}

// MARK: -
// MARK: Private Helpers

private extension PostsStore {

    /// Subscribes to the recent searches store to observe the recent searches
    func subscribeToChildStores() {
        subscribe(to: favoritesStore) { [weak self] state in
            self?.write { self?.state.favorites = state.posts?.compactMap { $0.id } }
        }
    }

}
