//
//  MainTabController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/21/24.
//

import UIKit
import SnapKit

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configControllers()
        setUI()
    }
    
    // MARK: - Helpers
    
    private func configControllers() {
        tabBar.backgroundColor = .systemGray6
        
        let nav1 = templateNavigationController(rootViewController: feedController)
        let nav2 = templateNavigationController(rootViewController: exploreController)
        let nav3 = templateNavigationController(rootViewController: notifController)
        let nav4 = templateNavigationController(rootViewController: convoController)
         
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    private func templateNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    private func setUI() {
        view.addSubview(actionButton)
        
        actionButton.snp.makeConstraints { make in
            make.height.width.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64)
            make.right.equalToSuperview().offset(-16)
        }
    }

    private lazy var feedController: FeedController = {
        let feed = FeedController()
        feed.tabBarItem.image = UIImage(named: "home_unselected")
        return feed
    }()
    
    private lazy var exploreController: ExploreController = {
        let explore = ExploreController()
        explore.tabBarItem.image = UIImage(named: "search_unselected")
        return explore
    }()
    
    private lazy var notifController: NotificationsController = {
        let notif = NotificationsController()
        notif.tabBarItem.image = UIImage(named: "like_unselected")
        return notif
    }()
    
    private lazy var convoController: ConversationsController = {
        let convo = ConversationsController()
        convo.tabBarItem.image = UIImage(named: "ic_mail_outline_white_2x-1")
        return convo
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 56 / 2
        return button
    }()
}
