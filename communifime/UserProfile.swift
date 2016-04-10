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
            let fp = FormPair(name: names[i], value: values[i], type: "Text")
            formPairs.append(fp)
        }
        
        let homeAddress = Address(street1: "", street2: "", city: "", state: "", zip: "")
        formPairs.append(FormPair(name: "Home Address", value: homeAddress, type: "Address"))
        
        let workAddress = Address(street1: "", street2: "", city: "", state: "", zip: "")
        formPairs.append(FormPair(name: "Work Address", value: workAddress, type: "Address"))
        
        let emails = [Pair]()
        formPairs.append(FormPair(name: "emails", value: emails, type: "PairList"))
        
        let phoneNumbers = [Pair]()
        formPairs.append(FormPair(name: "phone numbers", value: phoneNumbers, type: "PairList"))
        
        let colleges = [Pair]()
        formPairs.append(FormPair(name: "colleges", value: colleges, type: "PairList"))
        return formPairs
    }
}
