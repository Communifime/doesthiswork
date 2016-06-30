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
    var discoveryCollection : DiscoveryCollection!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func resetFilterButtonPressed(sender: AnyObject)
    {
        self.discoveryCollection.currentFilter.removeAll()
        self.discoveryCollection.applyFilter(self.discoveryCollection.currentFilter)
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
            if(segue.identifier! == "Discovery Collection")
            {
                self.discoveryCollection = segue.destinationViewController as! DiscoveryCollection
            }
            else if(segue.identifier! == "Filter")
            {
                let vc = segue.destinationViewController as! DiscoveryFilterVC
                vc.discoveryCollection = self.discoveryCollection
            }
        }
    }
}
