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
    var data = [UserProfile]()
    var profiles = [UserProfile]()
    var familyMembers = [String: [FamilyMember]]()
    var uids : [String]!
    var loaded = false
    var loadCount = 0
    var mode = "ALL"
    var memberPos = 0
    var familyMemberPos = 0
    
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

    func profileLoaded()
    {
        loadCount += 1
        if(loadCount == self.uids.count)
        {
            //all profiles are loaded, so family members are available
            self.loaded = true
            self.data = self.profiles
            for profile in self.data
            {
                self.familyMembers[profile.uid] = profile.familyMembers
            }
            memberPos = 0
            familyMemberPos = 0
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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var familyMemberCount = 0
        if(self.mode == "ALL")
        {
            for familyMembers in self.familyMembers
            {
                familyMemberCount += familyMembers.1.count
            }
        }
        return self.data.count + familyMemberCount
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let profile = self.data[self.memberPos]
        if(self.familyMemberPos == 0)
        {
            //show the member
            cell.indentationLevel = 0
            cell.textLabel?.text = "\(profile.firstName) \(profile.lastName)"
            cell.detailTextLabel?.text = "(member)"
            self.familyMemberPos += 1
            
            //move to next member if there are no family members
            if(self.familyMembers[profile.uid]!.count == 0)
            {
                self.memberPos += 1
                self.familyMemberPos = 0
            }
        }
        else
        {
            //show indented family members
            cell.indentationLevel = 2
            let familyMember = self.familyMembers[profile.uid]![self.familyMemberPos-1]
            cell.textLabel?.text = "\(familyMember.firstName) \(familyMember.lastName)"
            if(familyMember is SpouseFamilyMember)
            {
                cell.detailTextLabel?.text = "(spouse)"
            }
            else
            {
                cell.detailTextLabel?.text = "(child)"
            }
            if(self.familyMemberPos == self.familyMembers[profile.uid]!.count)
            {
                self.familyMemberPos = 0
                self.memberPos += 1
            }
            else
            {
                self.familyMemberPos += 1
            }
        }
        
        return cell
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
