//
//  ManageChildVC.swift
//  communifime
//
//  Created by Michael Litman on 4/10/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ManageChildVC: UIViewController
{

    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var gradeTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imageButton.maskAsCircle()
        self.firstNameTF.maskWithUnderline()
        self.lastNameTF.maskWithUnderline()
        self.gradeTF.maskWithUnderline()
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
        if(segue.identifier == "Set Image")
        {
            let vc = segue.destinationViewController as! GetImageVC
            vc.buttonForImage = self.imageButton
        }
        
    }
}
