//
//  PairVC.swift
//  communifime
//
//  Created by Michael Litman on 4/6/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class PairVC: UIViewController
{
    @IBOutlet weak var navBar: UINavigationBar!
    var category = "Default Category"
    var profileSV : ProfileScrollView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navBar.topItem?.title = self.category
        
        // Do any additional setup after loading the view.
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
        let pl = segue.destinationViewController as! PairList
        pl.profileSV = self.profileSV
    }
    

}