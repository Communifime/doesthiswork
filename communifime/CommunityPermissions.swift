//
//  CommunityPermissions.swift
//  communifime
//
//  Created by Michael Litman on 4/28/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class CommunityPermissions: NSObject
{
    var communityKey : String!
    var infoShare : String! = "partial"
    var contact : String! = "in-mail"
    var ref = Core.fireBaseRef.child("community_permissions")
    var uid : String
    
    init(uid: String)
    {
        self.uid = uid
    }
    
    func save(saveSuccessButton : UILabel?)
    {
        let ref = self.ref.child(self.uid).child(self.communityKey)
        var dict = [String: AnyObject]()
        dict["infoShare"] = self.infoShare
        dict["contact"] = self.contact
        ref.setValue(dict){ (error, firebase) in
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
}
