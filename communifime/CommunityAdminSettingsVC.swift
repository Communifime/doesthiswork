//
//  CommunityAdminSettingsVC.swift
//  communifime
//
//  Created by Michael Litman on 4/30/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class CommunityAdminSettingsVC: UIViewController
{
    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var logoImageButton: UIButton!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var communityNameTF: UITextField!
    
    var community : Community!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.savedLabel.alpha = 0.0
        
        self.communityNameTF.text = self.community.name
        self.descriptionTV.text = self.community.communityDescription
        if(self.community.imageName != "")
        {
            Core.getImage(self.logoImageButton, imageContainer: self.community, isProfile: false)
        }
    }

    @IBAction func saveButtonPressed(sender : UIButton)
    {
        self.community.name = self.communityNameTF.text
        self.community.communityDescription = self.descriptionTV.text
        self.community.image = self.logoImageButton.currentBackgroundImage
        self.community.save(self.savedLabel)
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
        else if(segue.identifier == "Approve Sub-Communities")
        {
            let vc = segue.destinationViewController as! SubCommunityRequestsVC
            vc.community = self.community
        }
    }
}
