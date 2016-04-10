//
//  LoginViewController.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/10/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: PageController, LoginReceiver {
    
    var isShowingMenu: Bool = false
    var menu: LoginMenu?
    var tryingLogin: Bool = false
    var tryingSignUp: Bool = false
    
    func setupMenu() {
        
        if let customView = NSBundle.mainBundle().loadNibNamed("MenuView", owner: self, options: nil).first as? LoginMenu {
            customView.frame.size = CGSizeMake(self.view.frame.width, self.view.frame.width * 135 / 375)
            self.view.addSubview(customView)
            customView.frame.origin = CGPointMake(0, -customView.frame.size.height)
            menu = customView
            menu?.receiver = self
            
            dispatch_async(dispatch_get_main_queue()) {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: {
                    
                    customView.frame.origin = CGPointMake(0, -5)
                    
                    
                    
                    }, completion: { (bool) -> () in self.isShowingMenu = true })
            }
        }
    }
    
    @IBAction func login(sender: AnyObject) {
        toggleMenu()
        tryingLogin = true
        tryingSignUp = false
    }
    
    func toggleMenu() {
        if let menu = menu {
            if isShowingMenu {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: {
                
                menu.frame.origin = CGPointMake(0, -menu.frame.size.height)
                
                
                }, completion: { (bool) -> () in self.isShowingMenu = false })
            } else {
                
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: {
                    
                    menu.frame.origin = CGPointMake(0, 0)
                    
                    
                    }, completion: { (bool) -> () in self.isShowingMenu = true })
            }
        } else {
            
            setupMenu()
        }

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func didFinishEnteringDetails(email: String, password: String) {
        
        if tryingLogin {
            
            let ref = Firebase(url: "https://pqrapp.firebaseio.com")
            ref.authUser(email, password: password) {
                error, authData in
                if error != nil {
                    // an error occured while attempting login
                } else {
                    // user is logged in, check authData for data
                    
                }
            }
            
        } else if tryingSignUp {
            
            let ref = Firebase(url: "https://pqrapp.firebaseio.com")
            ref.createUser(email, password: password, withValueCompletionBlock: { (error, values) in
                
                if error != nil {
                    
                    // error occured
                } else {
                    
                    let uid = values["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                }
            })
        }
    }
    
    @IBAction func signUp(sender: AnyObject) {
        toggleMenu()
        tryingLogin = false
        tryingSignUp = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
