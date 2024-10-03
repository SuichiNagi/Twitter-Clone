//
//  NotificationsController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/21/24.
//

import UIKit

class NotificationsController: UITableViewController {
    
    private var notifications = [NotificationModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        fetchNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: Selectors
    
    @objc private func handleRefresh() {
        fetchNotifications()
    }
    
    //MARK: API
    
    func fetchNotifications() {
        refreshControl?.beginRefreshing()
        NotificationService.shared.fetchNotification { [weak self] notifications in
            guard let self else { return }
            self.refreshControl?.endRefreshing()
            self.notifications = notifications.sorted(by: { $0.timestamp > $1.timestamp })
            self.checkIfUserIsFollowed(notifications: notifications)
        }
    }
    
    func checkIfUserIsFollowed(notifications: [NotificationModel]) {
        for (index, notification) in notifications.enumerated() {
            if case .follow = notification.type {
                let user = notification.user
                
                UserService.shared.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
                    self.notifications[index].user.isFollowed = isFollowed
                }
            }
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Notifications"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

//MARK: UITableViewDataSource

extension NotificationsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.reuseIdentifier, for: indexPath) as! NotificationCell
        
        let notification = notifications[indexPath.row]
        cell.notification = notification
        cell.delegate = self
        
        return cell
    }
}

//MARK: UITableViewDelegate

extension NotificationsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification = notifications[indexPath.row]
        guard let tweetID = notification.tweetID else { return }
        
        TweetService.shared.fetchTweet(withTweetID: tweetID) { [weak self] tweet in
            guard let self else { return }
            let controller = TweetController(tweet: tweet)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

//MARK: NotificationCellDelegate

extension NotificationsController: NotificationCellDelegate {
    func didTapFollow(_ cell: NotificationCell) {
        guard let user = cell.notification?.user else { return }
        
        if (user.isFollowed) {
            UserService.shared.unfollowUser(uid: user.uid) { error, ref in
                cell.notification?.user.isFollowed = false
            }
        } else {
            UserService.shared.followUser(uid: user.uid) { error, ref in
                cell.notification?.user.isFollowed = true
            }
        }
        
        self.checkIfUserIsFollowed(notifications: notifications)
    }
    
    func didTapProfileImage(_ cell: NotificationCell) {
        guard let user = cell.notification?.user else { return }
        
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}
