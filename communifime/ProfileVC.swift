//
//  ProfileVC.swift
//  communifime
//
//  Created by Michael Litman on 4/1/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController
{
    
    @IBOutlet weak var sendInMailButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var profileSavedButton: UIButton!
    @IBOutlet weak var profileImageButton: UIButton!
    var profileList : ProfileList!
    var profile = Core.currentUserProfile
    var readOnly = false
    var fullView = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.sendInMailButton.hidden = true
        if(readOnly)
        {
            let commPerms = Core.getCommunicationSettings(self.profile.uid)
            if(commPerms == "In-Mail" || commPerms == "Both")
            {
                self.sendInMailButton.hidden = false
            }
            self.saveButton.setTitle("done", forState: .Normal)
            self.saveButton.setTitle("done", forState: .Selected)
            self.saveButton.setTitle("done", forState: .Highlighted)
            self.profileImageButton.userInteractionEnabled = false
        }
        
        self.profileSavedButton.alpha = 0.0
        self.profileImageButton.maskAsCircle()
        if(self.profile.imageName != "")
        {
            Core.getImage(self.profileImageButton, imageContainer: self.profile, isProfile: true)
        }
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        if(self.readOnly)
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            self.profile.save(self.profileSavedButton, currProfileImage: self.profileImageButton.currentBackgroundImage!)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "Set Profile Image")
        {
            let vc = segue.destinationViewController as! GetImageVC
            if(self.profile.imageName != "")
            {
                vc.currImage = self.profileImageButton.currentBackgroundImage
            }
            vc.buttonForImage = self.profileImageButton
        }
        else if(segue.identifier == "ProfileList")
        {
            self.profileList = segue.destinationViewController as! ProfileList
            self.profileList.data = self.profile.getFormObjects()
            self.profileList.readOnly = self.readOnly
            self.profileList.fullView = self.fullView
            self.profileList.profile = self.profile
        }
        else if(segue.identifier == "Send In-Mail")
        {
            let vc = segue.destinationViewController as! SendInMailVC
            vc.toUID = self.profile.uid
            vc.toName = "\(self.profile.firstName) \(self.profile.lastName)"
        }
    }
    

}
