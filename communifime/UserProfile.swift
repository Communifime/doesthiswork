//
//  UserProfile.swift
//  communifime
//
//  Created by Michael Litman on 4/2/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase
import AWSCore

class UserProfile: NSObject, ImageContainer
{
    var firstName : String = ""
    var lastName : String = ""
    var image : UIImage? = nil
    var imageName : String = ""
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
        self.fillData(uid, notify: false)
    }
    
    init(uid : String)
    {
        super.init()
        self.fillData(uid, notify: true)
    }
    
    func fillData(uid: String, notify: Bool)
    {
        self.ref = Core.fireBaseRef.childByAppendingPath("profile").childByAppendingPath(uid)
        //get current data
        self.ref.observeSingleEventOfType(.Value) { (snapshot: FDataSnapshot!) in
            if(!(snapshot.value is NSNull))
            {
                let data = snapshot.value as! NSDictionary
                print(data)
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
                self.imageName = data["Image Name"] as! String
                self.birthDate = NSDate.aws_dateFromString(data["Birth Date"] as! String)
                let homeAddress = data["Home Address"] as! NSDictionary
                self.homeAddress.street1 = homeAddress["street1"] as! String
                self.homeAddress.street2 = homeAddress["street2"] as! String
                self.homeAddress.city = homeAddress["city"] as! String
                self.homeAddress.state = homeAddress["state"] as! String
                self.homeAddress.zip = homeAddress["zip"] as! String
                
                let workAddress = data["Work Address"] as! NSDictionary
                self.workAddress.street1 = workAddress["street1"] as! String
                self.workAddress.street2 = workAddress["street2"] as! String
                self.workAddress.city = workAddress["city"] as! String
                self.workAddress.state = workAddress["state"] as! String
                self.workAddress.zip = workAddress["zip"] as! String
                self.emails = Core.dictionaryToPairArray(data["Emails"] as? [String : String])
                self.phoneNumbers = Core.dictionaryToPairArray(data["Phone Numbers"] as? [String : String])
                self.colleges = Core.dictionaryToPairArray(data["Colleges"] as? [String : String])
                if(data["Family Members"] != nil)
                {
                    self.familyMembers = self.getFamilyMemberArray(data["Family Members"] as! [[String : AnyObject]])
                }
                
                if(notify)
                {
                    NSNotificationCenter.defaultCenter().postNotificationName("Profile Data Loaded", object: nil)
                }
            }
        }
    }
    
    func setValue(key : String, value : AnyObject)
    {
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
        else if(key == "Birth Date")
        {
            self.birthDate = value as! NSDate
        }
    }
    
    func save(saveSuccessButton: UIButton?, currProfileImage: UIImage?)
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
        profile["Birth Date"] = self.birthDate.aws_stringValue(AWSDateISO8601DateFormat1)
        profile["Emails"] = Core.pairArrayToDictionary(self.emails)
        profile["Phone Numbers"] = Core.pairArrayToDictionary(self.phoneNumbers)
        profile["Colleges"] = Core.pairArrayToDictionary(self.colleges)
        profile["Family Members"] = self.getFamilyMembersDictionary()
        
        if(self.image != nil && self.imageName == "")
        {
            //generate a hash name for the image
            let date = NSDate()
            let hashableString = NSString(format: "%f", date.timeIntervalSinceReferenceDate)
            let hashString = hashableString.aws_md5String() + ".png"
            self.imageName = hashString
        }
        profile["Image Name"] = self.imageName
        if(currProfileImage != nil && self.image != currProfileImage)
        {
            Core.storeImage(currProfileImage!, fileName: self.imageName, isProfile: true)
        }
        //delete the images staged for deletion
        Core.deleteImageList()
        
        self.ref.setValue(profile) { (error, firebase) in
            if(saveSuccessButton != nil)
            {
                UIView.animateWithDuration(0.5, animations: {
                    saveSuccessButton!.alpha = 1.0
                    }, completion: { (done) in
                        UIView.animateWithDuration(0.5, animations: {
                            saveSuccessButton!.alpha = 0.0
                    })
                })
            }
        }
    }
    
    func getFamilyMemberArray(dictionaries : [[String : AnyObject]]) -> [FamilyMember]
    {
        var data = [FamilyMember]()
        for obj in dictionaries
        {
            let relationship = obj["Relationship"]! as! String
            if(relationship == "child")
            {
                let child = ChildFamilyMember()
                child.firstName = obj["First Name"] as! String
                child.lastName = obj["Last Name"] as! String
                child.imageName = obj["Image Name"] as! String
                child.grade = obj["Grade"] as! String
                child.birthDate = NSDate.aws_dateFromString(obj["Birth Date"] as! String)
                data.append(child)
            }
            else if(relationship == "spouse")
            {
                let spouse = SpouseFamilyMember()
                spouse.firstName = obj["First Name"] as! String
                spouse.lastName = obj["Last Name"] as! String
                spouse.imageName = obj["Image Name"] as! String
                spouse.company = obj["Company"] as! String
                spouse.position = obj["Position"] as! String
                spouse.birthDate = NSDate.aws_dateFromString(obj["Birth Date"] as! String)
                spouse.emails = Core.dictionaryToPairArray(obj["Emails"] as? [String : String])
                spouse.phoneNumbers = Core.dictionaryToPairArray(obj["Phone Numbers"] as? [String : String])
                data.append(spouse)
            }
        }
        return data
    }
    
    func getFamilyMembersDictionary() -> [String : [String : AnyObject]]
    {
        var fmDictionary = [String : [String : AnyObject]]()
        var index = 0
        for fm in self.familyMembers
        {
            fmDictionary["\(index)"] = fm.toDictionary()
            index += 1
        }
        return fmDictionary
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
        
        personalPairs.append(FormPair(name: "Gender", value: self.gender, type: "Segments"))
        
        personalPairs.append(FormPair(name: "Hair Color", value: self.hairColor, type: "Segments"))
        
        personalPairs.append(FormPair(name: "Hair Length", value: self.hairLength, type: "Segments"))
        
        personalPairs.append(FormPair(name: "Eye Color", value: self.eyeColor, type: "Segments"))
        
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
