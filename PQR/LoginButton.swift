//
//  LoginButton.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/9/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit

@IBDesignable class LoginButton: UIButton {
    
    override func drawRect(rect: CGRect) {
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
}
