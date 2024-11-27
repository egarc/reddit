//
//  AppCoordinator.swift
//  Reddit
//
//  Created by Eric Garcia on 10/30/24.
//  Copyright © 2024 Eric Garcia. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    /// Creates the intial root view for the app.
    /// - Returns: A tab bar controller.
    func createRootViewController() -> UITabBarController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: PostsViewController.self))
        
        // Posts
        let favoritesStore = FavoritesStore()
        let postsStore = PostsStore(favoritesStore: favoritesStore)
        let postsViewModel = PostsViewModel(store: postsStore)
        let tabBarController = storyboard.instantiateInitialViewController() as! UITabBarController
        let postsViewController = tabBarController.viewControllers?.first as! PostsViewController
        postsViewController.viewModel = postsViewModel

        // Favorites
        let favoritesViewModel = FavoritesViewModel(store: favoritesStore)
        let favoritesViewController = tabBarController.viewControllers?[1] as! FavoritesViewController
        favoritesViewController.viewModel = favoritesViewModel
        
        return tabBarController
    }
    
}
