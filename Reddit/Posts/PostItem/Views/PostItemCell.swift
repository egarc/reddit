//
//  PostItemCell.swift
//  Reddit
//
//  Created by Eric Garcia on 5/18/19.
//  Copyright © 2019 Eric Garcia. All rights reserved.
//

import UIKit

final class PostItemCell: UITableViewCell {

    // MARK: -
    // MARK: Constants

    /// The reuse identifier.
    static let reuseIdentifier = "PostItemCell"

    // MARK: -
    // MARK: Properties

    var viewModel: PostItemViewModelProtocol? {
        didSet { render(state: viewModel?.state) }
    }

    // MARK: -
    // MARK: IBOutlets

    @IBOutlet var titleLabel: UILabel?

    @IBOutlet var detailLabel: UILabel?

    @IBOutlet var favoriteButton: UIButton?

    // MARK: -
    // MARK: IBActions

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        viewModel?.postItemViewModelDidTapFavoriteButton()
    }

    // MARK: -
    // MARK: Overrides

    override func awakeFromNib() {
        super.awakeFromNib()

        let image = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        favoriteButton?.setImage(image, for: .normal)
    }

    override func prepareForReuse() {
        viewModel = nil
    }

}

// MARK: -
// MARK: Stateful

private extension PostItemCell {

    func render(state: PostItemState?) {
        titleLabel?.text = state?.title
        detailLabel?.text = state?.detail
        favoriteButton?.tintColor = (state?.favorite ?? false) ? .red : .darkGray
    }

}
