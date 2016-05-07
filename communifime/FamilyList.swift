//
//  FamilyList.swift
//  communifime
//
//  Created by Michael Litman on 4/10/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class FamilyList: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var data : [FamilyMember]!
    var parentCell : ProfilePairListCell!
    var parentVC : ProfileList!
    var formPair : FormPair!
    var readOnly = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(readOnly)
        {
            self.addButton.hidden = true
        }
    }
    
    func addFamilyMember(member: FamilyMember)
    {
        self.data.append(member)
        self.tableView.reloadData()
        self.parentVC.tableView.reloadData()
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject)
    {
        self.formPair.value = self.data
        self.parentVC.profile.familyMembers = self.data
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButtonPressed(sender: AnyObject)
    {
        let vc = UIAlertController(title: "Create New", message: "Which type of family member?", preferredStyle: .ActionSheet)
        let spouseAction = UIAlertAction(title: "Spouse", style: .Default) { (action) in
            //show the create spouse VC
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ManageSpouseVC") as! ManageSpouseVC
            vc.parentFamilyList = self
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
        let childAction = UIAlertAction(title: "Child", style: .Default) { (action) in
            //show the create child VC
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ManageChildVC") as! ManageChildVC
            vc.parentFamilyList = self
            self.presentViewController(vc, animated: true, completion: nil)

        }
        vc.addAction(spouseAction)
        vc.addAction(childAction)
        self.presentViewController(vc, animated: true, completion: nil)
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
        let member = self.data[indexPath.row]
        
        cell.textLabel?.text = "\(member.firstName) \(member.lastName)"
        cell.detailTextLabel?.text = member.relationship
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let member = self.data[indexPath.row]
        if(member is SpouseFamilyMember)
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ManageSpouseVC") as! ManageSpouseVC
            vc.parentFamilyList = self
            vc.spouse = member as! SpouseFamilyMember
            vc.editMode = true
            vc.readOnly = self.readOnly
            self.presentViewController(vc, animated: true, completion: nil)
        }
        else
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ManageChildVC") as! ManageChildVC
            vc.parentFamilyList = self
            vc.child = member as! ChildFamilyMember
            vc.editMode = true
            vc.readOnly = self.readOnly
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
