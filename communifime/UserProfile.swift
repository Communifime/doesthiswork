//
//  UserProfile.swift
//  communifime
//
//  Created by Michael Litman on 4/2/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import AWSCore
import FirebaseDatabase

class UserProfile: NSObject, ImageContainer
{
    var uid : String!
    var perms = [CommunityPermissions]()
    var firstName : String = ""
    var lastName : String = ""
    var image : UIImage? = nil
    var imageName : String = ""
    var homeAddress : Address =  Address(street1: "", street2: "", city: "", state: "", zip: "")
    var hometown : String = ""
    var facebook : String = ""
    var twitter : String = ""
    var linkedIn : String = ""
    var gender : String = "male"
    var birthDate : NSDate = NSDate()
    var hairColor : String = "blonde"
    var hairLength : String = "bald"
    var eyeColor : String = "blue"
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
    
    //var ref : FIRDatabaseReference!

    init(uid : String)
    {
        super.init()
        self.uid = uid
        self.fillData(self.uid, notify: true)
    }
    
    func fillData(uid: String, notify: Bool)
    {
        let ref = Core.fireBaseRef.child("profile").child(uid)
        //get current data
        ref.observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot!) in
            if(!(snapshot.value is NSNull))
            {
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
                self.imageName = data["Image Name"] as! String
                self.birthDate = NSDate.aws_dateFromString(data["Birth Date"] as! String)
                let homeAddress = data["Home Address"] as!  NSDictionary
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
            NSNotificationCenter.defaultCenter().postNotificationName("LoginStepComplete", object: nil)
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
        
        if(currProfileImage != nil && self.image != currProfileImage)
        {
            if(self.imageName == "")
            {
                //generate a hash name for the image
                let date = NSDate()
                let hashableString = NSString(format: "%f", date.timeIntervalSinceReferenceDate)
                let hashString = hashableString.aws_md5String() + ".png"
                self.imageName = hashString
            }

            profile["Image Name"] = self.imageName
            Core.storeImage(currProfileImage!, fileName: self.imageName, isProfile: true)
        }
        else
        {
            profile["Image Name"] = self.imageName
        }
        //delete the images staged for deletion
        Core.deleteImageList()
        
        let ref = Core.fireBaseRef.child("profile").child(uid)
        ref.setValue(profile) { (error, firebase) in
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
        
        personalPairs.append(FormPair(name: "emails", value: emails, type: "PairList"))
        
        personalPairs.append(FormPair(name: "phone numbers", value: phoneNumbers, type: "PairList"))
        
        personalPairs.append(FormPair(name: "Gender", value: self.gender, type: "Segments"))
        
        personalPairs.append(FormPair(name: "Hair Color", value: self.hairColor, type: "Segments"))
        
        personalPairs.append(FormPair(name: "Hair Length", value: self.hairLength, type: "Segments"))
        
        personalPairs.append(FormPair(name: "Eye Color", value: self.eyeColor, type: "Segments"))
        
        personalPairs.append(FormPair(name: "Birth Date", value: self.birthDate, type: "Date"))
        
        personalPairs.append(FormPair(name: "Facebook", value: self.facebook, type: "Text"))
        
        personalPairs.append(FormPair(name: "Twitter", value: self.twitter, type: "Text"))
        
        personalPairs.append(FormPair(name: "LinkedIn", value: self.linkedIn, type: "Text"))
        
        personalPairs.append(FormPair(name: "Home Address", value: homeAddress, type: "Address"))
        
        personalPairs.append(FormPair(name: "Home Town", value: self.hometown, type: "Text"))
        
        //Education
        educationPairs.append(FormPair(name: "High School", value: self.highSchool, type: "Text"))
        
        educationPairs.append(FormPair(name: "colleges", value: colleges, type: "PairList"))

        //Work
        workPairs.append(FormPair(name: "Company", value: self.company, type: "Text"))
        
        workPairs.append(FormPair(name: "Position", value: self.position, type: "Text"))
        
        workPairs.append(FormPair(name: "Work Address", value: workAddress, type: "Address"))
        
        //Family
        familyPairs.append(FormPair(name: "Family Members", value: familyMembers, type: "FamilyList"))
        
        return [personalPairs, familyPairs, educationPairs, workPairs]
    }
    
    func hasAgeInRange(min: Int, max: Int) -> Bool
    {
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        let ageComponents = calendar.components(.Year, fromDate: self.birthDate, toDate: NSDate(), options: [])
        return ageComponents.year >= min && ageComponents.year <= max
    }
    
    func hasFamilyMemberWithAgeInRange(min: Int, max: Int) -> Bool
    {
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        let now = NSDate()
        for fm in self.familyMembers
        {
            let ageComponents = calendar.components(.Year, fromDate: fm.birthDate, toDate: now, options: [])
            if(ageComponents.year >= min && ageComponents.year <= max)
            {
                return true
            }
        }
        return false
    }
    
    func hasEmailContaining(s : String) -> Bool
    {
        for pair in self.emails
        {
            if(pair.value.containsString(s))
            {
                return true
            }
        }
        return false
    }
    
    func hasPhoneContaining(s : String) -> Bool
    {
        for pair in self.phoneNumbers
        {
            if(pair.value.containsString(s))
            {
                return true
            }
        }
        return false
    }

    func hasCollegeContaining(s : String) -> Bool
    {
        for pair in self.colleges
        {
            if(pair.value.containsString(s))
            {
                return true
            }
        }
        return false
    }

    func hasBirthDate(aws_String: String) -> Bool
    {
        return self.birthDate.aws_stringValue("M/dd/yyyy") == aws_String
    }
    
    func hasAddressContaining(s : String) -> Bool
    {
        let homeAddressString = "\(self.homeAddress.street1) \(self.homeAddress.street2) \(self.homeAddress.city) \(self.homeAddress.state) \(self.homeAddress.zip)"
        if(homeAddressString.containsString(s))
        {
            return true
        }
        
        let workAddressString = "\(self.workAddress.street1) \(self.workAddress.street2) \(self.workAddress.city) \(self.workAddress.state) \(self.workAddress.zip)"
        if(workAddressString.containsString(s))
        {
            return true
        }
        return false
    }
    
    func hasFamilyMemberNamed(s: String) -> Bool
    {
        for member in self.familyMembers
        {
            let name = "\(member.firstName) \(member.lastName)"
            if(name.containsString(s))
            {
                return true
            }
        }
        return false
    }
    
    func hasFamilyMemberWithBirthday(s: String) -> Bool
    {
        for member in self.familyMembers
        {
            let birthday = member.birthDate.aws_stringValue("M/dd/yyyy")
            if(birthday == s)
            {
                return true
            }
        }
        return false
    }

    func hasFamilyMemberInCompany(s: String) -> Bool
    {
        for member in self.familyMembers
        {
            if(member is SpouseFamilyMember)
            {
                if((member as! SpouseFamilyMember).company.containsString(s))
                {
                    return true
                }
            }
        }
        return false
    }

    func hasFamilyMemberWithPosition(s: String) -> Bool
    {
        for member in self.familyMembers
        {
            if(member is SpouseFamilyMember)
            {
                if((member as! SpouseFamilyMember).position.containsString(s))
                {
                    return true
                }
            }
        }
        return false
    }

    func hasFamilyMemberInGrade(s: String) -> Bool
    {
        for member in self.familyMembers
        {
            if(member is ChildFamilyMember)
            {
                if((member as! ChildFamilyMember).grade == s)
                {
                    return true
                }
            }
        }
        return false
    }
}
