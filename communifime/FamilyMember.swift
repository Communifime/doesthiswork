//
//  FamilyMember.swift
//  communifime
//
//  Created by Michael Litman on 4/10/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import AWSCore

class FamilyMember: NSObject
{
    var firstName : String = ""
    var lastName : String = ""
    var image : UIImage?
    var imageName : String = ""
    var birthDate : NSDate = NSDate()
    var relationship : String = ""
    
    func toDictionary() -> [String : AnyObject]
    {
        var data = [String : String]()
        data["First Name"] = self.firstName
        data["Last Name"] = self.lastName
        data["Birth Date"] = self.birthDate.aws_stringValue(AWSDateISO8601DateFormat1)
        return data
    }
}
