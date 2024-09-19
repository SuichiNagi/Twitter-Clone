//
//  ProfileControllerViewModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/6/24.
//

import Foundation

class ProfileControllerViewModel {
    
    var tweets = [TweetModel]()
    
    var user: UserModel
    
    var didFetch: (() -> Void)?
    
    init(user: UserModel) {
        self.user = user
    }
    
    func fetchTweets() {
        TweetService.shared.fetchTweets(forUser: user) { [weak self] tweets in
            guard let self else { return }
            self.tweets = tweets
            self.didFetch?()
        }
    }
    
    func checkIfUserIsFollowed() {
        UserService.shared.checkIfUserIsFollowed(uid: user.uid) { [weak self] isFollowed in
            guard let self else { return }
            self.user.isFollowed = isFollowed
            self.didFetch?()
        }
    }
    
    func fetchUserStats() {
        UserService.shared.fetchUserStats(uid: user.uid) { [weak self] stats in
            guard let self else { return }
            self.user.stats = stats
            self.didFetch?()
        }
    }
    
    func handleEditProfileFollow() {
        if user.isCurrentUser {
            return
        }
        
        if user.isFollowed {
            UserService.shared.unfollowUser(uid: user.uid) { [weak self] err, ref in
                guard let self else { return }
                self.user.isFollowed = false
                self.didFetch?()
            }
        } else {
            UserService.shared.followUser(uid: user.uid) { [weak self] err, ref in
                guard let self else { return }
                self.user.isFollowed = true
                
                NotificationService.shared.uploadNotification(type: .follow, user: self.user)
                self.didFetch?()
            }
        }
    }
}
