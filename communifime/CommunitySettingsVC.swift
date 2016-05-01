//
//  CommunitySettingsVC.swift
//  communifime
//
//  Created by Michael Litman on 4/27/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class CommunitySettingsVC: UIViewController,UITextFieldDelegate
{
    
    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var contactSegments: UISegmentedControl!
    @IBOutlet weak var infoShareSegments: UISegmentedControl!
    @IBOutlet weak var adminButton: UIButton!
    
    var community : Community!
    var perms : CommunityPermissions!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.community = (self.tabBarController as! CommunityTabBarVC).community
        self.savedLabel.alpha = 0.0
        self.perms = Core.getPermissionFromCache(self.community)
        if(perms.infoShare == "full")
        {
            self.infoShareSegments.selectedSegmentIndex = 1
        }
        
        if(perms.contact == "email")
        {
            self.contactSegments.selectedSegmentIndex = 1
        }
        else if(perms.contact == "both")
        {
            self.contactSegments.selectedSegmentIndex = 2
        }
        
        if(self.community.admin == Core.fireBaseRef.authData.uid)
        {
            self.adminButton.hidden = false
        }
        else
        {
            self.adminButton.hidden = false
        }
    }

    @IBAction func saveButtonPressed(sender: UIButton)
    {
        var infoShare = "partial"
        if(self.infoShareSegments.selectedSegmentIndex == 1)
        {
            infoShare = "full"
        }
        
        var contact = "both"
        if(self.contactSegments.selectedSegmentIndex == 0)
        {
            contact = "in-mail"
        }
        else if(self.contactSegments.selectedSegmentIndex == 1)
        {
            contact = "email"
        }
        perms.infoShare = infoShare
        perms.contact = contact
        perms.save(self.savedLabel)
    }
    
    @IBAction func adminSettingsButtonPressed(sender : UIButton)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CommunityAdminSettingsVC") as! CommunityAdminSettingsVC
        vc.community = self.community
        self.presentViewController(vc, animated: true, completion: nil)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
    }
    */
    

}
