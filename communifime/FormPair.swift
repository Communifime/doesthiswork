//
//  FormPair.swift
//  communifime
//
//  Created by Michael Litman on 4/9/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class FormPair: NSObject
{
    var type : String
    var name : String
    var value : AnyObject
    
    init(name : String, value : AnyObject, type: String)
    {
        self.name = name
        self.value = value
        self.type = type
    }
}
