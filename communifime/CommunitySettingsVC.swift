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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let ref = Core.fireBaseRef.childByAppendingPath("communities").childByAppendingPath(self.community.key).childByAppendingPath("members").childByAppendingPath(Core.fireBaseRef.authData.uid)
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
        ADD stuff here!
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
