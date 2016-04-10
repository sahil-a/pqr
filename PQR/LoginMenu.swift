//
//  LoginMenu.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/10/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit

class LoginMenu: UIView {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var receiver: LoginReceiver?
    
    @IBAction func next(sender: AnyObject) {
        
        receiver?.didFinishEnteringDetails(emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    override func drawRect(rect: CGRect) {
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
    }
    
}

protocol LoginReceiver {
    
    func didFinishEnteringDetails(email: String, password: String)
}
