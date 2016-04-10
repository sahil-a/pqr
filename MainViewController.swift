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

    override func viewDidAppear(animated: Bool) {
        setupSwitch()    }
    
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
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
