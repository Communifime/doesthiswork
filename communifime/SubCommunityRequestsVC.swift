//
//  SubCommunityRequestsVC.swift
//  communifime
//
//  Created by Michael Litman on 5/1/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class SubCommunityRequestsVC: UIViewController
{
    var community: Community!
    var approvalList : SubCommunityApprovalList!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func approveCommunities(sender: AnyObject)
    {
        self.approvalList.approveSelected()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "SubCommunityApprovalList")
        {
            let vc = segue.destinationViewController as! SubCommunityApprovalList
            vc.community = self.community
            self.approvalList = vc
        }
    }
    

}
