//
//  PairList.swift
//  communifime
//
//  Created by Michael Litman on 4/6/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class PairList: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!

    var type = "type"
    var parentCell : ProfilePairListCell!
    var parentVC : ProfileList!
    var data : [Pair]!
    var varName : String!
    var formPair : FormPair!
    var familyMember : SpouseFamilyMember?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navBar.topItem?.title = self.varName
    }
    
    @IBAction func addButtonPressed(sender: AnyObject)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ManagePairVC") as! ManagePairVC
        vc.parentPairList = self
        vc.varName = self.varName
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func addPair(name: String, value: String)
    {
        let p = Pair(name: name, value: value)
        self.data.append(p)
        if(self.familyMember == nil)
        {
            self.formPair.value = self.data
            self.parentVC.tableView.reloadData()
        }
        else
        {
            if(self.varName == "Email Addresses")
            {
                self.familyMember?.emails = self.data
            }
            else
            {
                self.familyMember?.phoneNumbers = self.data
            }
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let p = self.data[indexPath.row]
        cell.textLabel?.text = p.name
        cell.detailTextLabel?.text = p.value
        cell.accessoryType = .DisclosureIndicator
        cell.editing = true
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ManagePairVC") as! ManagePairVC
        vc.parentPairList = self
        vc.varName = self.varName
        vc.editMode = true
        vc.editPair = self.data[indexPath.row]
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
