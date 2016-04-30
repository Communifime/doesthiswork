//
//  CommunityVC.swift
//  communifime
//
//  Created by Michael Litman on 4/25/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class CommunityVC: UIViewController
{
    @IBOutlet weak var navBar: UINavigationBar!

    var community : Community!
    
    override func viewDidLoad()
    {
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
        if(self.community == nil)
        {
            self.community = (self.tabBarController as! CommunityTabBarVC).community
            self.navBar.topItem?.title = self.community.name
        }
        
        if(segue.identifier != nil)
        {
            if(segue.identifier! == "Add Sub-Community")
            {
                let vc = segue.destinationViewController as! ManageSubCommunityVC
                vc.community = self.community
            }
            else if(segue.identifier! == "SubCommunityList")
            {
                let vc = segue.destinationViewController as! SubCommunityList
                vc.community = self.community
            }
        }
    }
    

}
