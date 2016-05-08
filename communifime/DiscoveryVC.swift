//
//  DiscoveryVC.swift
//  communifime
//
//  Created by Michael Litman on 5/5/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class DiscoveryVC: UIViewController
{
    var discoveryList : DiscoveryList!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier != nil)
        {
            if(segue.identifier! == "Discovery List")
            {
                self.discoveryList = segue.destinationViewController as! DiscoveryList
            }
            else if(segue.identifier! == "Filter")
            {
                let vc = segue.destinationViewController as! DiscoveryFilterVC
                vc.discoveryList = self.discoveryList
            }
        }

    }
    

}
