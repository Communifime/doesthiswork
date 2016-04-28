//
//  Community.swift
//  communifime
//
//  Created by Michael Litman on 4/25/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase

class Community: NSObject, ImageContainer
{
    var parentCommunity : Community? = nil
    var key : String!
    var name : String!
    var communityDescription : String = ""
    var imageName: String = ""
    var admin : String!
    var image : UIImage?
    var imageChanged = false
    var subCommunities = [Community]()
    var ref = Core.fireBaseRef.childByAppendingPath("communities")
    
    func save(saveSuccessLabel : UILabel)
    {
        //update image if needed
        if(imageChanged)
        {
            self.imageName = Core.storeImage(self.image!, fileName: self.imageName, isProfile: false)
        }
        
        let ref = Core.fireBaseRef.childByAppendingPath("communities").childByAppendingPath(self.key)
        ref.setValue(self.getDictionary()) { (error, firebase) in
            UIView.animateWithDuration(0.5, animations: {
                saveSuccessLabel.alpha = 1.0
                }, completion: { (done) in
                    UIView.animateWithDuration(0.5, animations: {
                        saveSuccessLabel.alpha = 0.0
                    })
            })
        }
    }
    
    func loadSubCommunities(subs : NSDictionary)
    {
        for sub in subs
        {
            print(sub)
            parse the subs here!
        }
    }
    
    func addSubCommunity(sub : Community, savedLabel: UILabel)
    {
        let ref = self.ref.childByAppendingPath("sub_communities").childByAutoId()
        sub.parentCommunity = self
        sub.key = ref.key
        ref.setValue(sub.getDictionary()){ (error, firebase) in
            UIView.animateWithDuration(0.5, animations: {
                savedLabel.alpha = 1.0
                }, completion: { (done) in
                    UIView.animateWithDuration(0.5, animations: {
                        savedLabel.alpha = 0.0
                    })
            })
        }
        self.subCommunities.append(sub)
    }
    
    func getDictionary() -> [String : AnyObject]
    {
        var dict = [String : AnyObject]()
        dict["name"] = self.name
        dict["description"] = self.communityDescription
        dict["imageName"] = self.imageName
        dict["admin"] = Core.fireBaseRef.authData.uid
        
        var subComs = [String: [String: AnyObject]]()
        for sub in self.subCommunities
        {
            subComs[sub.key] = sub.getDictionary()
        }
        dict["sub_communities"] = subComs
        return dict
    }
}
