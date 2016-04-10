//
//  PageController.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/9/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        titleLabel.font = titleLabel.font.fontWithSize(view.frame.width / 375 * 24)
        descriptionLabel.font = descriptionLabel.font.fontWithSize(view.frame.width / 375 * 21)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
