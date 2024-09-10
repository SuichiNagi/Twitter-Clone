//
//  TweetViewModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/28/24.
//

import UIKit

struct TweetViewModel {
    
    let tweet: TweetModel
    let user: UserModel
    
    init(tweet: TweetModel) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var retweetCount: NSAttributedString? {
        return NSAttributedString.attributedText(withValue: tweet.retweetCount, text: " Retweets")
    }
    
    var likesCount: NSAttributedString? {
        return NSAttributedString.attributedText(withValue: tweet.likes, text: " Likes")
    }
    
    var usernameText: String {
        return "@\(user.username)"
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSAttributedString(string: " @\(user.username)",
                                        attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        title.append(NSAttributedString(string: " @ ∙ \(timeStamp)",
                                        attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    var timeStamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? ""
    }
    
    var headerTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ∙ MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
}
