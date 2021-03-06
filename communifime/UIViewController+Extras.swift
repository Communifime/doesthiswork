//
//  UIViewController+Extras.swift
//  communifime
//
//  Created by Michael Litman on 3/26/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

extension UIViewController
{
    @IBAction func standardActionCancelButtonPressedAnimated(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func standardActionCancelButtonPressedNotAnimated(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }    
}
