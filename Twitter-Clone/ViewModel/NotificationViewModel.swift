//
//  NotificationViewModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/24/24.
//

import Foundation
import UIKit

struct NotificationViewModel {
    
    private let notification: NotificationModel
    private let type: NotificationType
    private let user: UserModel
    
    var timeStampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: notification.timestamp, to: now) ?? ""
    }
    
    init (notification: NotificationModel) {
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
    }
    
    var notificationMessage:String {
        switch type {
        case .follow:
            return " started following you"
        case .like:
            return " liked your tweet"
        case .reply:
            return " replied to your tweet"
        case .retweet:
            return " retweeted to your tweet"
        case .mention:
            return " mentioned you in a tweet"
        }
    }
    
    var notificationText: NSAttributedString? {
        guard let timeStampString else { return nil }
        let isCurrentUser = user.isCurrentUser ? "You" : user.username
        
        let attributedText = NSMutableAttributedString(string: isCurrentUser,
                                                       attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        attributedText.append(NSAttributedString(string: notificationMessage,
                                                 attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
        attributedText.append(NSAttributedString(string: " \(timeStampString)",
                                                 attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                                                              NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    
    var profileImageURL: URL? {
        return user.profileImageUrl
    }
}
