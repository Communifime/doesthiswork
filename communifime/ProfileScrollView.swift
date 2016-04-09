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
    var theAddresses : [String : AddressView] = [:]
    var thePairs : [String : PairVC] = [:]
    let gapBetweenRows = CGFloat(10.0)
    let heightOfTextField = CGFloat(30.0)
    var stackView : UIStackView!
    
    func addTextField(name: String, placeholderText: String, value: String = "", x: CGFloat, width: CGFloat)
    {
        //let tf = Core.storyboard.instantiateViewControllerWithIdentifier("TextView") as! TextView
        let tf = UITextField()
        tf.placeholder = placeholderText
        tf.text = value
        //tf.setRect(x, y: self.currY, width: width, height: 30)
        tf.setRect(0, y: 0, width: width, height: 30)
        tf.maskWithUnderline()
        self.addView(tf)
        self.theTFs[name] = tf
    }
    
    func refresh()
    {
        currY = CGFloat(20.0)
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        
        for tf in self.theTFs
        {
            let f = tf.1.frame
            tf.1.setRect(f.origin.x, y: self.currY, width: f.size.width, height: 30)
            self.addView(tf.1)
        }
        /*
        for av in self.theAddresses
        {
            av.1.view.setRect(10, y: self.currY, width: av.1.view.getWidth(), height: 150)
            self.addView(av.1.view)
        }
        
        for pair in self.thePairs
        {
            pair.1.view.setRect(10, y: self.currY, width: pair.1.view.getWidth(), height: 300)
            self.addView(pair.1.view)
        }
 */
    }
    
    func addView(view : UIView)
    {
        self.stackView.addArrangedSubview(view)
        //self.addSubview(view)
        self.currY += view.getHeight() + self.gapBetweenRows
        self.contentSize = CGSizeMake(self.contentSize.width, self.currY + view.getHeight())
    }
    
    func addPairList(name: String)
    {
        let vc = Core.storyboard.instantiateViewControllerWithIdentifier("PairVC") as! PairVC
        vc.category = name
        vc.profileSV = self
        //vc.view.setRect(10, y: self.currY, width: vc.view.getWidth(), height: 300)
        vc.view.setRect(10, y: 0, width: vc.view.getWidth(), height: 300)
        self.addView(vc.view)
        self.thePairs[name] = vc
    }
    
    func addAddress(name : String)
    {
        let vc = Core.storyboard.instantiateViewControllerWithIdentifier("AddressView") as! AddressView
        vc.addressName = name
        //vc.view.setRect(10, y: self.currY, width: vc.view.getWidth(), height: 150)
        vc.view.setRect(10, y: 0, width: vc.view.getWidth(), height: 150)
        //vc.view.setPosition(10.0, y: self.currY)
        //vc.view.setHeight(110)
        self.addView(vc.view)
        self.theAddresses[name] = vc
    }
}
