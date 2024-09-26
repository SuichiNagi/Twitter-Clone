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
    var tweetID: String?
    var timestamp: Date!
    var user: UserModel
    var tweet: TweetModel?
    var type: NotificationType!
    
    init(user: UserModel, dictionary: [String: AnyObject]) {
        self.user = user
        
        if let tweetID = dictionary["tweetID"] as? String {
            self.tweetID = tweetID
        }
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
}
