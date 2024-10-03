//
//  ProfileHeaderViewModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/29/24.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets:
            return "Tweets"
        case .replies:
            return "Tweets & Replies"
        case .likes:
            return "Likes"
        }
    }
}

struct ProfileHeaderViewModel {
    private let user: UserModel
    
    init(user: UserModel) {
        self.user = user
    }
    
    var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        if !user.isFollowed && !user.isCurrentUser {
            return "Follow"
        }
        
        if user.isFollowed {
            return "Following"
        }
        
        return "Loading"
    }
    
    var bioString: String? {
        return user.bio != nil ? user.bio : ""
    }
    
    var usernameString: String? {
        return "@\(user.username)"
    }
    
    var followersString: NSAttributedString? {
        return NSAttributedString.statsAttributedText(withValue: user.stats?.followers ?? 0, text: " followers")
    }
    
    var followingString: NSAttributedString? {
        return NSAttributedString.statsAttributedText(withValue: user.stats?.following ?? 0, text: " following")
    }
}
