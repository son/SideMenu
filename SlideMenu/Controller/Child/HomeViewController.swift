//
//  HomeViewController.swift
//  SlideMenu
//
//  Created by takeru on 2018/11/24.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

final class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hode", style: .plain, target: self, action: #selector(hideButtonTapped))

        tableView.separatorStyle = .none
    }

    @objc private func openButtonTapped() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlideViewController)?.openMenu()
    }

    @objc private func hideButtonTapped() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlideViewController)?.closeMenu()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.description())
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}
