//
//  MemberListVC.swift
//  communifime
//
//  Created by Michael Litman on 6/28/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class MemberListVC: UIViewController
{
    var memberList : MemberList!
    var community : Community!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var segments: UISegmentedControl!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        spinner.hidden = true
        
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
        self.memberList = segue.destinationViewController as! MemberList
        self.memberList.parentMemberListVC = self
        self.memberList.community = self.community
    }
    

}
