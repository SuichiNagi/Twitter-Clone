//
//  EditProfileViewModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 10/3/24.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case bio
    
    var description: String {
        switch self {
        case .fullname: return "Name"
        case .username: return "Username"
        case .bio: return "Bio"
        }
    }
}
