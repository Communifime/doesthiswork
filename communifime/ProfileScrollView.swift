//
//  ProfileScrollView.swift
//  communifime
//
//  Created by Michael Litman on 4/2/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ProfileScrollView: UIScrollView
{
    var currY = CGFloat(0.0)
    var theTFs : [String : UITextField] = [:]
    let gapBetweenRows = CGFloat(10.0)
    let heightOfTextField = CGFloat(30.0)
    
    func addTextFieldAtCurrentRow(name: String, placeholderText: String, value: String = "", x: CGFloat, width: CGFloat)
    {
        let frame = CGRectMake(x, self.currY, width, heightOfTextField)
        let tf = UITextField(frame: frame)
        tf.placeholder = placeholderText
        tf.text = value
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: tf.frame.size.height - width, width:  tf.frame.size.width, height: tf.frame.size.height)
        
        border.borderWidth = width
        tf.layer.addSublayer(border)
        tf.layer.masksToBounds = true
        self.addSubview(tf)
        self.theTFs[name] = tf
    }
    
    func advanceToNextRow()
    {
        self.currY = self.currY + heightOfTextField + self.gapBetweenRows
        self.contentSize = CGSizeMake(self.contentSize.width, self.currY + self.heightOfTextField)
    }
}
