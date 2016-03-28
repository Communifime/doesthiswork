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
    @IBOutlet weak var newEmailpasswordTF: UITextField!
    @IBOutlet weak var newPasswordpasswordTF: UITextField!
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
    
    @IBAction func logoutButtonPressed(sender: AnyObject)
    {
        Core.fireBaseRef.unauth()
        let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginVC")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
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
        else if(self.newEmailpasswordTF.text?.characters.count == 0)
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

    func validateUpdatePasswordForm() -> Bool
    {
        var errorMessage = ""
        if(self.newPasswordTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter a new password"
        }
        else if(self.confirmNewPasswordTF.text?.characters.count == 0)
        {
            errorMessage = "You must confirm the new password"
        }
        else if(self.newPasswordTF.text! != self.confirmNewPasswordTF.text!)
        {
            errorMessage = "The passwords must match"
        }
        else if(self.newPasswordpasswordTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter your password"
        }
        else if(self.newPasswordpasswordTF.text! == self.newPasswordTF.text!)
        {
            errorMessage = "New password matches the old password"
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
            let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to update your email?", preferredStyle: .Alert)
            let yesAction = UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction) in
                let ref = Core.fireBaseRef
                ref.changeEmailForUser(self.currentEmailLabel.text!, password: self.newEmailpasswordTF.text!,
                    toNewEmail: self.newEmailTF.text!, withCompletionBlock: { error in
                        if error != nil
                        {
                            self.errorTextView.text = error.localizedDescription
                            self.errorTextView.textColor = UIColor.redColor()
                        }
                        else
                        {
                            //re-authenticate so the update email is available
                            Core.fireBaseRef.authUser(self.newEmailTF.text!, password: self.newEmailpasswordTF.text, withCompletionBlock: { error, authData in
                                if(error == nil)
                                {
                                    self.currentEmailLabel.text = self.newEmailTF.text!
                                    self.newEmailTF.text = ""
                                    self.confirmNewEmailTF.text = ""
                                    self.newEmailpasswordTF.text = ""
                                    let successAlert = UIAlertController(title: "Success", message: "Your email has been successfully updated", preferredStyle: .Alert)
                                    let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                                    successAlert.addAction(okAction)
                                    self.presentViewController(successAlert, animated: true, completion: nil)
                                }
                                else
                                {
                                    /*
                                     should never happen if the previous worked, but just 
                                     in case there is a network outage between the two 
                                     calls this is to be safe.
                                     */
                                    let errorAlert = UIAlertController(title: "Failure", message: "Your email has been successfully updated, but re-authentication failed, please logout and log back in to finish the update.", preferredStyle: .Alert)
                                    let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: { (action: UIAlertAction) in
                                        Core.fireBaseRef.unauth()
                                        self.dismissViewControllerAnimated(true, completion: nil)
                                    })
                                    errorAlert.addAction(okAction)
                                    self.presentViewController(errorAlert, animated: true, completion: nil)
                                }
                            })
                            
                        }
                })
            })
            let noAction = UIAlertAction(title: "No", style: .Cancel, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func updatePasswordButtonPressed(sender: AnyObject)
    {
        if(self.validateUpdatePasswordForm())
        {
            let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to update your password?", preferredStyle: .Alert)
            let yesAction = UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction) in
                let ref = Core.fireBaseRef
                ref.changePasswordForUser(self.currentEmailLabel.text!, fromOld: self.newPasswordpasswordTF.text!, toNew: self.newPasswordTF.text!, withCompletionBlock: { (error:NSError!) in
                    if error != nil
                    {
                        self.errorTextView.text = error.localizedDescription
                        self.errorTextView.textColor = UIColor.redColor()
                    }
                    else
                    {
                        self.currentEmailLabel.text = self.newEmailTF.text!
                        self.newPasswordTF.text = ""
                        self.confirmNewPasswordTF.text = ""
                        self.newPasswordpasswordTF.text = ""
                        let successAlert = UIAlertController(title: "Success", message: "Your password has been successfully updated", preferredStyle: .Alert)
                        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                        successAlert.addAction(okAction)
                        self.presentViewController(successAlert, animated: true, completion: nil)
                    }
                })
            })
            let noAction = UIAlertAction(title: "No", style: .Cancel, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            self.presentViewController(alert, animated: true, completion: nil)
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
