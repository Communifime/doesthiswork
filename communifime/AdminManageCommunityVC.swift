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
            else
            {
                //this is a new community, make sure they selected an admin
                if(self.adminList.selectedIndex == -1)
                {
                    let alert = UIAlertController(title: "Error", message: "You must select an admin for the community", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) in
                        
                    })
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else
                {
                    var community = [String: AnyObject]()
                    community["admin"] = self.adminList.uids[self.adminList.selectedIndex]
                    community["approved"] = false
                    community["description"] = ""
                    community["imageName"] = ""
                    let obj = self.adminList.data[self.adminList.selectedIndex]
                    let name = "\(obj["First Name"]!) \(obj["Last Name"]!)"
                    let admin = community["admin"] as! String
                    let members = [admin : ["name" : name]]
                    community["members"] = members
                    community["name"] = self.communityName.text!
                    let date = NSDate()
                    let hashableString = NSString(format: "%f", date.timeIntervalSinceReferenceDate)
                    let hashString = hashableString.aws_md5String()
                    community["password"] = hashString.substringToIndex(hashString.startIndex.advancedBy(5))
                    let ref = Core.fireBaseRef.child("communities").childByAutoId()
                    ref.setValue(community)
                    
                    let permRef = Core.fireBaseRef.child("community_permissions").child(admin).child(ref.key)
                    let perms = ["contact":"in-mail","infoShare":"partial"]
                    permRef.setValue(perms)
                    Core.addPermissionToCache()
                    Core.getAllPerms()

                    Core.adminCommunityList.loadTableData()
                    Core.communityList.getCommunities()
                    Core.communityList.updateList()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
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
