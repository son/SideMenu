//
//  MenuItemCell.swift
//  SlideMenu
//
//  Created by takeru on 2018/11/24.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

final class MenuItemCell: UITableViewCell {

    private var iconImageView: UIImageView!
    private var itemLabel: UILabel!
    private var stackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addConstraint()
    }

    private func setupView() {
        iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit

        itemLabel = UILabel()
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)

        stackView = UIStackView(arrangedSubviews: [iconImageView, itemLabel, UIView()])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        addSubview(stackView)
    }

    private func addConstraint() {
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 24, bottom: 8, right: 12)
    }

    var menuItem: MenuItem? {
        didSet {
            iconImageView.image = menuItem?.icon
            itemLabel.text = menuItem?.title
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
