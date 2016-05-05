//
//  SubCommunityManageMembersVC.swift
//  communifime
//
//  Created by Michael Litman on 5/4/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class SubCommunityManageMembersVC: UIViewController
{
    var community : Community!
    var memberList : SubCommunityManageMembersList!
    
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
        if(segue.identifier != nil && segue.identifier == "MembersList")
        {
            let vc = segue.destinationViewController as! SubCommunityManageMembersList
            vc.community = self.community
            self.memberList = vc
        }
    }
    

}
