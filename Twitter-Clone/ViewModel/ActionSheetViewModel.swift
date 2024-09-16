//
//  ActionSheetViewModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/16/24.
//

import Foundation

enum ActionSheetOptions {
    case follow(UserModel)
    case unfollow(UserModel)
    case report
    case delete
    
    var description: String {
        switch self {
        case .follow(let user):
            return "Follow @\(user.username)"
        case .unfollow(let user):
            return "Unfollow @\(user.username)"
        case .report:
            return "Report Tweet"
        case .delete:
            return "Delete Tweet"
        }
    }
}

struct ActionSheetViewModel {
    private let user: UserModel
    
    var options: [ActionSheetOptions] {
        var results = [ActionSheetOptions]()
        
        if user.isCurrentUser {
            results.append(.delete)
        } else {
            let followOptions: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            results.append(followOptions)
        }
        
        if !user.isCurrentUser {
            results.append(.report)
        }
        
        return results
    }
    
    init(user: UserModel) {
        self.user = user
    }
    
    
}
