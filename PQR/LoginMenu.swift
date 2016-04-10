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
    
}

protocol LoginReceiver {
    
    func didFinishEnteringDetails(email: String, password: String)
}
