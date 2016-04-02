//
//  UserProfile.swift
//  communifime
//
//  Created by Michael Litman on 4/2/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class UserProfile: NSObject
{
    var firstName : String = ""
    var lastName : String = ""
    var image : UIImage?
    var emails : [String : String] = [:]
    var homeAddress : UserAddress?
    var workAddress : UserAddress?
    var hometown : String = ""
    var phoneNumbers : [String : String] = [:]
    var facebook : String = ""
    var twitter : String = ""
    var linkedIn : String = ""
    var gender : String = ""
    var birthDate : NSDate?
    var hairColor : String = ""
    var hairLength : String = ""
    var eyeColor : String = ""
    
    //Work Info
    var company : String = ""
    var position : String = ""
    
    //Education
    var colleges : [String : String] = [:]
    var highSchool : String = ""
    var familyMembers : [String : UserFamilyMember] = [:]
    
    func fillScrollView(sv : ProfileScrollView)
    {
        let names = ["First Name", "Last Name", "Hometown", "Facebook", "Twitter", "LinkedIn", "Gender", "Hair Color", "Hair Length", "Eye Color", "Company", "Position", "High School"]
        let values = [firstName, lastName, hometown, facebook, twitter, linkedIn, gender, hairColor, hairLength, eyeColor, company, position, highSchool]
        
        for i in 0..<names.count
        {
            sv.addTextFieldAtCurrentRow(names[i], placeholderText: names[i], value: values[i], x: 10, width: 250)
            
            sv.advanceToNextRow()
        }
    }
}
