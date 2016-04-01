//
//  Core.swift
//  communifime
//
//  Created by Michael Litman on 3/26/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase

class Core: NSObject
{

    static var fireBaseRef = Firebase(url: "https://amber-fire-7588.firebaseio.com/")
    
    static func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    static func makeViewACircle(v : UIView)
    {
        v.layer.cornerRadius = 37.5
        v.layer.borderWidth = 1.0
        v.layer.masksToBounds = true
        v.layer.backgroundColor = UIColor.clearColor().CGColor
    }
}
