//
//  AdminCommunityList.swift
//  communifime
//
//  Created by Michael Litman on 6/4/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class AdminCommunityList: UITableViewController
{
    var names = [String]()
    var admins = [String]()
    var communityIDs = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadTableData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func loadTableData()
    {
        self.names.removeAll()
        self.admins.removeAll()
        self.communityIDs.removeAll()
        
        let ref = Core.fireBaseRef.child("communities")
        ref.observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot) in
            //print(snapshot)
            let objects = snapshot.value as! NSDictionary
            for obj in objects
            {
                let community = obj.value as! NSDictionary
                let admin = community["admin"] as! String
                let name = community["name"] as! String
                self.names.append(name)
                self.admins.append(admin)
                self.communityIDs.append(obj.key as! String)
                self.tableView.reloadData()
            }
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
        return self.names.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.names[indexPath.row]
        cell.detailTextLabel?.text = self.admins[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("AdminManageCommunityVC") as! AdminManageCommunityVC
        vc.currName = self.names[indexPath.row]
        vc.currAdmin = self.admins[indexPath.row]
        vc.currCommunityID = self.communityIDs[indexPath.row]
        vc.communityList = self
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
