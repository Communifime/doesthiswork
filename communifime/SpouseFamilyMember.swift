//
//  SpouseFamilyMember.swift
//  communifime
//
//  Created by Michael Litman on 4/10/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class SpouseFamilyMember: FamilyMember
{
    var emails : [Pair] = [Pair]()
    var phoneNumbers : [Pair] = [Pair]()
    var company : String = ""
    var position : String = ""
    
    override func toDictionary() -> [String : AnyObject]
    {
        var data = super.toDictionary()
        data["Company"] = self.company
        data["Position"] = self.position
        data["Emails"] = Core.pairArrayToDictionary(self.emails)
        data["Phone Numbers"] = Core.pairArrayToDictionary(self.phoneNumbers)
        data["Relationship"] = "spouse"
        return data
    }
}
