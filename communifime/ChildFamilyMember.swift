//
//  ChildFamilyMember.swift
//  communifime
//
//  Created by Michael Litman on 4/11/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ChildFamilyMember: FamilyMember
{
    var grade : String = ""
    
    override func toDictionary() -> [String : AnyObject]
    {
        var data = super.toDictionary()
        data["Grade"] = self.grade
        data["Relationship"] = "child"
        return data
    }
}
