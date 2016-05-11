//
//  DiscoveryList.swift
//  communifime
//
//  Created by Michael Litman on 5/5/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class DiscoveryList: UITableViewController
{
    var data = [Community : [UserProfile]]()
    var filtered_data : [Community : [UserProfile]]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(profileUpdatedNotification), name: "Profile Data Loaded", object: nil)
        
        for community in Core.myCommunities
        {
            data[community] = [UserProfile]()
            for member in community.members
            {
                 data[community]!.append(UserProfile(uid: member.0))
            }
        }
        self.applyFilter([:])
    }

    func profileUpdatedNotification()
    {
        self.tableView.reloadData()
    }
    
    func applyFilter(filter: [String: String])
    {
        self.filtered_data = self.data
        for entry in self.data
        {
            for profile in entry.1
            {
                for pair in filter
                {
                    if(pair.0 == "Name" && !"\(profile.firstName) \(profile.lastName)".containsString(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Email" && !profile.hasEmailContaining(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Address" && !profile.hasAddressContaining(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Phone" && !profile.hasPhoneContaining(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Company" && !profile.company.containsString(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Position" && !profile.position.containsString(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "College" && !profile.hasCollegeContaining(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "High School" && !profile.highSchool.containsString(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Hometown" && !profile.hometown.containsString(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Gender" && profile.gender != pair.1)
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Hair Length" && profile.hairLength != pair.1)
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Eye Color" && profile.eyeColor != pair.1)
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Birth Date" && !profile.hasBirthDate(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Name" && !profile.hasFamilyMemberNamed(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Grade" && !profile.hasFamilyMemberInGrade(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Company" && !profile.hasFamilyMemberInCompany(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Position" && !profile.hasFamilyMemberWithPosition(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Birth Date" && !profile.hasFamilyMemberWithBirthday(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                }
            }
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return Core.myCommunities[section].name
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Core.myCommunities.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.filtered_data[Core.myCommunities[section]]!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let community = Core.myCommunities[indexPath.section]
        let profile = self.filtered_data[community]![indexPath.row]
        cell.textLabel?.text = "\(profile.firstName) \(profile.lastName)"
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileVC") as! ProfileVC
        let community = Core.myCommunities[indexPath.section]
        let profile = self.filtered_data[community]![indexPath.row]
        vc.profile = profile
        vc.readOnly = true
        self.presentViewController(vc, animated: true, completion: nil)
        
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

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
    }
    */

}
