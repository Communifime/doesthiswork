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
    
    func getFormObjects() -> [FormPair]
    {
        var formPairs = [FormPair]()
        
        let names = ["First Name", "Last Name", "Hometown", "Facebook", "Twitter", "LinkedIn", "Gender", "Hair Color", "Hair Length", "Eye Color", "Company", "Position", "High School"]
        let values = [firstName, lastName, hometown, facebook, twitter, linkedIn, gender, hairColor, hairLength, eyeColor, company, position, highSchool]
        
        for i in 0..<names.count
        {
            let fp = FormPair(name: names[i], value: values[i])
            formPairs.append(fp)
        }
        
        let homeAddress = Address(street1: "Street", street2: "Street", city: "City", state: "State", zip: "Zip")
        formPairs.append(FormPair(name: "Home Address", value: homeAddress))
        
        let workAddress = Address(street1: "Street", street2: "Street", city: "City", state: "State", zip: "Zip")
        formPairs.append(FormPair(name: "Work Address", value: workAddress))
        return formPairs
    }
    
    func fillScrollView(sv : ProfileScrollView)
    {
        let screenRect = UIScreen.mainScreen().bounds
        
        let names = ["First Name", "Last Name", "Hometown", "Facebook", "Twitter", "LinkedIn", "Gender", "Hair Color", "Hair Length", "Eye Color", "Company", "Position", "High School"]
        let values = [firstName, lastName, hometown, facebook, twitter, linkedIn, gender, hairColor, hairLength, eyeColor, company, position, highSchool]
        //sv.addAddress()
        for i in 0..<names.count
        {
            sv.addTextField(names[i], placeholderText: names[i], value: values[i], x: 10, width: screenRect.width-20)
        }
        sv.addAddress("Home Address")
        sv.addAddress("Work Address")
        sv.addPairList("email")
    }
}
