//
//  MainTabController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/21/24.
//

import UIKit
import SnapKit
import Firebase

class MainTabController: UITabBarController {
    
    var user: UserModel? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            
            feed.user = user
        }
    }
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ThemeColor.twitterBlue
        authUserAndConfigUI()
    }
    
    //MARK: API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { [weak self] user in
            guard let self else { return }
            self.user = user
        }
    }
    
    func authUserAndConfigUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            configControllers()
            setUI()
            fetchUser()
        }
    }
    
    //MARK: Selectors
    
    @objc private func actionButtonTapped() {
        guard let user else { return }
        let controller = UploadTweetController(user: user, config: .tweet)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    //MARK: Helpers
    
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
    
    //MARK: UI
    
    private func setUI() {
        view.addSubview(actionButton)
        
        actionButton.snp.makeConstraints { make in
            make.height.width.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    //MARK: Properties

    private lazy var feedController: FeedController = {
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        feed.tabBarItem.image = IconImage.feedIcon
        return feed
    }()
    
    private lazy var exploreController: ExploreController = {
        let explore = ExploreController()
        explore.tabBarItem.image = IconImage.exploreIcon
        return explore
    }()
    
    private lazy var notifController: NotificationsController = {
        let notif = NotificationsController()
        notif.tabBarItem.image = IconImage.notifIcon
        return notif
    }()
    
    private lazy var convoController: ConversationsController = {
        let convo = ConversationsController()
        convo.tabBarItem.image = IconImage.convoIcon
        return convo
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = ThemeColor.twitterBlue
        button.setImage(IconImage.tweetIcon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 56 / 2
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
}
