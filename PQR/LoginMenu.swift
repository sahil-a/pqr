//
//  LoginMenu.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/10/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit
import DGActivityIndicatorView

class LoginMenu: UIView {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var receiver: LoginReceiver?
    var indicator: DGActivityIndicatorView = DGActivityIndicatorView(type: .BallClipRotatePulse, tintColor: UIColor.whiteColor())
    
    @IBAction func next(sender: AnyObject) {
        
        receiver?.didFinishEnteringDetails(emailTextField.text ?? "", password: passwordTextField.text ?? "")
        imageView.hidden = true
        indicator.frame.size = CGSize(width: imageView.frame.size.width * 0.75, height: imageView.frame.size.height * 0.75)
        indicator.center = imageView.center
        button.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func stop() {
        
        imageView.hidden = false
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    override func drawRect(rect: CGRect) {
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 4
        passwordTextField.layer.cornerRadius = 4
    }
    
}

protocol LoginReceiver {
    
    func didFinishEnteringDetails(email: String, password: String)
}
