//
//  NewAddressVC.swift
//  communifime
//
//  Created by Michael Litman on 4/4/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class NewAddressVC: UIViewController
{
    var parentAddressListTVC : AddressListTVC!
    
    @IBOutlet weak var street1TF: UITextField!
    @IBOutlet weak var street2TF: UITextField!
    
    @IBOutlet weak var cityTF: UITextField!
    
    @IBOutlet weak var stateTF: UITextField!
    
    @IBOutlet weak var zipTF: UITextField!
    @IBOutlet weak var errorTV: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Core.underlineTextField(self.street1TF)
        Core.underlineTextField(self.street2TF)
        Core.underlineTextField(self.cityTF)
        Core.underlineTextField(self.stateTF)
        Core.underlineTextField(self.zipTF)
        self.errorTV.hidden = true
        self.street1TF.becomeFirstResponder()
    }

    func validateForm() -> Bool
    {
        var errorMessage = ""
        if(self.street1TF.text?.characters.count == 0)
        {
            errorMessage = "You must enter a street address"
        }
        else if(self.cityTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter a city"
        }
        else if(self.stateTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter a state"
        }
        else if(self.zipTF.text?.characters.count == 0)
        {
            errorMessage = "You must enter a zip code"
        }
        
        if(errorMessage == "")
        {
            self.errorTV.text = errorMessage
            self.errorTV.hidden = true
            return true
        }
        else
        {
            self.errorTV.text = errorMessage
            self.errorTV.hidden = false
            return false
        }
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        if(validateForm())
        {
            //save the address and add it to the parent vc
            let address = Address(street1: self.street1TF.text!, street2: self.street2TF.text!, city: self.cityTF.text!, state: self.stateTF.text!, zip: self.zipTF.text!)
            self.parentAddressListTVC.addAddress(address)
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
