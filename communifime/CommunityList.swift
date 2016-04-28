//
//  CommunityList.swift
//  communifime
//
//  Created by Michael Litman on 4/25/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase

class CommunityList: UITableViewController
{
    var data = [Community]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let ref = Core.fireBaseRef.childByAppendingPath("communities")
        ref.observeSingleEventOfType(.Value) { (snapshot: FDataSnapshot!) in
            let temp = snapshot.value as! NSDictionary
            for datum in temp
            {
                let aCommunity = Community()
                aCommunity.key = datum.key as! String
                aCommunity.name = datum.value["name"] as! String
                aCommunity.communityDescription = datum.value["description"] as! String
                aCommunity.imageName = datum.value["imageName"] as! String
                aCommunity.admin = datum.value["admin"] as! String
                Core.allCommunities.append(aCommunity)
                if(aCommunity.admin != nil && aCommunity.admin == Core.fireBaseRef.authData.uid!)
                {
                    self.data.append(aCommunity)
                    self.tableView.reloadData()
                }
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let community = self.data[indexPath.row]
        cell.textLabel?.text = community.name
        cell.detailTextLabel?.text = "admin - \(community.admin)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CommunityVC") as! CommunityVC
        vc.community = self.data[indexPath.row]
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
