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
    @IBOutlet weak var savedLabel: UILabel!
    
    var community : Community!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        let newCom = Community()
        newCom.name = self.nameTF.text!
        newCom.communityDescription = "new sub"
        newCom.admin = self.community.admin
        newCom.imageName = self.community.imageName
        self.community.addSubCommunity(newCom, savedLabel: self.savedLabel)
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
