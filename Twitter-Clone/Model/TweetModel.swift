//
//  TweetModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/27/24.
//

import Foundation

struct TweetModel {
    let caption: String
    let tweetID: String
    var likes: Int
    let retweetCount: Int
    var timestamp: Date!
    var user: UserModel
    var didLike = false
    var replyingTo: String?
    
    var isReply: Bool { return replyingTo != nil}
    
    init(user: UserModel, tweetID: String, dictionary: [String: Any]) {
        self.tweetID = tweetID
        self.user = user
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        if let replyingTo = dictionary["replyingTo"] as? String {
            self.replyingTo = replyingTo
        }
    }
}
