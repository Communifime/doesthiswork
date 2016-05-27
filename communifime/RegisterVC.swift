//
//  RegisterVC.swift
//  communifime
//
//  Created by Michael Litman on 3/26/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterVC: UIViewController
{
    @IBOutlet weak var errorTextView: UITextView!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var confirmEmailTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //empty error text by default
        self.errorTextView.text = ""
    }

    func validateForm() -> Bool
    {
        var errorMessage = ""
        if(self.emailTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter an email address"
        }
        else if(!Core.isValidEmail(self.emailTF.text!))
        {
            errorMessage = "You must enter an valid email address"
        }
        else if(self.confirmEmailTF.text?.characters.count == 0)
        {
            errorMessage = "You must confirm the email address"
        }
        else if(self.passwordTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter a password"
        }
        else if(self.confirmPasswordTF.text?.characters.count == 0)
        {
            errorMessage = "You must confirm the password"
        }
        else if(self.passwordTF.text! != self.confirmPasswordTF.text!)
        {
            errorMessage = "Passwords do not match"
        }
        else if(self.emailTF.text! != self.confirmEmailTF.text!)
        {
            errorMessage = "Email addresses do not match"
        }
        else if(self.firstNameTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter a first name"
        }
        else if(self.lastNameTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter a last name"
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
    
    @IBAction func createButtonPressed(sendar : AnyObject)
    {
        if(self.validateForm())
        {
            FIRAuth.auth()?.createUserWithEmail(self.emailTF.text!, password: self.passwordTF.text!, completion: { (user: FIRUser?, error: NSError?) in
                if error != nil
                {
                    // There was an error creating the account
                    self.errorTextView.text = error!.localizedDescription
                    self.errorTextView.textColor = UIColor.redColor()
                }
                else
                {
                    FIRAuth.auth()?.signInWithEmail(self.emailTF.text!, password: self.passwordTF.text!, completion: { (user: FIRUser?, error: NSError?) in
                        let profile = UserProfile(uid: (FIRAuth.auth()?.currentUser?.uid)!)
                        profile.firstName = self.firstNameTF.text!
                        profile.lastName = self.lastNameTF.text!
                        let p = Pair(name: "primary email", value: self.emailTF.text!)
                        profile.emails.append(p)
                        profile.save(nil, currProfileImage: nil)
                        Core.currentUserProfile = profile
                        Core.addPermissionToCache()
                        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController")
                        self.presentViewController(vc!, animated: true, completion: nil)
                    })
                }

            })
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
