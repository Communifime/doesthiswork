//
//  DiscoveryVC.swift
//  communifime
//
//  Created by Michael Litman on 5/5/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class DiscoveryFilterVC: UIViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    var discoveryList : DiscoveryList!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: 2500)
        // Do any additional setup after loading the view.
    }

    @IBAction func applyButtonPressed(sender : AnyObject)
    {
        Determine the filter based on the form
        var filter = [String: String]()
        filter["First Name"] = "Mike"
        self.discoveryList.applyFilter(filter)
        self.dismissViewControllerAnimated(true, completion: nil)
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
