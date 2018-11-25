//
//  BaseSlideViewController.swift
//  SlideMenu
//
//  Created by takeru on 2018/11/24.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

final class BaseSlideViewController: UIViewController {

    private var baseHomeView: UIView!
    private var baseMenuView: UIView!
    private var darkCoverView: UIView!

    private var baseHomeViewLeadingConstraint: NSLayoutConstraint!
    private var baseHomeViewTrailingConstraint: NSLayoutConstraint!
    private let menuWidth: CGFloat = 300
    private let velocityThreshold: CGFloat = 500
    private var isMenuOpened = false

    private var rightViewController: UIViewController = UINavigationController(rootViewController: HomeViewController())
    private let menuViewController = MenuViewController()//ChatRoomMenuViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addConstraint()
        setupViewController()
    }

    private func setupView() {
        view.backgroundColor = .yellow

        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))

        baseHomeView = UIView()
        baseHomeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(baseHomeView)

        baseMenuView = UIView()
        baseMenuView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(baseMenuView)

        darkCoverView = UIView()
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        darkCoverView.alpha = 0
        darkCoverView.translatesAutoresizingMaskIntoConstraints = false
        darkCoverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(darkCoverViewTapped)))
    }

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return isMenuOpened ? .lightContent : .default
//    }

    private func addConstraint() {
        baseHomeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        baseHomeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        baseMenuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        baseMenuView.trailingAnchor.constraint(equalTo: baseHomeView.leadingAnchor).isActive = true
        baseMenuView.widthAnchor.constraint(equalToConstant: menuWidth).isActive = true
        baseMenuView.bottomAnchor.constraint(equalTo: baseHomeView.bottomAnchor).isActive = true

        baseHomeViewLeadingConstraint = baseHomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        baseHomeViewLeadingConstraint.isActive = true
        baseHomeViewTrailingConstraint = baseHomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        baseHomeViewTrailingConstraint.isActive = true
    }

    private func setupViewController() {
        let homeView = rightViewController.view!
        let menuView = menuViewController.view!

        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false

        baseHomeView.addSubview(homeView)
        baseHomeView.addSubview(darkCoverView)
        baseMenuView.addSubview(menuView)

        homeView.topAnchor.constraint(equalTo: baseHomeView.topAnchor).isActive = true
        homeView.leadingAnchor.constraint(equalTo: baseHomeView.leadingAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: baseHomeView.bottomAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: baseHomeView.trailingAnchor).isActive = true

        menuView.topAnchor.constraint(equalTo: baseMenuView.topAnchor).isActive = true
        menuView.leadingAnchor.constraint(equalTo: baseMenuView.leadingAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: baseMenuView.bottomAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: baseMenuView.trailingAnchor).isActive = true

        darkCoverView.topAnchor.constraint(equalTo: baseHomeView.topAnchor).isActive = true
        darkCoverView.leadingAnchor.constraint(equalTo: baseHomeView.leadingAnchor).isActive = true
        darkCoverView.bottomAnchor.constraint(equalTo: baseHomeView.bottomAnchor).isActive = true
        darkCoverView.trailingAnchor.constraint(equalTo: baseHomeView.trailingAnchor).isActive = true
        addChild(rightViewController)
        addChild(menuViewController)
    }

    @objc private func darkCoverViewTapped() {
        closeMenu()
    }

    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        baseHomeViewLeadingConstraint.constant = x
        baseHomeViewTrailingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }

    private func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        if isMenuOpened {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }

    func didSelectMenuItem(indexPath: IndexPath) {
        removeRightViewController()
        closeMenu()
        switch indexPath.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: HomeViewController())
        case 1:
            rightViewController = UINavigationController(rootViewController: ViewController())
        case 2:
            rightViewController = UINavigationController(rootViewController: ViewController())
        default:
            let tabBarController = UITabBarController()
            let momentViewController = ViewController()
            momentViewController.labelTitle = "Moment"
            momentViewController.navigationItem.title = "Moment"
            let navigationConroller = UINavigationController(rootViewController: momentViewController)
            tabBarController.viewControllers = [navigationConroller]
        }
        baseHomeView.addSubview(rightViewController.view)
        addChild(rightViewController)
        baseHomeView.bringSubviewToFront(darkCoverView)
    }

    private func removeRightViewController() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }

    func openMenu() {
        isMenuOpened = true
        baseHomeViewLeadingConstraint.constant = menuWidth
        baseHomeViewTrailingConstraint.constant = menuWidth
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }

    func closeMenu() {
        baseHomeViewLeadingConstraint.constant = 0
        baseHomeViewTrailingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }

    private func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
}
