//
//  ChatRoomMenuCell.swift
//  SlideMenu
//
//  Created by takeru on 2018/11/25.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

final class ChatRoomMenuCell: UITableViewCell {

    private var backView: UIView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addConstraint()
    }

    private func setupView() {
        selectionStyle = .none

        backView = UIView()
        backView.backgroundColor = #colorLiteral(red: 0.2975772023, green: 0.5870144963, blue: 0.5369818211, alpha: 1)
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 5
        addSubview(backView)
        sendSubviewToBack(backView)
    }

    private func addConstraint() {
        backView.fillSuperview(padding: .init(top: 0, left: 4, bottom: 0, right: 4))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        backView.isHidden = !selected
//        contentView.backgroundColor = selected ? .orange: .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
