//
//  MenuHeaderView.swift
//  SlideMenu
//
//  Created by takeru on 2018/11/24.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

final class MenuHeaderView: UIView {

    private var iconImageView: UIImageView!
    private var nameLabel: UILabel!
    private var userIDLabel: UILabel!
    private var followerLabel: UILabel!
    private var stackView: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addConstraint()
    }

    private func setupView() {
        iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(named: "Github")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 48 / 2

        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "son"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)

        userIDLabel = UILabel()
        userIDLabel.text = "@son_swift_app"
        userIDLabel.translatesAutoresizingMaskIntoConstraints = false

        followerLabel = UILabel()
        followerLabel.translatesAutoresizingMaskIntoConstraints = false
        setAttributedText()

        stackView = UIStackView(arrangedSubviews: [UIView(), iconImageView, nameLabel, userIDLabel, SpacerView(space: 16), followerLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        addSubview(stackView)
    }

    private func addConstraint() {
        iconImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true

        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }

    private func setAttributedText() {
        followerLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(
            string: "99999 ",
            attributes: [.font : UIFont.systemFont(ofSize: 17, weight: .medium)]
        )
        attributedText.append(NSMutableAttributedString(
            string: "Following  ",
            attributes: [.foregroundColor : UIColor.black]
        ))
        attributedText.append(NSMutableAttributedString(
            string: "99999 ",
            attributes: [.font : UIFont.systemFont(ofSize: 17, weight: .medium)]
        ))
        attributedText.append(NSMutableAttributedString(
            string: "Followers",
            attributes: [.foregroundColor : UIColor.black]
        ))
        followerLabel.attributedText = attributedText
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
