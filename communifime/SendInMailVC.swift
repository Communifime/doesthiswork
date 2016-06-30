//
//  SendInMailVC.swift
//  communifime
//
//  Created by Michael Litman on 5/16/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import AWSS3
import Firebase
import FirebaseDatabase

class SendInMailVC: UIViewController
{
    
    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var subjectTF: UITextField!
    @IBOutlet weak var bodyTV: UITextView!
    @IBOutlet weak var errorTV: UITextView!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    var readOnlyMode = false
    var toName : String!
    var toUID : String!
    var currMessage : [String : String]!
    var fromUID : String!
    var autoFillSubject = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.errorTV.hidden = true
        if(self.readOnlyMode)
        {
            self.actionButton.title = "reply"
            self.subjectTF.userInteractionEnabled = false
            self.bodyTV.userInteractionEnabled = false
            self.subjectTF.text = currMessage["subject"]!
            self.bodyTV.text = currMessage["message"]!
        }
        if(self.autoFillSubject != "")
        {
            self.subjectTF.text = self.autoFillSubject
        }
        toLabel.text = "To: \(self.toName)"
        // Do any additional setup after loading the view.
    }

    func validateForm() -> Bool
    {
        var message = ""
        if(self.subjectTF.text == "")
        {
            message = "You must enter a subject!"
        }
        else if(self.bodyTV.text == "")
        {
            message = "You must enter a message body!"
        }
        
        if(message != "")
        {
            self.errorTV.text = message
            self.errorTV.textColor = UIColor.redColor()
            self.errorTV.hidden = false
            return false
        }
        else
        {
            self.errorTV.text = ""
            self.errorTV.hidden = true
            return true
        }
    }
    
    @IBAction func actionButtonPressed(sender: UIView)
    {
        if(self.readOnlyMode)
        {
            //do reply button stuff
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("SendInMailVC") as! SendInMailVC
            vc.toName = "\(Core.currentUserProfile.firstName) \(Core.currentUserProfile.lastName)"
            vc.toUID = self.fromUID
            vc.autoFillSubject = "Re: \(self.subjectTF.text!)"
            self.presentViewController(vc, animated: true, completion: nil)
        }
        else
        {
            if(self.validateForm())
            {
                //send the inmail message
                let inboxRef = Core.fireBaseRef.child("inMail").child(self.toUID).child("inbox").childByAutoId()
                var inboxObj = [String:String]()
                inboxObj["fromUID"] = Core.currentUserProfile.uid
                inboxObj["fromName"] = "\(Core.currentUserProfile.firstName) \(Core.currentUserProfile.lastName)"
                inboxObj["subject"] = self.subjectTF.text!
                inboxObj["message"] = self.bodyTV.text!
                let today = NSDate().aws_stringValue(AWSDateISO8601DateFormat1)
                inboxObj["timestamp"] = today
                inboxRef.setValue(inboxObj, withCompletionBlock: { (error: NSError?, fb: FIRDatabaseReference) in
                    if(error == nil)
                    {
                        let sentRef = Core.fireBaseRef.child("inMail").child(Core.currentUserProfile.uid).child("sent").childByAutoId()
                        var sentObj = [String:String]()
                        sentObj["toUID"] = self.toUID
                        sentObj["toName"] = self.toName
                        sentObj["subject"] = self.subjectTF.text!
                        sentObj["message"] = self.bodyTV.text!
                        sentObj["timestamp"] = today
                        sentRef.setValue(sentObj, withCompletionBlock: { (error: NSError?, fb: FIRDatabaseReference) in
                            if(error == nil)
                            {
                                self.dismissViewControllerAnimated(true, completion: nil)
                            }
                            else
                            {
                                print(error)
                            }
                        })
                    }
                    else
                    {
                        print(error)
                    }
                })
            }
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
