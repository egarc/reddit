//
//  PostsStore.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import Alamofire

class PostsStore {

    // MARK: -
    // MARK: Private Properties

    private var state: PostsState

    private let favoritesStore: FavoritesStore

    // MARK: -
    // MARK: Public Properties

    weak var delegate: PostsStoreDelegate? = nil

    // MARK: -
    // MARK: Initialization

    init(favoritesStore: FavoritesStore) {
        self.favoritesStore = favoritesStore

        let favorites = favoritesStore.fetchFavorites().map { $0.value.id }
        self.state = PostsState(
            subreddit: nil,
            requestState: .idle,
            favorites: favorites)

        DispatchQueue.main.async {
            self.delegate?.didUpdateWithState(self.state)
        }
    }

}

// MARK: -
// MARK: PostsStoreCommands

extension PostsStore: PostsStoreCommands {

    func fetchPosts(from subreddit: String?) {
        var newState = self.state
        newState.subreddit = subreddit
        newState.requestState = .loading
        self.state = newState

        DispatchQueue.main.async {
            self.delegate?.didUpdateWithState(newState)
        }

        AF.request(Requests.subreddit(subreddit)).responseDecodable { [weak self] (response: DataResponse<Page>) in
            guard let self = self else { return }

            var newState = self.state
            switch response.result {
            case .success(let page):
                newState.requestState = .success(page.posts)
            case .failure(let error):
                newState.requestState = .failure(error)
            }
            self.state = newState
            
            DispatchQueue.main.async {
                self.delegate?.didUpdateWithState(newState)
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
// MARK: FavoritesStoreDelegate

extension PostsStore: FavoritesStoreDelegate {

    func didUpdateWithState(_ state: FavoritesState) {
        var newState = self.state
        newState.favorites = state.posts?.compactMap { $0.id }
        self.state = newState

        self.delegate?.didUpdateWithState(newState)
    }

}



