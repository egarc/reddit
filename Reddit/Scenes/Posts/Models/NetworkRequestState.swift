//
//  NetworkRequestState.swift
//  Reddit
//
//  Created by Eric Garcia on 5/19/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

enum NetworkRequestState<T: Equatable> {

    case idle

    case loading

    case success([T])

    case failure(Error?)

    /// The items for the state; will return `nil` if the state is not `.success`.
    var items: [T]? {
        switch self {
        case .idle, .loading, .failure:
            return nil
        case .success(let items):
            return items
        }
    }

}

// MARK: -
// MARK: Equatable

extension NetworkRequestState: Equatable {

    static func ==(lhs: NetworkRequestState, rhs: NetworkRequestState) -> Bool {
        switch(lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.success(let lhsItems), .success(let rhsItems)):
            return lhsItems == rhsItems
        case (.failure, .failure):
            return false
        default:
            return false
        }
    }

}

