//
//  ManageSpouseVC.swift
//  communifime
//
//  Created by Michael Litman on 4/10/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ManageSpouseVC: UIViewController
{

    @IBOutlet weak var sv: UIScrollView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var positionTF: UITextField!
    
    @IBOutlet weak var phoneNumbersButton: UIButton!
    @IBOutlet weak var emailsButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imageButton.maskAsCircle()
        self.firstNameTF.maskWithUnderline()
        self.lastNameTF.maskWithUnderline()
        self.companyTF.maskWithUnderline()
        self.positionTF.maskWithUnderline()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews()
    {
        sv.setWidth(self.view.getWidth())
        sv.contentSize = CGSizeMake(sv.getWidth(), 1080)
    }
    
    @IBAction func phoneNumbersButtonPressed(sender: AnyObject)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PairList") as! PairList
        vc.varName = "Phone Numbers"
        vc.data = [Pair]()
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    @IBAction func emailsButtonPressed(sender: AnyObject)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PairList") as! PairList
        vc.varName = "Email Addresses"
        vc.data = [Pair]()
        self.presentViewController(vc, animated: true, completion: nil)
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
        if(segue.identifier == "Set Image")
        {
            let vc = segue.destinationViewController as! GetImageVC
            vc.buttonForImage = self.imageButton
        }

    }
    

}
