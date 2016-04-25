//
//  ManageSpouseVC.swift
//  communifime
//
//  Created by Michael Litman on 4/10/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ManageSpouseVC: UIViewController
{

    @IBOutlet weak var sv: UIScrollView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var positionTF: UITextField!
    @IBOutlet weak var errorTV: UITextView!
    @IBOutlet weak var phoneNumbersButton: UIButton!
    @IBOutlet weak var emailsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    var errorHeight = CGFloat(0.0)
    var parentFamilyList : FamilyList!
    var spouse = SpouseFamilyMember()
    var editMode = false
    var initialDataLoaded = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if(self.spouse.imageName != "")
        {
            Core.getImage(self.imageButton, imageContainer: self.spouse)
        }
        spouse.relationship = "spouse"
        self.errorTV.hidden = true
        self.imageButton.maskAsCircle()
        self.firstNameTF.maskWithUnderline()
        self.lastNameTF.maskWithUnderline()
        self.companyTF.maskWithUnderline()
        self.positionTF.maskWithUnderline()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ManageSpouseVC.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ManageSpouseVC.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }

    func setButtonTitles(button : UIButton, theTitle : String)
    {
        button.setTitle(theTitle, forState: .Normal)
        button.setTitle(theTitle, forState: .Selected)
        button.setTitle(theTitle, forState: .Highlighted)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        if(!self.initialDataLoaded)
        {
            if(self.editMode)
            {
                self.setButtonTitles(self.addButton, theTitle: "save")
            }
            self.firstNameTF.text = self.spouse.firstName
            self.lastNameTF.text = self.spouse.lastName
            self.companyTF.text = self.spouse.company
            self.positionTF.text = self.spouse.position
            self.datePicker.date = self.spouse.birthDate
            if(self.spouse.image != nil)
            {
                self.imageButton.setBackgroundImage(self.spouse.image!, forState: .Normal)
                self.imageButton.setBackgroundImage(self.spouse.image!, forState: .Highlighted)
                self.imageButton.setBackgroundImage(self.spouse.image!, forState: .Selected)
            }
            self.initialDataLoaded = true
        }
        self.setButtonTitles(self.emailsButton, theTitle: "emails (\(self.spouse.emails.count))")
        self.setButtonTitles(self.phoneNumbersButton, theTitle: "phone numbers (\(self.spouse.phoneNumbers.count))")
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLayoutSubviews()
    {
        let newSize = CGSizeMake(self.sv.getWidth(), self.sv.contentSize.height)
        sv.contentSize = newSize
    }
    
    //Keyboard Events
    func keyboardWillShow(notification: NSNotification)
    {
        let userInfo = notification.userInfo
        let keyboardSize = (userInfo![UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        let keyboardHeight = keyboardSize!.size.height
        let newSize = CGSizeMake(self.sv.getWidth(), self.sv.getHeight()+keyboardHeight)
        sv.contentSize = newSize
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        let newSize = CGSizeMake(self.sv.getWidth(), self.sv.getHeight())
        sv.contentSize = newSize
    }
    
    @IBAction func addButtonPressed(sender: AnyObject)
    {
        if(self.validateForm())
        {
            //add the child to the family list
            self.spouse.firstName = self.firstNameTF.text!
            self.spouse.lastName = self.lastNameTF.text!
            self.spouse.company = self.companyTF.text!
            self.spouse.position = self.positionTF.text!
            self.spouse.birthDate = self.datePicker.date
            if(self.spouse.image == nil || self.spouse.image != self.imageButton.currentBackgroundImage)
            {
                self.spouse.imageChanged = true
            }
            self.spouse.image = self.imageButton.currentBackgroundImage
            if(!self.editMode)
            {
                self.parentFamilyList.addFamilyMember(self.spouse)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func validateForm() -> Bool
    {
        var errorMsg = ""
        if(firstNameTF.text == "")
        {
            errorMsg = "You must enter a first name"
        }
        else if(lastNameTF.text == "")
        {
            errorMsg = "You must enter a last name"
        }
                
        if(errorMsg == "")
        {
            self.errorHeight = CGFloat(0.0)
            let newSize = CGSizeMake(self.sv.getWidth(), self.sv.getHeight()-self.errorHeight)
            sv.contentSize = newSize
            
            self.errorTV.hidden = true
            return true
        }
        else
        {
            self.errorHeight = self.errorTV.getHeight()
            let newSize = CGSizeMake(self.sv.getWidth(), self.sv.getHeight()-self.errorHeight)
            sv.contentSize = newSize
            self.errorTV.text = errorMsg
            self.errorTV.textColor = UIColor.redColor()
            self.errorTV.hidden = false
            return false
        }
    }

    
    @IBAction func phoneNumbersButtonPressed(sender: AnyObject)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PairList") as! PairList
        vc.varName = "Phone Numbers"
        vc.data = self.spouse.phoneNumbers
        vc.familyMember = self.spouse
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    @IBAction func emailsButtonPressed(sender: AnyObject)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PairList") as! PairList
        vc.varName = "Email Addresses"
        vc.data = self.spouse.emails
        vc.familyMember = self.spouse
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "Set Image")
        {
            let vc = segue.destinationViewController as! GetImageVC
            vc.buttonForImage = self.imageButton
        }

    }
    

}
