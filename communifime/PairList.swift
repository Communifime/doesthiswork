//
//  PairList.swift
//  communifime
//
//  Created by Michael Litman on 4/6/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class PairList: UITableViewController
{
    var pairs : [Pair]!
    var type = "type"
    var profileSV : ProfileScrollView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.pairs = [Pair]()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func addPair(name: String, value: String)
    {
        let p = Pair(name: name, value: value)
        self.pairs.append(p)
        self.tableView.reloadData()
        
        //refresh the profile scrollview to take 
        //this new change into account
        //self.profileSV.refresh()
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
        return self.pairs.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        if((indexPath.row - self.pairs.count) == 0)
        {
            cell.textLabel?.text = "Add New \(self.type)"
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(16)
            cell.detailTextLabel?.text = ""
        }
        else
        {
            let p = self.pairs[indexPath.row]
            cell.textLabel?.text = p.name
            cell.detailTextLabel?.text = p.value
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if((indexPath.row - self.pairs.count) == 0)
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ManagePairVC") as! ManagePairVC
            vc.parentPairList = self
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