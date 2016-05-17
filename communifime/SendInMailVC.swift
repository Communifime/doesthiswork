//
//  SendInMailVC.swift
//  communifime
//
//  Created by Michael Litman on 5/16/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class SendInMailVC: UIViewController
{
    
    @IBOutlet weak var toLabel: UILabel!
    
    var profile : UserProfile!
    Make send inmail work
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        toLabel.text = "To: \(profile.firstName) \(profile.lastName)"
        // Do any additional setup after loading the view.
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
