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
    @IBOutlet weak var profileImageButton: UIButton!
    var profileList : ProfileList!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.profileImageButton.maskAsCircle()
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
        }
    }
    

}
