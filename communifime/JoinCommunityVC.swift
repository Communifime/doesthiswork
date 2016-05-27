//
//  JoinCommunityVC.swift
//  communifime
//
//  Created by Michael Litman on 5/1/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class JoinCommunityVC: UIViewController
{
    @IBOutlet weak var communityPasswordTF: UITextField!
    @IBOutlet weak var communityIDTF: UITextField!
    @IBOutlet weak var errorTV: UITextView!
    var communityList : CommunityList!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.errorTV.hidden = true
    }
    
    func validateForm() -> Bool
    {
        var msg = ""
        if(communityIDTF.text == "")
        {
            msg = "You must enter a Community ID"
        }
        else if(communityPasswordTF.text == "")
        {
            msg = "You must enter a password"
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
    
    @IBAction func joinButtonPressed(sender : AnyObject)
    {
        if(self.validateForm())
        {
            let ref = Core.fireBaseRef.child("communities").child(self.communityIDTF.text!)
            ref.observeSingleEventOfType(.Value, withBlock: { (snapshot: FIRDataSnapshot!) in
                if(!(snapshot.value is NSNull))
                {
                    let password = snapshot.value!["password"] as! String
                    if(password == self.communityPasswordTF.text!)
                    {
                        self.errorTV.text = ""
                        self.errorTV.hidden = true
                        let uid = FIRAuth.auth()!.currentUser!.uid
                        for c in Core.allCommunities
                        {
                            if(c.key == self.communityIDTF.text!)
                            {
                                c.addAndStoreMember(uid, name: "\(Core.currentUserProfile.firstName) \(Core.currentUserProfile.lastName)")
                                
                                let perm = CommunityPermissions(uid: uid)
                                perm.communityKey = self.communityIDTF.text!
                                perm.save(nil)
                                Core.communityPermissionsCache.append(perm)
                                self.communityList.updateList()
                                break
                            }
                        }
                    self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            })
        }
        else
        {
            self.errorTV.text = "Incorrect Password"
            self.errorTV.textColor = UIColor.redColor()
            self.errorTV.hidden = false
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
