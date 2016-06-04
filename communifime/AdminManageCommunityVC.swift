//
//  AdminManageCommunityVC.swift
//  communifime
//
//  Created by Michael Litman on 6/4/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class AdminManageCommunityVC: UIViewController
{
    @IBOutlet weak var communityName: UITextField!
    var currName = ""
    var currAdmin = ""
    var currCommunityID = ""
    var adminList : AdminCommunityAdminList!
    var communityList : AdminCommunityList!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(currName != "")
        {
            communityName.text = currName
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        if(self.communityName.text == "")
        {
            let alert = UIAlertController(title: "Error", message: "You must enter a community name.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) in
                
            })
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            if(self.currCommunityID != "")
            {
                //this is an existing community, so update the admin and name
                let ref = Core.fireBaseRef.child("communities").child(self.currCommunityID)
                let nameRef = ref.child("name")
                nameRef.setValue(self.communityName.text!)
                let adminRef = ref.child("admin")
                let newAdmin = self.adminList.uids[self.adminList.selectedIndex]
                adminRef.setValue(newAdmin)
                self.communityList.loadTableData()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let vc = segue.destinationViewController as! AdminCommunityAdminList
        vc.currAdmin = self.currAdmin
        self.adminList = vc
    }
    

}
