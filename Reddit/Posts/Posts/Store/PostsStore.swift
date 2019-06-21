//
//  PostsStore.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import Alamofire
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

    func fetchPosts(from subreddit: String?) {
        write {
            var newState = self.state
            newState.subreddit = subreddit
            newState.requestState = .loading
            self.state = newState
        }

        AF.request(Requests.subreddit(subreddit)).responseDecodable { [weak self] (response: DataResponse<Page>) in
            guard let self = self else { return }
            
            self.write {
                var newState = self.state
                switch response.result {
                case .success(let page):
                    newState.requestState = .success(page.posts)
                case .failure(let error):
                    newState.requestState = .failure(error)
                }
                self.state = newState
            }
        }
    }

    func refreshPosts() {
        fetchPosts(from: state.subreddit)
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
