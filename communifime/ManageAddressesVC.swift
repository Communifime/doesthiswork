//
//  ManageAddressesVC.swift
//  communifime
//
//  Created by Michael Litman on 4/4/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ManageAddressesVC: UIViewController
{

    var addressListTVC : AddressListTVC!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "NewAddressView")
        {
            let vc = segue.destinationViewController as! NewAddressVC
            vc.parentAddressListTVC = self.addressListTVC
        }
        else if(segue.identifier == "AddressTableView")
        {
            self.addressListTVC = segue.destinationViewController as! AddressListTVC
        }
    }
    

}
