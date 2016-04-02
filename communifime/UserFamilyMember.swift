//
//  UserFamilyMember.swift
//  communifime
//
//  Created by Michael Litman on 4/2/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class UserFamilyMember: NSObject
{
    var name : String!
    var image : UIImage!
    var birthDate : NSDate!
    var relationship : String!
    var spouseEmails : [String : String] = [:]
    var spousePhoneNumbers : [String : String] = [:]
    var company : String!
    var position : String!
    var childGrade : String!
}
