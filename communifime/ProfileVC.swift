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
        let f = CGRectMake(0, 0, self.view.getWidth(), self.profileSV.getHeight())
        self.profileSV.stackView = UIStackView(frame: f)
        self.profileSV.stackView.spacing = 5.0
        self.profileSV.stackView.distribution = .FillProportionally
        self.profileSV.stackView.axis = .Vertical
        self.profileSV.stackView.alignment = .Fill
        
        self.profileSV.addSubview(self.profileSV.stackView)
        Core.currentUserProfile.fillScrollView(profileSV)
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool)
    {
        self.profileSV.setNeedsDisplay()
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
