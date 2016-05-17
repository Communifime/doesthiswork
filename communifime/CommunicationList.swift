//
//  CommunicationList.swift
//  communifime
//
//  Created by Michael Litman on 5/16/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class CommunicationList: UITableViewController
{
    var data = [Community : [UserProfile]]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.data.removeAll()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(profileUpdatedNotification), name: "Profile Data Loaded", object: nil)
        //Let core know about me so I can be removed as an observer upon login
        Core.communicationListObserver = self
        
        for community in Core.myCommunities
        {
            data[community] = [UserProfile]()
            for member in community.members
            {
                if(member.0 == Core.fireBaseRef.authData.uid)
                {
                    continue
                }
                data[community]!.append(UserProfile(uid: member.0))
            }
        }
    }
    
    func profileUpdatedNotification()
    {
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
        return self.data[Core.myCommunities[section]]!.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        // Configure the cell...
        let community = Core.myCommunities[indexPath.section]
        let profile = self.data[community]![indexPath.row]
        cell.textLabel?.text = "\(profile.firstName) \(profile.lastName)"
        cell.accessoryType = .DisclosureIndicator
        cell.detailTextLabel?.text = Core.getCommunicationSettings(profile.uid)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
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