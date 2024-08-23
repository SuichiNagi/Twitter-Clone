//
//  Constants.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/22/24.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")