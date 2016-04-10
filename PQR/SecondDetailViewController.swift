//
//  SecondDetailViewController.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/10/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit

class SecondDetailViewController: UIViewController {
    
    @IBOutlet weak var addUserTextField: UITextField!
    @IBOutlet weak var passcodeTextField: UITextField!
    var workingCode: Code!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var navBar: UIView!
    
    override func viewWillAppear(animated: Bool) {
        navBar.layer.shadowRadius = 3
        navBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navBar.layer.shadowColor = UIColor.blackColor().CGColor
        navBar.layer.shadowOpacity = 0.3
        titleLabel.font = titleLabel.font.fontWithSize(view.frame.width / 375 * 21)
        addUserTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        passcodeTextField.layer.sublayerTransform = CATransform3DMakeTranslation(13, 0, 0)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        workingCode.passcode = passcodeTextField.text ?? ""
        workingCode.allowedUsers = passcodeTextField.text?.componentsSeparatedByString(", ")
        User.currentUser.workingCode = workingCode
    }

}
