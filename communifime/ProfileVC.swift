//
//  ProfileVC.swift
//  communifime
//
//  Created by Michael Litman on 4/1/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileSV: ProfileScrollView!
    @IBOutlet weak var profileImageButton: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.profileImageButton.maskAsCircle()
        Core.currentUserProfile.fillScrollView(profileSV)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier != nil)
        {
            if(segue.identifier == "Set Profile Image")
            {
                let vc = segue.destinationViewController as! GetImageVC
                vc.buttonForImage = self.profileImageButton
            }
        }
    }
    

}
