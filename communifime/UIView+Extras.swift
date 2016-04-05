//
//  UIView+Extras.swift
//  communifime
//
//  Created by Michael Litman on 4/5/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

extension UIView
{
    func maskAsCircle()
    {
        let v = self
        v.layer.cornerRadius = max(self.getWidth(), self.getHeight())/2
        v.layer.borderWidth = 1.0
        v.layer.masksToBounds = true
        v.layer.backgroundColor = UIColor.clearColor().CGColor
    }
    
    func maskWithUnderline()
    {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: self.getHeight() - width, width: self.getWidth(), height: self.getHeight())
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func getHeight() -> CGFloat
    {
        return self.frame.size.height
    }
    
    func getWidth() -> CGFloat
    {
        return self.frame.size.width
    }
    
    func setPosition(x : CGFloat, y : CGFloat)
    {
        let f = self.frame
        self.frame = CGRectMake(x, y, f.size.width, f.size.height)
    }
    
    func setHeight(height : CGFloat)
    {
        let f = self.frame
        self.frame = CGRectMake(f.origin.x, f.origin.y, f.size.width, height)
    }
    
    func setWidth(width : CGFloat)
    {
        let f = self.frame
        self.frame = CGRectMake(f.origin.x, f.origin.y, width, f.size.height)
    }
    
    func setRect(x : CGFloat, y : CGFloat, width : CGFloat, height : CGFloat)
    {
        self.frame = CGRectMake(x, y, width, height)
    }
}
