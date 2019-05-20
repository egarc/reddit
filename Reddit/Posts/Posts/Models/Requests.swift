//
//  Requests.swift
//  Reddit
//
//  Created by Eric Garcia on 5/17/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import Alamofire

enum Requests: URLRequestConvertible {

    // A subreddit request e.g. "r/news".
    case subreddit(String?)

    /// The base reddit URL.
    var baseURL: URL {
        return URL(string: "https://reddit.com/")!
    }

    /// The unique path for each request.
    var path: String {
        switch self {
        case .subreddit(let subreddit):
            guard let subreddit = subreddit, !subreddit.isEmpty else {
                return ".json"
            }
            return "r/\(subreddit).json"
        }
    }

    /// Creates a network request.
    ///
    /// - Returns: A `URLRequest`
    /// - Throws: Any error thrown while constructing the `URLRequest`.
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        return URLRequest(url: url)
    }

}
