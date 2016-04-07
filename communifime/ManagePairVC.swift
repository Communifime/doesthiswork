//
//  ManagePairVC.swift
//  communifime
//
//  Created by Michael Litman on 4/6/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ManagePairVC: UIViewController
{
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var value: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    var varName = "New Label"
    var parentPairList : PairList!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navBar.topItem?.title = "New \(self.varName)"
        self.name.maskWithUnderline()
        self.value.maskWithUnderline()
    }
    
    func validateForm() -> Bool
    {
        return true
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        if(self.validateForm())
        {
            self.parentPairList.addPair(self.name.text!, value: self.value.text!)
            self.dismissViewControllerAnimated(true, completion: nil)
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
