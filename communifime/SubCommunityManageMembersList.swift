//
//  SubCommunityManageMembersList.swift
//  communifime
//
//  Created by Michael Litman on 5/4/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class SubCommunityManageMembersList: UITableViewController
{
    var community : Community!
    var names = [String]()
    var uids = [String]()
    var selected = [Bool]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //fill data with the members of the parent community
        //that are not already members of this community
        let parentMembers = self.community.parentCommunity?.members
        for pm in parentMembers!
        {
            if(!self.community.hasMember(pm.0))
            {
                self.uids.append(pm.0)
                self.names.append(pm.1)
                self.selected.append(false)
            }
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return self.names.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        if(self.selected[indexPath.row])
        {
            cell.accessoryType = .Checkmark
        }
        else
        {
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if(self.selected[indexPath.row])
        {
            self.selected[indexPath.row] = false
            cell?.accessoryType = .None
        }
        else
        {
            self.selected[indexPath.row] = true
            cell?.accessoryType = .Checkmark
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
