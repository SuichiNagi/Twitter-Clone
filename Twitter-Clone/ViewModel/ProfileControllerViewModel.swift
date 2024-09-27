//
//  ProfileControllerViewModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/6/24.
//

import Foundation

class ProfileControllerViewModel {
    
    var tweets = [TweetModel]()
    var likedTweets = [TweetModel]()
    var replies = [TweetModel]()
    
    var currentDataSource: [TweetModel] {
        switch selectedFilter {
        case .tweets:
            return tweets
        case .replies:
            return replies
        case .likes:
            return likedTweets
        }
    }
    
    var user: UserModel
    
    var didFetch: (() -> Void)?
    
    var selectedFilter: ProfileFilterOptions =  .tweets {
        didSet {
            didFetch?()
        }
    }
    
    init(user: UserModel) {
        self.user = user
    }
    
    func fetchData() {
        fetchTweets()
        fetchLikedTweets()
        fetchReplies()
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    func fetchTweets() {
        TweetService.shared.fetchTweets(forUser: user) { [weak self] tweets in
            guard let self else { return }
            self.tweets = tweets
            self.didFetch?()
        }
    }
    
    func fetchLikedTweets() {
        TweetService.shared.fetchLikes(forUser: user) { [weak self] tweets in
            guard let self else { return }
            self.likedTweets = tweets
        }
    }
    
    func fetchReplies() {
        TweetService.shared.fetchReplies(forUser: user) { [weak self] tweets in
            guard let self else { return }
            self.replies = tweets
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
