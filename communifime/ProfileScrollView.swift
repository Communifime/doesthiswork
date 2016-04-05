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
    var currY = CGFloat(20.0)
    var theTFs : [String : UITextField] = [:]
    let gapBetweenRows = CGFloat(10.0)
    let heightOfTextField = CGFloat(30.0)
    
    func addTextField(name: String, placeholderText: String, value: String = "", x: CGFloat, width: CGFloat)
    {
        let frame = CGRectMake(x, self.currY, width, heightOfTextField)
        let tf = UITextField(frame: frame)
        tf.placeholder = placeholderText
        tf.text = value
        tf.maskWithUnderline()
        self.addView(tf)
        self.theTFs[name] = tf
    }
    
    func addView(view : UIView)
    {
        print("adding at: X:\(view.frame.origin.x) Y:\(view.frame.origin.y) with height \(view.getHeight())")
        self.addSubview(view)
        self.currY += view.getHeight() + self.gapBetweenRows
        self.contentSize = CGSizeMake(self.contentSize.width, self.currY + view.getHeight())
    }
    
    func addAddress()
    {
        let vc = Core.storyboard.instantiateViewControllerWithIdentifier("AddressView") as! AddressView
        vc.view.setPosition(10.0, y: self.currY)
        self.addView(vc.view)
    }
}
