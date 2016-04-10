//
//  ResultView.swift
//  PQR
//
//  Created by Sahil Ambardekar on 4/10/16.
//  Copyright © 2016 sahil. All rights reserved.
//

import UIKit

class ResultView: UIView {
    
    var delegate: ResultViewDelegate!

    @IBOutlet weak var imageView: UIImageView!
    override func drawRect(rect: CGRect) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4
    }
    
    @IBAction func ok(sender: AnyObject) {
        delegate?.okClicked()
    }
}

protocol ResultViewDelegate {
    
    func okClicked()
}
