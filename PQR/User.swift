//
//  User.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/10/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import Foundation
import Firebase

private var _user = User()
let REF = Firebase(url: "https://pqrapp.firebaseio.com")
let REF_USERS = REF.childByAppendingPath("users")

class User {
    
    class var currentUser: User {
        return _user
    }
    
    var id: String!
    var workingCode: Code!
}