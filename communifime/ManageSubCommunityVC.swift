//
//  ManageSubCommunityVC.swift
//  communifime
//
//  Created by Michael Litman on 4/28/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ManageSubCommunityVC: UIViewController
{
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var errorTV: UITextView!
    
    var community : Community!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.savedLabel.alpha = 0.0
        self.errorTV.hidden = true
        // Do any additional setup after loading the view.
    }

    func validateForm() -> Bool
    {
        var msg = ""
        if(self.nameTF.text! == "")
        {
            msg = "You must enter a sub-community name"
        }
        else if(self.descriptionTV.text! == "")
        {
            msg = "You must enter a sub-community description. This will be used by the admin for approval."
        }
        else if(self.community.hasSubCommunityWithName(self.nameTF.text!))
        {
            msg = "A sub-community with that name already exists"
        }
        
        if(msg != "")
        {
            self.errorTV.text = msg
            self.errorTV.textColor = UIColor.redColor()
            self.errorTV.hidden = false
            return false
        }
        self.errorTV.text = ""
        self.errorTV.hidden = true
        return true
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        if(self.validateForm())
        {
            let newCom = Community()
            newCom.name = self.nameTF.text!
            newCom.communityDescription = self.descriptionTV.text
            newCom.admin = Core.fireBaseRef.authData.uid
            newCom.imageName = self.community.imageName
            self.community.addSubCommunity(newCom, savedLabel: self.savedLabel)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
