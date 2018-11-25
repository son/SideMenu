//
//  SpacerView.swift
//  SlideMenu
//
//  Created by takeru on 2018/11/24.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

final class SpacerView: UIView {

    private let space: CGFloat

    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }

    override var intrinsicContentSize: CGSize {
        return .init(width: space, height: space)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
