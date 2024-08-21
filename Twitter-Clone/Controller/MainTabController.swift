//
//  MainTabController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/21/24.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configControllers()
    }
    
    func configControllers() {
        tabBar.backgroundColor = .systemGray6
        
        viewControllers = [feedController, exploreController, notifController, convoController]
    }

    lazy var feedController: FeedController = {
        let feed = FeedController()
        feed.tabBarItem.image = UIImage(named: "home_unselected")
        return feed
    }()
    
    lazy var exploreController: ExploreController = {
        let explore = ExploreController()
        explore.tabBarItem.image = UIImage(named: "search_unselected")
        return explore
    }()
    
    lazy var notifController: NotificationsController = {
        let notif = NotificationsController()
        notif.tabBarItem.image = UIImage(named: "like_unselected")
        return notif
    }()
    
    lazy var convoController: ConversationsController = {
        let convo = ConversationsController()
        convo.tabBarItem.image = UIImage(named: "ic_mail_outline_white_2x-1")
        return convo
    }()
}
