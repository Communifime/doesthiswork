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
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
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
    var readOnly = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(editMode)
        {
            self.deleteButton.hidden = false
        }
        else
        {
            self.deleteButton.hidden = true
        }
        
        if(self.child.imageName != "")
        {
            Core.getImage(self.imageButton, imageContainer: self.child, isProfile: true)
        }

        self.child.relationship = "child"
        self.errorTV.hidden = true
        self.imageButton.maskAsCircle()
        self.firstNameTF.maskWithUnderline()
        self.lastNameTF.maskWithUnderline()
        self.gradeTF.maskWithUnderline()
        
        if(self.readOnly)
        {
            self.saveButton.hidden = true
            self.imageButton.userInteractionEnabled = false
            self.firstNameTF.enabled = false
            self.lastNameTF.enabled = false
            self.gradeTF.enabled = false
            self.deleteButton.hidden = true
            self.datePicker.userInteractionEnabled = false
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ManageSpouseVC.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ManageSpouseVC.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteButtonPressed(sender : AnyObject)
    {
        let vc = UIAlertController(title: "Delete Confirmation", message: "Are you sure you wish to delete this family member?", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "Confirm", style: .Default) { (action) in
            //do delete stuff
            Core.imagesToDelete.append(self.child.imageName)
            let pos = self.parentFamilyList.data.indexOf(self.child)
            self.parentFamilyList.data.removeAtIndex(pos!)
            self.parentFamilyList.tableView.reloadData()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        vc.addAction(cancelAction)
        vc.addAction(confirmAction)
        self.presentViewController(vc, animated: true, completion: nil)
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
            if(self.child.image == nil || self.child.image != self.imageButton.currentBackgroundImage)
            {
                self.child.imageChanged = true
            }
            self.child.image = self.imageButton.currentBackgroundImage
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
            if(self.child.imageName != "")
            {
                vc.currImage = self.imageButton.currentBackgroundImage
            }

            vc.buttonForImage = self.imageButton
        }
        
    }
}
