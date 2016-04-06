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
        //let tf = Core.storyboard.instantiateViewControllerWithIdentifier("TextView") as! TextView
        let tf = UITextField()
        tf.placeholder = placeholderText
        tf.text = value
        tf.setRect(x, y: self.currY, width: width, height: 30)
        tf.maskWithUnderline()
        self.addView(tf)
        self.theTFs[name] = tf
    }
    
    func addView(view : UIView)
    {
        self.addSubview(view)
        self.currY += view.getHeight() + self.gapBetweenRows
        self.contentSize = CGSizeMake(self.contentSize.width, self.currY + view.getHeight())
    }
    
    func addAddress(name : String)
    {
        let vc = Core.storyboard.instantiateViewControllerWithIdentifier("AddressView") as! AddressView
        vc.addressName = name
        vc.view.setRect(10, y: self.currY, width: vc.view.getWidth(), height: 150)
        //vc.view.setPosition(10.0, y: self.currY)
        //vc.view.setHeight(110)
        self.addView(vc.view)
    }
}
