//
//  Page.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

struct Page {

    /// A list of reddit posts.
    let posts: [Post]

}


// MARK: -
// MARK: Equatable

extension Page: Equatable {

    public static func ==(lhs: Page, rhs: Page) -> Bool {
        return lhs.posts == rhs.posts
    }

}

// MARK: -
// MARK: Decodable

extension Page: Decodable {

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case children = "children"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        posts = try data.decode(Array<Post>.self, forKey: .children)
    }

}
