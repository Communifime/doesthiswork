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
    
    @IBOutlet weak var profileProgress: UIProgressView!
    
    @IBOutlet weak var familyProfileProgress: UIProgressView!
    @IBOutlet weak var profileSavedButton: UIButton!
    @IBOutlet weak var profileImageButton: UIButton!
    var profileList : ProfileList!
    var profile = Core.currentUserProfile
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Core.profileProgress = self.profileProgress
        Core.familyProfileProgress = self.familyProfileProgress
        
        self.profileSavedButton.alpha = 0.0
        self.profileImageButton.maskAsCircle()
        Core.getImage(self.profileImageButton, imageContainer: self.profile)
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        self.profile.save(self.profileSavedButton, currProfileImage: self.profileImageButton.currentBackgroundImage!)
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
            vc.buttonForImage = self.profileImageButton
        }
        else if(segue.identifier == "ProfileList")
        {
            self.profileList = segue.destinationViewController as! ProfileList
            self.profileList.data = Core.currentUserProfile.getFormObjects()
            self.profileList.profile = self.profile
        }
    }
    

}
