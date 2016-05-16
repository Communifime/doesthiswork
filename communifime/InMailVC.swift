//
//  InMailVC.swift
//  communifime
//
//  Created by Michael Litman on 5/15/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import CGLMail

class InMailVC: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addButtonPressed(sender: UIBarButtonItem)
    {
        let vc = CGLMailHelper.mailViewControllerWithRecipients([], subject: "email test", message: "message text", isHTML: false, includeAppInfo: false, completion: nil)
        self.presentViewController(vc, animated: true, completion: nil)
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
