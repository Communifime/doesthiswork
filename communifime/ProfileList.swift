//
//  ProfileList.swift
//  communifime
//
//  Created by Michael Litman on 4/9/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ProfileList: UITableViewController
{
    var data : [[FormPair]]!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool)
    {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.data.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0)
        {
            return "Personal Data"
        }
        else if(section == 1)
        {
            return "Work Data"
        }
        else if(section == 2)
        {
            return "Education Data"
        }
        else if(section == 3)
        {
            return "Family Data"
        }
        else
        {
            return "UNKNOWN"
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data[section].count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let type = self.data[indexPath.section][indexPath.row].type
        if(type == "Text")
        {
            return 44.0
        }
        else if(type == "Address")
        {
            return 110.0
        }
        else
        {
            return 44.0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let type = self.data[indexPath.section][indexPath.row].type
        if(type == "Text")
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("text", forIndexPath: indexPath) as! ProfileTextCell
            cell.tf.placeholder = self.data[indexPath.section][indexPath.row].name
            cell.tf.text = self.data[indexPath.section][indexPath.row].value as? String
            return cell
        }
        else if(type == "Address")
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("address", forIndexPath: indexPath) as! ProfileAddressCell
            cell.addressNameLabel.text = self.data[indexPath.section][indexPath.row].name
            cell.address = self.data[indexPath.section][indexPath.row].value as? Address
            cell.updateAddress()
            cell.accessoryType = .DisclosureIndicator
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("pairlist", forIndexPath: indexPath) as! ProfilePairListCell
            let data = self.data[indexPath.section][indexPath.row].value as? [Pair]
            cell.textLabel?.text = "\(self.data[indexPath.section][indexPath.row].name) - List (\(data!.count))"
            cell.data = data
            cell.accessoryType = .DisclosureIndicator
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let type = self.data[indexPath.section][indexPath.row].type
        if(type == "Address")
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ManageAddressVC") as! ManageAddressVC
            vc.addressCell = tableView.cellForRowAtIndexPath(indexPath) as! ProfileAddressCell
            vc.addressName = self.data[indexPath.section][indexPath.row].name
            self.presentViewController(vc, animated: true, completion: nil)
        }
        else if(type == "PairList")
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PairList") as! PairList
            vc.parentCell = tableView.cellForRowAtIndexPath(indexPath) as! ProfilePairListCell
            vc.parentVC = self
            vc.data = vc.parentCell.data
            vc.formPair = self.data[indexPath.section][indexPath.row]
            vc.varName = self.data[indexPath.section][indexPath.row].name
            self.presentViewController(vc, animated: true, completion: nil)
        }
        else if(type == "FamilyList")
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("FamilyList") as! FamilyList
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
