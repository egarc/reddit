//
//  PostsViewState.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

struct PostsViewState {

    /// The post item view models.
    var cellViewModels: [PostItemViewModel] = []

    /// True if posts are currently being fetched.
    var isLoading: Bool

}
