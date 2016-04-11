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
    var homeAddress : Address =  Address(street1: "", street2: "", city: "", state: "", zip: "")
    var hometown : String = ""
    var facebook : String = ""
    var twitter : String = ""
    var linkedIn : String = ""
    var gender : String = ""
    var birthDate : NSDate = NSDate()
    var hairColor : String = ""
    var hairLength : String = ""
    var eyeColor : String = ""
    var emails = [Pair]()
    var phoneNumbers = [Pair]()
    
    //Work Info
    var company : String = ""
    var position : String = ""
    var workAddress : Address =  Address(street1: "", street2: "", city: "", state: "", zip: "")
    
    //Education
    var colleges = [Pair]()
    var highSchool : String = ""
    
    //Family
    var familyMembers = [FamilyMember]()
    
    func getFormObjects() -> [[FormPair]]
    {
        var personalPairs = [FormPair]()
        var workPairs = [FormPair]()
        var educationPairs = [FormPair]()
        var familyPairs = [FormPair]()
        
        //Personal
        personalPairs.append(FormPair(name: "First Name", value: self.firstName, type: "Text"))
        
        personalPairs.append(FormPair(name: "Last Name", value: self.lastName, type: "Text"))
        
        personalPairs.append(FormPair(name: "Gender", value: self.gender, type: "Text"))
        
        personalPairs.append(FormPair(name: "Hair Color", value: self.hairColor, type: "Text"))
        
        personalPairs.append(FormPair(name: "Hair Length", value: self.hairLength, type: "Text"))
        
        personalPairs.append(FormPair(name: "Eye Color", value: self.eyeColor, type: "Text"))
        
        personalPairs.append(FormPair(name: "Home Address", value: homeAddress, type: "Address"))
        
        personalPairs.append(FormPair(name: "Home Town", value: self.hometown, type: "Text"))
        
        personalPairs.append(FormPair(name: "Birth Date", value: self.birthDate, type: "Date"))
        
        personalPairs.append(FormPair(name: "emails", value: emails, type: "PairList"))
        
        personalPairs.append(FormPair(name: "phone numbers", value: phoneNumbers, type: "PairList"))
        
        personalPairs.append(FormPair(name: "Facebook", value: self.facebook, type: "Text"))
        
        personalPairs.append(FormPair(name: "Twitter", value: self.twitter, type: "Text"))
        
        personalPairs.append(FormPair(name: "LinkedIn", value: self.linkedIn, type: "Text"))
        
        
        //Work
        workPairs.append(FormPair(name: "Company", value: self.company, type: "Text"))
        
        workPairs.append(FormPair(name: "Position", value: self.position, type: "Text"))
        
        workPairs.append(FormPair(name: "Work Address", value: workAddress, type: "Address"))
  
        
        //Education
        educationPairs.append(FormPair(name: "High School", value: self.highSchool, type: "Text"))
        
        educationPairs.append(FormPair(name: "colleges", value: colleges, type: "PairList"))
        
        //Family
        familyPairs.append(FormPair(name: "Family Members", value: colleges, type: "FamilyList"))
        
        
        return [personalPairs, workPairs, educationPairs, familyPairs]
    }
}
