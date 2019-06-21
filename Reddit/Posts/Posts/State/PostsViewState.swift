import Foundation
import Common

struct PostsViewState: ViewState {
    
    /// The post item view models.
    var cellViewModels: [PostItemViewModel] = []

    /// True if posts are currently being fetched.
    var isLoading: Bool
    
}

// MARK: -
// MARK: Equatable

extension PostsViewState: Equatable {
    
    static func ==(lhs: PostsViewState, rhs: PostsViewState) -> Bool {
        return lhs.cellViewModels == rhs.cellViewModels
            && lhs.isLoading == rhs.isLoading
    }
    
}

// MARK: -
// MARK: Loggable

extension PostsViewState: Loggable {
    
    var logDescription: String {
        return """
        PostsViewState {
            cellViewModels: \(cellViewModels),
            isLoading: \(isLoading),
        }
        """
    }
    
}
