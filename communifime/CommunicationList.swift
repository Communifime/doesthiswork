//
//  CommunicationList.swift
//  communifime
//
//  Created by Michael Litman on 5/16/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommunicationList: UITableViewController
{
    var data = [String : [String: String]]()
    var keys = [String]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let ref = Core.fireBaseRef.child("inMail").child(Core.currentUserProfile.uid).child("inbox")
        ref.observeEventType(.ChildAdded) { (snapshot: FIRDataSnapshot!) in
            self.data[snapshot.key] = snapshot.value as? [String:String]
            self.keys.append(snapshot.key)
            self.tableView.reloadData()
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
        return self.keys.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let message = self.data[self.keys[indexPath.row]]!
        cell.textLabel?.text = message["subject"]!
        cell.detailTextLabel?.text = "from: \(message["fromName"]!)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let message = self.data[self.keys[indexPath.row]]!
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("SendInMailVC") as! SendInMailVC
        vc.toName = "\(Core.currentUserProfile.firstName) \(Core.currentUserProfile.lastName)"
        vc.fromUID = message["fromUID"]!
        vc.readOnlyMode = true
        vc.currMessage = message
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