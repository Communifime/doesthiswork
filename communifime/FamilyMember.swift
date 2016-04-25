//
//  FamilyMember.swift
//  communifime
//
//  Created by Michael Litman on 4/10/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import AWSCore

class FamilyMember: NSObject, ImageContainer
{
    var firstName : String = ""
    var lastName : String = ""
    var image : UIImage?
    var imageName : String = ""
    var birthDate : NSDate = NSDate()
    var relationship : String = ""
    var imageChanged = false
    
    func toDictionary() -> [String : AnyObject]
    {
        var data = [String : String]()
        data["First Name"] = self.firstName
        data["Last Name"] = self.lastName
        data["Birth Date"] = self.birthDate.aws_stringValue(AWSDateISO8601DateFormat1)
        if(self.imageName == "")
        {
            //generate a hash name for the image
            let date = NSDate()
            let hashableString = NSString(format: "%f", date.timeIntervalSinceReferenceDate)
            let hashString = hashableString.aws_md5String() + ".png"
            self.imageName = hashString
            
        }
        data["Image Name"] = self.imageName
        
        //save image if needed
        if(self.imageChanged)
        {
            Core.storeImage(self.image!, fileName: self.imageName)
            self.imageChanged = false
        }
        return data
    }
}
