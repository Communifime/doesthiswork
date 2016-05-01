//
//  SubCommunityApprovalList.swift
//  communifime
//
//  Created by Michael Litman on 5/1/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class SubCommunityApprovalList: UITableViewController
{
    var community : Community!
    var data = [Community]()
    var selected = [Bool]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.fillData()
    }

    func fillData()
    {
        self.data.removeAll()
        self.selected.removeAll()
        for c in self.community.subCommunities
        {
            if(!c.approved)
            {
                self.data.append(c)
                self.selected.append(false)
            }
        }
    }
    
    func approveSelected()
    {
        var pos = 0
        for c in self.data
        {
            if(self.selected[pos])
            {
                c.updateApprovedAndStore(true)
            }
            pos += 1
        }
        self.fillData()
        self.tableView.reloadData()
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
        return self.data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let c = self.data[indexPath.row]
        cell.textLabel?.text = c.name
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
