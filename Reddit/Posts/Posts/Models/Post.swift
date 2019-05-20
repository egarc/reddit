//
//  Post.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import Foundation

struct Post {

    /// The title of the post.
    let title: String

    /// The subreddit to which the post belongs.
    let subreddit: String

    /// The author of the post.
    let author: String

    /// The URL of the post content.
    let url: String

}

// MARK: -
// MARK: Equatable

extension Post: Equatable {

    public static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.title == rhs.title
            && lhs.subreddit == rhs.subreddit
            && lhs.author == rhs.author
            && lhs.url == rhs.url
    }

}

// MARK: -
// MARK: Decodable

extension Post: Decodable {

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case title = "title"
        case subreddit = "subreddit_name_prefixed"
        case author = "author"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        title = try data.decode(String.self, forKey: .title)
        subreddit = try data.decode(String.self, forKey: .subreddit)
        author = try data.decode(String.self, forKey: .author)
        url = try data.decode(String.self, forKey: .url)
    }

}
