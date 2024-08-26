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
    let uid: String
    let likes: Int
    let retweetCount: Int
    var timestamp: Date!
    
    init(tweetID: String, dictionary: [String: Any]) {
        self.tweetID = tweetID
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
