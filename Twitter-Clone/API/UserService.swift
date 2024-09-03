//
//  UserService.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/23/24.
//

import Firebase

struct UserService {
    static let shared = UserService()

    func fetchUser(uid: String, completion: @escaping(UserModel) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String : AnyObject] else { return }
            
            let userModel = UserModel(uid: uid, dictionary: dictionary)
            
           completion(userModel)
        }
    }
    
    func fetchUsers(completion: @escaping([UserModel]) -> Void) {
        var users = [UserModel]()
        REF_USERS.observe(.childAdded) { snapshot in
            
            let uid = snapshot.key
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = UserModel(uid: uid, dictionary: dictionary)
            users.append(user)
            
            completion(users)
        }
    }
}
