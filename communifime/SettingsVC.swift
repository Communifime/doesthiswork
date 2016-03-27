//
//  SettingsVC.swift
//  communifime
//
//  Created by Michael Litman on 3/27/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var confirmNewPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmNewEmailTF: UITextField!
    @IBOutlet weak var newEmailTF: UITextField!
    @IBOutlet weak var currentEmailLabel: UILabel!
    @IBOutlet weak var errorTextView: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.currentEmailLabel.text = Core.fireBaseRef.authData.providerData["email"]! as? String
        self.errorTextView.text = ""

        // Do any additional setup after loading the view.
    }

    func validateUpdateEmailForm() -> Bool
    {
        var errorMessage = ""
        if(self.newEmailTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter a new email"
        }
        else if(!Core.isValidEmail(self.newEmailTF.text!))
        {
            errorMessage = "You must enter a valid new email"
        }
        else if(self.confirmNewEmailTF.text?.characters.count == 0)
        {
            errorMessage = "You must confirm the new email address"
        }
        else if(self.newEmailTF.text! != self.confirmNewEmailTF.text!)
        {
            errorMessage = "The email addresses must match"
        }
        else if(self.passwordTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter your password"
        }
        else
        {
            self.errorTextView.text = ""
            return true
        }
        self.errorTextView.text = errorMessage
        self.errorTextView.textColor = UIColor.redColor()
        return false
    }

    @IBAction func updateEmailButtonPressed(sender: AnyObject)
    {
        if(self.validateUpdateEmailForm())
        {
            
        }
    }
    
    @IBAction func updatePasswordButtonPressed(sender: AnyObject) {
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
