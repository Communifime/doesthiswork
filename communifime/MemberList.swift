//
//  MemberList.swift
//  communifime
//
//  Created by Michael Litman on 6/28/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class MemberList: UITableViewController
{
    var parentMemberListVC : MemberListVC!
    var community : Community!
    var data = [[String : String]]()
    var members = [[String : String]]()
    var familyMembers = [[String : String]]()
    var familyFirst = [[String : String]]()
    var allMembers = [[String : String]]()
    var profiles = [UserProfile]()
    var uids : [String]!
    var loaded = false
    var loadCount = 0
    var mode = "ALL"
    var prevChild = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.parentMemberListVC.spinner.hidden = false
        self.parentMemberListVC.segments.enabled = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(profileLoaded), name: "Profile Data Loaded", object: nil)
        self.uids = Array(community.members.keys)
        for uid in uids
        {
            self.profiles.append(UserProfile(uid: uid))
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func toggleData(mode: String)
    {
        self.mode = mode
        if(self.mode == "ALL")
        {
            self.data = self.allMembers
        }
        else if(self.mode == "MEMBERS")
        {
            self.data = self.members
        }
        else if(self.mode == "FAMILY MEMBERS")
        {
            self.data = self.familyMembers
        }
        else
        {
            self.data = self.familyFirst
        }
        self.tableView.reloadData()
    }
    
    func profileLoaded()
    {
        loadCount += 1
        if(loadCount == self.uids.count)
        {
            //all profiles are loaded, so family members are available
            self.loaded = true
            for profile in self.profiles
            {
                self.members.append(["name":"\(profile.firstName) \(profile.lastName)", "type": "member", "uid":profile.uid, "imageName":profile.imageName])
                self.allMembers.append(["name":"\(profile.firstName) \(profile.lastName)", "type": "member", "uid":profile.uid, "imageName":profile.imageName])
                for fm in profile.familyMembers
                {
                    if(fm is SpouseFamilyMember)
                    {
                        self.allMembers.append(["name":"\(fm.firstName) \(fm.lastName)", "type": "spouse", "imageName":fm.imageName])
                        self.familyMembers.append(["name":"\(fm.firstName) \(fm.lastName)", "type": "spouse", "imageName":fm.imageName])
                        self.familyFirst.append(["name":"\(fm.firstName) \(fm.lastName)", "type": "spouse", "imageName":fm.imageName])
                        self.familyFirst.append(["name":"\(profile.firstName) \(profile.lastName)", "type": "member", "uid":profile.uid, "imageName":profile.imageName])
                    }
                    else
                    {
                        self.allMembers.append(["name":"\(fm.firstName) \(fm.lastName)", "type": "child", "imageName":fm.imageName])
                        self.familyMembers.append(["name":"\(fm.firstName) \(fm.lastName)", "type": "child", "imageName":fm.imageName])
                        self.familyFirst.append(["name":"\(fm.firstName) \(fm.lastName)", "type": "child", "imageName":fm.imageName])
                        self.familyFirst.append(["name":"\(profile.firstName) \(profile.lastName)", "type": "member", "uid":profile.uid, "imageName":profile.imageName])
                    }
                }
            }
            self.data = self.allMembers
            self.tableView.reloadData()
            self.parentMemberListVC.spinner.hidden = true
            self.parentMemberListVC.segments.enabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let info = self.data[indexPath.row]
        let type = info["type"]!
        let name = info["name"]!
        let imageName = info["imageName"]!
        
        if(imageName != "")
        {
            Core.getImage(cell.imageView!, imageName: imageName, isProfile: true)
        }

        if(type == "member" && self.mode == "FAMILY FIRST" && self.prevChild)
        {
            self.prevChild = false
            cell.indentationLevel = 5
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = "member"
            cell.accessoryType = .DisclosureIndicator
        }
        else if(type == "member")
        {
            cell.indentationLevel = 0
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = "member"
            cell.accessoryType = .DisclosureIndicator
        }
        else if((type == "spouse" || type == "child") && self.mode == "ALL")
        {
            self.prevChild = true
            cell.indentationLevel = 5
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = type
            cell.accessoryType = .None
        }
        else
        {
            self.prevChild = true
            cell.indentationLevel = 0
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = type
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let person = self.data[indexPath.row]
        if(person["type"]! == "member")
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileVC") as! ProfileVC
            let uid = person["uid"]!
            for profile in self.profiles
            {
                if(profile.uid == uid)
                {
                    vc.profile = profile
                    vc.fullView = Core.hasFullViewPermission(profile.uid)
                    vc.readOnly = true
                    break
                }
            }
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
