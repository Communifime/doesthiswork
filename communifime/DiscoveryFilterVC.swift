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
    
    @IBOutlet weak var familyMemberBirthDatePicker: UIDatePicker!
    @IBOutlet weak var familyMemberHighSchoolTF: UITextField!
    @IBOutlet weak var familyMemberCollegeTF: UITextField!
    @IBOutlet weak var familyMemberPositionTF: UITextField!
    @IBOutlet weak var familyMemberCompanyTF: UITextField!
    @IBOutlet weak var familyMemberGradeTF: UITextField!
    @IBOutlet weak var familyMemberNameTF: UITextField!
    @IBOutlet weak var eyeColorSegments: UISegmentedControl!
    @IBOutlet weak var hairLengthSegments: UISegmentedControl!
    @IBOutlet weak var hairColorSegments: UISegmentedControl!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    @IBOutlet weak var genderSegments: UISegmentedControl!
    @IBOutlet weak var homeTownTF: UITextField!
    @IBOutlet weak var highSchoolTF: UITextField!
    @IBOutlet weak var collegeTF: UITextField!
    @IBOutlet weak var positionTF: UITextField!
    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
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
        var filter = [String: String]()
        let today = NSDate().aws_stringValue("M/dd/yyyy")
        if(self.nameTF.text != "")
        {
            filter["Name"] = self.nameTF.text
        }
        if(self.emailTF.text != "")
        {
            filter["Email"] = self.emailTF.text
        }
        if(self.addressTF.text != "")
        {
            filter["Address"] = self.addressTF.text
        }
        if(self.phoneTF.text != "")
        {
            filter["Phone"] = self.phoneTF.text
        }
        if(self.companyTF.text != "")
        {
            filter["Company"] = self.companyTF.text
        }
        if(self.positionTF.text != "")
        {
            filter["Position"] = self.positionTF.text
        }
        if(self.collegeTF.text != "")
        {
            filter["College"] = self.collegeTF.text
        }
        if(self.highSchoolTF.text != "")
        {
            filter["High School"] = self.highSchoolTF.text
        }
        if(self.homeTownTF.text != "")
        {
            filter["Hometown"] = self.homeTownTF.text
        }
        if(self.genderSegments.titleForSegmentAtIndex(self.genderSegments.selectedSegmentIndex) != "N/A")
        {
            filter["Gender"] = self.genderSegments.titleForSegmentAtIndex(self.genderSegments.selectedSegmentIndex)
        }
        if(self.hairColorSegments.titleForSegmentAtIndex(self.hairColorSegments.selectedSegmentIndex) != "N/A")
        {
            filter["Hair Color"] = self.hairColorSegments.titleForSegmentAtIndex(self.hairColorSegments.selectedSegmentIndex)
        }
        if(self.hairLengthSegments.titleForSegmentAtIndex(self.hairLengthSegments.selectedSegmentIndex) != "N/A")
        {
            filter["Hair Length"] = self.hairLengthSegments.titleForSegmentAtIndex(self.hairLengthSegments.selectedSegmentIndex)
        }
        if(self.eyeColorSegments.titleForSegmentAtIndex(self.eyeColorSegments.selectedSegmentIndex) != "N/A")
        {
            filter["Eye Color"] = self.eyeColorSegments.titleForSegmentAtIndex(self.eyeColorSegments.selectedSegmentIndex)
        }
        if(self.birthdatePicker.date.aws_stringValue("M/dd/yyyy") != today)
        {
            filter["Birth Date"] = self.birthdatePicker.date.aws_stringValue("M/dd/yyyy")
        }
        if(self.familyMemberNameTF.text != "")
        {
            filter["Family Member Name"] = self.familyMemberNameTF.text
        }
        if(self.familyMemberGradeTF.text != "")
        {
            filter["Family Member Grade"] = self.familyMemberGradeTF.text
        }
        if(self.familyMemberCollegeTF.text != "")
        {
            filter["Family Member College"] = self.familyMemberCollegeTF.text
        }
        if(self.familyMemberCompanyTF.text != "")
        {
            filter["Family Member Company"] = self.familyMemberCompanyTF.text
        }
        if(self.familyMemberPositionTF.text != "")
        {
            filter["Family Member Position"] = self.familyMemberPositionTF.text
        }
        if(self.familyMemberHighSchoolTF.text != "")
        {
            filter["Family Member High School"] = self.familyMemberHighSchoolTF.text
        }
     if(self.familyMemberBirthDatePicker.date.aws_stringValue("M/dd/yyyy") != today)
        {
            filter["Family Member Birth Date"] = self.familyMemberBirthDatePicker.date.aws_stringValue("M/dd/yyyy")
        }
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
