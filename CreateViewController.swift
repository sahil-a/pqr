//
//  CreateViewController.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/10/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit
import Firebase
import DGActivityIndicatorView
import CoreImage

func createQRFromString(str: String) -> CIImage? {
    let stringData = str.dataUsingEncoding(NSUTF8StringEncoding)
    let filter = CIFilter(name: "CIQRCodeGenerator")
    filter?.setValue(stringData, forKey: "inputMessage")
    filter?.setValue("H", forKey: "inputCorrectionLevel")
    return filter?.outputImage
}


class CreateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ResultViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var codes: [Code] = [Code]()
    var indicator: DGActivityIndicatorView = DGActivityIndicatorView(type: .BallClipRotatePulse, tintColor: UIColor.whiteColor())
    var customView: ResultView!
    
    func okClicked() {
        
        //report working image, increment counter, change user array, and reload table view
        let working = User.currentUser.workingCode
        
        dispatch_async(dispatch_get_main_queue()) {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: {
                
                self.customView.center = CGPointMake(self.view.center.x, 1.5 * self.view.center.y)
                
                
                
                }, completion: { (bool) -> () in })
        }
        
        var c_ref = REF.childByAppendingPath("counter")
        c_ref.setValue(User.currentUser.workingCode.id+1)
        
        c_ref = REF.childByAppendingPath("codes")
        
        c_ref.observeEventType(.Value, withBlock: {snapshot2 in
            if var codes_raw = snapshot2.value as? [[String:AnyObject]] {
                codes_raw.append(["description" : working.description, "title" : working.title, "id" : working.id, "users" : working.allowedUsers, "passcode": working.passcode])
                c_ref.setValue(codes_raw, withCompletionBlock: { error, base in self.rl()})
            }
        })
        
        let local = REF_USERS.childByAppendingPath(User.currentUser.id).childByAppendingPath("codes")
        local.observeEventType(.Value, withBlock: { snapshot in
            
            if var ids = snapshot.value as? [Int] {
                
                ids.append(working.id)
                local.setValue(ids)
            }
        })


        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        indicator.frame.size = CGSize(width: view.frame.size.width * 0.1, height: view.frame.size.width * 0.1)
        indicator.center = CGPointMake(view.frame.width/2, 40)
        indicator.tintColor = UIColor(red: 216/255.0, green: 96/255.0, blue: 96/255.0, alpha: 1.0)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(10 * NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
        }
        view.addSubview(indicator)
        indicator.startAnimating()
        indicator.hidden = false
        
        if var working = User.currentUser.workingCode {
            let c_ref = REF.childByAppendingPath("counter")
            c_ref.observeEventType(.Value, withBlock: {snapshot2 in
                if let count = snapshot2.value as? Int {
                    
                    working.id = count
                    // increment count
                    
                    if let img = createQRFromString("\(working.id): \(working.title) :: \(working.description)") {
                        let somImage = UIImage(CIImage: img, scale: 1.0, orientation: UIImageOrientation.Down)
                        
                        
                        if let cv = NSBundle.mainBundle().loadNibNamed("ResultView", owner: self, options: nil).first as? ResultView {
                            self.customView = cv
                            self.customView.frame.size = CGSizeMake(280, 400)
                            self.view.addSubview(self.customView)
                            self.customView.center = CGPointMake(self.view.center.x, 1.5 * self.view.center.y)
                            self.customView.imageView.image = somImage
                            self.customView.delegate = self
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: {
                                    
                                    self.customView.center = CGPointMake(self.view.center.x, self.view.center.y - 60)
                                    
                                    
                                    
                                    }, completion: { (bool) -> () in })
                            }
                        }
                        
                    }
                }
            })
        }
        
        rl()
    }
    
    func rl() {
        let local = REF_USERS.childByAppendingPath(User.currentUser.id).childByAppendingPath("codes")
        local.observeEventType(.Value, withBlock: { snapshot in
            
            if let ids = snapshot.value as? [Int] {
                
                let c_ref = REF.childByAppendingPath("codes")
                
                c_ref.observeEventType(.Value, withBlock: {snapshot2 in
                    
                    if let codes_raw = snapshot2.value as? [[String:AnyObject]] {
                        
                        let remaining = codes_raw.filter({(element) in
                            let val = element["id"] as! Int
                            for id in ids {
                                
                                if val == id {
                                    
                                    return true
                                }
                            }
                            return false
                        })
                        self.codes = remaining.map { (from: [String: AnyObject]) in
                            return Code(id: from["id"] as! Int, title: from["title"]! as! String, description: from["description"]! as! String)
                        }
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            self.tableView.reloadData()
                            self.indicator.stopAnimating()
                            self.indicator.hidden = true
                        }
                    }
                })
            }
        })

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = codes[indexPath.row].title
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
}
