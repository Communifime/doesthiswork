//
//  PairList.swift
//  communifime
//
//  Created by Michael Litman on 4/6/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import CGLMail

class PairList: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!

    @IBOutlet weak var addButton: UIButton!
    var type = "type"
    var parentCell : ProfilePairListCell!
    var parentVC : ProfileList!
    var data : [Pair]!
    var varName : String!
    var formPair : FormPair!
    var readOnly = false
    
    //used for phone and email lists for family members
    var familyMember : SpouseFamilyMember?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(self.readOnly)
        {
            self.addButton.hidden = true
        }
        navBar.topItem?.title = self.varName
    }
    
    @IBAction func addButtonPressed(sender: AnyObject)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ManagePairVC") as! ManagePairVC
        vc.parentPairList = self
        vc.varName = self.varName
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(sender : AnyObject)
    {
        if(self.readOnly)
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            if(self.familyMember == nil)
            {
                self.formPair.value = self.data
                self.parentVC.profile.setValue(self.formPair.name, value: self.data)
            }
            else
            {
                //do the stuff for the Family list page
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func hasLabel(name: String) -> Bool
    {
        for pair in self.data
        {
            if(pair.name == name)
            {
                return true
            }
        }
        return false
    }
    
    func removePair(pair : Pair)
    {
        let pos = self.data.indexOf(pair)
        self.data.removeAtIndex(pos!)
        self.syncProfile()
        self.tableView.reloadData()
    }
    
    func syncProfile()
    {
        let varName = self.formPair.name
        if(varName == "emails")
        {
            self.parentVC.profile.emails = self.data
        }
        else if(varName == "phone numbers")
        {
            self.parentVC.profile.phoneNumbers = self.data
        }
        else if(varName == "colleges")
        {
            self.parentVC.profile.colleges = self.data
        }

    }
    func addPair(name: String, value: String)
    {
        let p = Pair(name: name, value: value)
        self.data.append(p)
        if(self.familyMember == nil)
        {
            self.formPair.value = self.data
            self.syncProfile()
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
        if(self.readOnly && varName != "emails")
        {
            cell.userInteractionEnabled = false
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if(self.readOnly && varName == "emails")
        {
            let commPerm = Core.getCommunicationSettings(self.parentVC.profile.uid)
            if(commPerm == "Email" || commPerm == "Both")
            {
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                let vc = CGLMailHelper.mailViewControllerWithRecipients([(cell?.detailTextLabel?.text!)!], subject: "", message: "", isHTML: false, includeAppInfo: false, completion: nil)
                self.presentViewController(vc, animated: true, completion: nil)
            }
        }
        else
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ManagePairVC") as! ManagePairVC
            vc.parentPairList = self
            vc.varName = self.varName
            vc.editMode = true
            vc.editPair = self.data[indexPath.row]
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
