//
//  PostsViewModelDelegate.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

protocol PostsViewModelDelegate: class {

    /// Called when the posts view state is updated.
    ///
    /// - Parameter state: The new posts view state.
    func didUpdateWithState(_ state: PostsViewState)

}
