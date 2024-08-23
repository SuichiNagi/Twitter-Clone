//
//  UserModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/23/24.
//

import Foundation

struct UserModel {
    let fullname: String
    let email: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname           = dictionary["fullname"] as? String ?? ""
        self.email              = dictionary["email"] as? String ?? ""
        self.profileImageUrl    = dictionary["profileImageUrl"] as? String ?? ""
        self.username           = dictionary["username"] as? String ?? ""
    }
}
