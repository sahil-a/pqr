//
//  Code.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/10/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit

struct Code {
    var title: String
    var description: String
    var id: Int
    var allowedUsers:[String]!
    var passcode: String!
    
    init(id: Int, title: String, description: String) {
        
        self.id = id
        self.title = title
        self.description = description
    }
}
