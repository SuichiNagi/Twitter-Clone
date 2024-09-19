//
//  NotificationModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/19/24.
//

import Foundation

enum NotificationType: Int {
    case follow
    case like
    case reply
    case retweet
    case mention
}

struct NotificationModel {
    let tweetID: String?
    var timestamp: Date!
    let user: UserModel
    var tweet: TweetModel?
    var type: NotificationType!
    
    init(user: UserModel, tweet: TweetModel?, dictionary: [String: AnyObject]) {
        self.user = user
        self.tweet = tweet
        
        self.tweetID = dictionary["tweetID"] as? String ?? ""
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
}
