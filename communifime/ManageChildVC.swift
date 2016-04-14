//
//  ManageChildVC.swift
//  communifime
//
//  Created by Michael Litman on 4/10/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ManageChildVC: UIViewController
{
    @IBOutlet weak var sv: UIScrollView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var gradeTF: UITextField!
    @IBOutlet weak var errorTV: UITextView!
    @IBOutlet weak var addButton: UIButton!

    @IBOutlet weak var datePicker: UIDatePicker!
    var errorHeight = CGFloat(0.0)
    var parentFamilyList : FamilyList!
    var child = ChildFamilyMember()
    var editMode = false
    var initialDataLoaded = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.child.relationship = "child"
        self.errorTV.hidden = true
        self.imageButton.maskAsCircle()
        self.firstNameTF.maskWithUnderline()
        self.lastNameTF.maskWithUnderline()
        self.gradeTF.maskWithUnderline()
        
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
        //load the form
        if(!self.initialDataLoaded)
        {
            if(self.editMode)
            {
                self.setButtonTitles(self.addButton, theTitle: "save")
            }
            self.firstNameTF.text = self.child.firstName
            self.lastNameTF.text = self.child.lastName
            self.gradeTF.text = self.child.grade
            self.datePicker.date = self.child.birthDate
            if(self.child.image != nil)
            {
                self.imageButton.setBackgroundImage(self.child.image!, forState: .Normal)
                self.imageButton.setBackgroundImage(self.child.image!, forState: .Highlighted)
                self.imageButton.setBackgroundImage(self.child.image!, forState: .Selected)
            }
            self.initialDataLoaded = true
        }
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
        let newSize = CGSizeMake(self.sv.getWidth(), self.sv.getHeight()+keyboardHeight+self.errorHeight)
        sv.contentSize = newSize
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        let newSize = CGSizeMake(self.sv.getWidth(), self.sv.getHeight()+self.errorHeight)
        sv.contentSize = newSize
    }

    @IBAction func addButtonPressed(sender: AnyObject)
    {
        if(self.validateForm())
        {
            //add the child to the family list
            self.child.firstName = self.firstNameTF.text!
            self.child.lastName = self.lastNameTF.text!
            self.child.grade = self.gradeTF.text!
            self.child.birthDate = self.datePicker.date
            self.child.image = self.imageButton.backgroundImageForState(.Normal)
            if(!self.editMode)
            {
                self.parentFamilyList.addFamilyMember(self.child)
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
        else if(gradeTF.text == "")
        {
            errorMsg = "You must enter a grade"
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
