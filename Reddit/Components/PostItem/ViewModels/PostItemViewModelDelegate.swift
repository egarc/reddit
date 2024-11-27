//
//  PostItemViewModelDelegate.swift
//  Reddit
//
//  Created by Eric Garcia on 5/22/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import Foundation

protocol PostItemViewModelDelegate: AnyObject {

    /// Called when the fav button is tapped.
    func postItemViewModelDidTapFavoriteButton(with post: Post)

}
