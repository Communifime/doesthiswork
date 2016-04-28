//
//  Community.swift
//  communifime
//
//  Created by Michael Litman on 4/25/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class Community: NSObject, ImageContainer
{
    var key : String!
    var name : String!
    var communityDescription : String = ""
    var imageName: String = ""
    var admin : String!
    var image : UIImage?
    var imageChanged = false
    
    func save()
    {
        //update image if needed
        if(imageChanged)
        {
            self.imageName = Core.storeImage(self.image!, fileName: self.imageName, isProfile: false)
        }
        
        let ref = Core.fireBaseRef.childByAppendingPath("communities").childByAppendingPath(self.key)
        ref.setValue(self.getDictionary())
    }
    
    func getDictionary() -> NSDictionary
    {
        var dict = [String : AnyObject]()
        dict["name"] = self.name
        dict["description"] = self.communityDescription
        dict["imageName"] = self.imageName
        dict["admin"] = Core.fireBaseRef.authData.uid
        return dict
    }
}
