//
//  LoginButton.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/9/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit

@IBDesignable class LoginButton: UIButton {
    
    @IBInspectable var cornerRad: CGFloat = 5.0 {
        
        didSet {
            
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        layer.cornerRadius = cornerRad
        layer.masksToBounds = true
    }
}
