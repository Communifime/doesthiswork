//
//  Address.swift
//  communifime
//
//  Created by Michael Litman on 4/4/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class Address: NSObject
{
    var street1 : String
    var street2 : String
    var city : String
    var state : String
    var zip : String
    
    init(street1: String, street2: String, city: String, state: String, zip: String)
    {
        self.street1 = street1
        self.street2 = street2
        self.city = city
        self.state = state
        self.zip = zip
    }
}
