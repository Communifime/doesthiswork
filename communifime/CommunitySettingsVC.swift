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
    
    @IBOutlet weak var logoImageButton: UIButton!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var communityNameTF: UITextField!
    @IBOutlet weak var contactSegments: UISegmentedControl!
    @IBOutlet weak var infoShareSegments: UISegmentedControl!
    @IBOutlet weak var adminStack: UIStackView!
    
    var community : Community!
    var perms : CommunityPermissions!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.perms = Core.getPermissionsForCommunity(self.community)
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
            adminStack.hidden = false
        }
        else
        {
            adminStack.hidden = true
        }
        self.communityNameTF.text = self.community.name
        self.descriptionTV.text = self.community.communityDescription
        if(self.community.imageName != "")
        {
            Core.getImage(self.logoImageButton, imageContainer: self.community, isProfile: false)
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
        perms.save()
    }
    
    @IBAction func updateSettingsButtonPressed(sender : UIButton)
    {
        self.community.name = self.communityNameTF.text
        self.community.communityDescription = self.descriptionTV.text
        self.community.image = self.logoImageButton.currentBackgroundImage
        self.community.save()
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "Set Logo Image")
        {
            let vc = segue.destinationViewController as! GetImageVC
            vc.buttonForImage = self.logoImageButton
            self.community.imageChanged = true
        }
    }
    

}
