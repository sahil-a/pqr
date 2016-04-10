//
//  MainViewController.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/10/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit
import DGRunkeeperSwitch

class MainViewController: UIViewController, DGRunkeeperSwitchDelegate {
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var containerView: UIView!
    var runkeeperSwitch: DGRunkeeperSwitch!
    var createViewController: UIViewController {
        get {
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            return storyboard.instantiateViewControllerWithIdentifier("create")
        }
    }
    var viewViewController: UIViewController {
        get {
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            return storyboard.instantiateViewControllerWithIdentifier("view")
        }
    }

    override func viewDidAppear(animated: Bool) {
        setupSwitch()
        containerView.addSubview(createViewController.view)
        self.addChildViewController(createViewController)
        createViewController.view.frame = CGRect(origin: CGPointZero, size: containerView.frame.size)
        selected(0)
    }
    
    func setupSwitch() {
        
        runkeeperSwitch = DGRunkeeperSwitch(leftTitle: "Create", rightTitle: "View")
        runkeeperSwitch.backgroundColor = UIColor(red: 212.0/255.0, green: 117/255.0, blue: 117/255.0, alpha: 1.0)
        runkeeperSwitch.selectedBackgroundColor = .whiteColor()
        runkeeperSwitch.titleColor = .whiteColor()
        runkeeperSwitch.selectedTitleColor = UIColor(red: 216/255.0, green: 96/255.0, blue: 96/255.0, alpha: 1.0)
        runkeeperSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        runkeeperSwitch.frame.size = CGSize(width: view.bounds.width - 100.0, height: 35.0)
        runkeeperSwitch.center = CGPointMake(navBar.center.x, navBar.center.y + 4)
        runkeeperSwitch.autoresizingMask = [.FlexibleWidth]
        runkeeperSwitch.delegate = self
        view.addSubview(runkeeperSwitch)
        navBar.layer.shadowRadius = 3
        navBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navBar.layer.shadowColor = UIColor.blackColor().CGColor
        navBar.layer.shadowOpacity = 0.3
    }
    
    func selected(index: Int) {
        containerView.subviews[0].removeFromSuperview()
        let vc = (index == 0) ? createViewController : viewViewController
        let ovc = (index == 1) ? createViewController : viewViewController
        ovc.removeFromParentViewController()
        containerView.addSubview(vc.view)
        vc.view.frame = CGRect(origin: CGPointZero, size: containerView.frame.size)
        self.addChildViewController(vc)

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
