//
//  CommunityPermissions.swift
//  communifime
//
//  Created by Michael Litman on 4/28/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase

class CommunityPermissions: NSObject
{
    var communityKey : String!
    var infoShare : String! = "partial"
    var contact : String! = "in-mail"
    var ref = Core.fireBaseRef.childByAppendingPath("community_permissions")
    func save(saveSuccessButton : UILabel?)
    {
        let ref = self.ref.childByAppendingPath(Core.fireBaseRef.authData.uid).childByAppendingPath(self.communityKey)
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
