//
//  UserProfile.swift
//  communifime
//
//  Created by Michael Litman on 4/2/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase

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
    
    var ref : Firebase!

    init(authData : FAuthData)
    {
        super.init()
        let uid = authData.uid!
        self.ref = Core.fireBaseRef.childByAppendingPath("profile").childByAppendingPath(uid)
        
        //get current data
        self.ref.observeSingleEventOfType(.Value) { (snapshot: FDataSnapshot!) in
            let data = snapshot.value as! NSDictionary
            self.company = data["Company"] as! String
            self.eyeColor = data["Eye Color"] as! String
            self.facebook = data["Facebook"] as! String
            self.firstName = data["First Name"] as! String
            self.gender = data["Gender"] as! String
            self.hairColor = data["Hair Color"] as! String
            self.hairLength = data["Hair Length"] as! String
            self.highSchool = data["High School"] as! String
            self.hometown = data["Home Town"] as! String
            self.lastName = data["Last Name"] as! String
            self.linkedIn = data["LinkedIn"] as! String
            self.position = data["Position"] as! String
            self.twitter = data["Twitter"] as! String
        }
    }
    
    func setValue(key : String, value : AnyObject)
    {
        print("Setting \(key) to value \(value)")
        if(key == "First Name")
        {
            self.firstName = value as! String
        }
        else if(key == "Last Name")
        {
            self.lastName = value as! String
        }
        else if(key == "Gender")
        {
            self.gender = value as! String
        }
        else if(key == "Hair Color")
        {
            self.hairColor = value as! String
        }
        else if(key == "Hair Length")
        {
            self.hairLength = value as! String
        }
        else if(key == "Eye Color")
        {
            self.eyeColor = value as! String
        }
        else if(key == "Home Town")
        {
            self.hometown = value as! String
        }
        else if(key == "Facebook")
        {
            self.facebook = value as! String
        }
        else if(key == "Twitter")
        {
            self.twitter = value as! String
        }
        else if(key == "LinkedIn")
        {
            self.linkedIn = value as! String
        }
        else if(key == "Company")
        {
            self.company = value as! String
        }
        else if(key == "Position")
        {
            self.position = value as! String
        }
        else if(key == "High School")
        {
            self.highSchool = value as! String
        }
        else if(key == "High Address")
        {
            self.homeAddress = Address(data: value as! [String : String])
            print("Got Address: \(self.homeAddress)")
        }
        else if(key == "Work Address")
        {
            self.workAddress = Address(data: value as! [String : String])
        }

    }
    
    func save()
    {
        var profile = [String : AnyObject]()
        profile["First Name"] = self.firstName
        profile["Last Name"] = self.lastName
        profile["Gender"] = self.gender
        profile["Hair Color"] = self.hairColor
        profile["Hair Length"] = self.hairLength
        profile["Eye Color"] = self.eyeColor
        profile["Home Town"] = self.hometown
        profile["Facebook"] = self.facebook
        profile["Twitter"] = self.twitter
        profile["LinkedIn"] = self.linkedIn
        profile["Company"] = self.company
        profile["Position"] = self.position
        profile["High School"] = self.highSchool
        profile["Home Address"] = self.homeAddress.getDictionary()
        profile["Work Address"] = self.workAddress.getDictionary()
        self.ref.setValue(profile)
    }
    
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
        familyPairs.append(FormPair(name: "Family Members", value: familyMembers, type: "FamilyList"))
        
        
        return [personalPairs, workPairs, educationPairs, familyPairs]
    }
}
