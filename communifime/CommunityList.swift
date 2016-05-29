//
//  CommunityList.swift
//  communifime
//
//  Created by Michael Litman on 4/25/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CommunityList: UITableViewController
{
    var data = [Community]()
    var permissions = [CommunityPermissions]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Core.allCommunities.removeAll()
        let ref = Core.fireBaseRef.child("communities")
        ref.observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot!) in
            if(!(snapshot.value is NSNull))
            {
                let temp = snapshot.value as! NSDictionary
                for datum in temp
                {
                    let aCommunity = Community()
                    aCommunity.key = datum.key as! String
                    aCommunity.ref = aCommunity.ref.child(aCommunity.key)
                    aCommunity.name = datum.value["name"] as! String
                    aCommunity.communityDescription = datum.value["description"] as! String
                    aCommunity.imageName = datum.value["imageName"] as! String
                    aCommunity.admin = datum.value["admin"] as! String
                    if((datum.value as! NSDictionary)["members"] != nil)
                    {
                        let members = (datum.value as! NSDictionary)["members"] as! NSDictionary
                        
                        for member in members
                        {
                            aCommunity.addMember(member.key as! String, name: (member.value as! NSDictionary)["name"] as! String)
                        }
                    }
                    
                    if((datum.value as! NSDictionary)["sub_communities"] != nil)
                    {
                        let subs = datum.value["sub_communities"] as! NSDictionary
                        aCommunity.loadSubCommunities(subs)
                    }
                    Core.allCommunities.append(aCommunity)
                    
                }
            }
        }
    }

    func updateList()
    {
        data.removeAll()
        Core.myCommunities.removeAll()
        permissions.removeAll()
        let uid = FIRAuth.auth()!.currentUser!.uid
        for c in Core.allCommunities
        {
            if(c.hasMember(uid) ||
                c.admin == uid)
            {
                self.data.append(c)
                Core.myCommunities.append(c)
                let perm = Core.getPermissionFromCache(c)
                self.permissions.append(perm!)
            }
        }
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
        return data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let community = self.data[indexPath.row]
        cell.textLabel?.text = community.name
        //cell.detailTextLabel?.text = "admin - \(community.admin)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CommunityTabBarVC") as! CommunityTabBarVC
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
