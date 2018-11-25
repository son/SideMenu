//
//  ViewController.swift
//  SlideMenu
//
//  Created by takeru on 2018/11/25.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private var label: UILabel!
    var labelTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = labelTitle

        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 64)
        label.textAlignment = .center
        view.addSubview(label)

        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        label.text = labelTitle
    }
}
