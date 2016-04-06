//
//  AddressView.swift
//  communifime
//
//  Created by Michael Litman on 4/5/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class AddressView: UIViewController
{
    var addressName = "Default Name"
    var address : Address?
    
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var street2Label: UILabel!
    @IBOutlet weak var street1Label: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navBar.topItem?.title = addressName
        //self.view.setHeight(110)
        
        if(address != nil)
        {
            self.street1Label.text = address!.street1
            self.street2Label.text = address!.street2
            self.cityLabel.text = address!.city
            self.stateLabel.text = address!.state
            self.zipLabel.text = address!.zip
        }
    }
    
    override func didReceiveMemoryWarning()
    {
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
