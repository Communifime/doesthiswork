//
//  Community.swift
//  communifime
//
//  Created by Michael Litman on 4/25/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Community: NSObject, ImageContainer
{
    var parentCommunity : Community? = nil
    var key : String!
    var name : String!
    var communityDescription : String = ""
    var imageName: String = ""
    var admin : String!
    var image : UIImage?
    var members = [String : String]()
    var approved = false
    var imageChanged = false
    var subCommunities = [Community]()
    var ref = Core.fireBaseRef.child("communities")
    
    func addMember(uid: String, name : String)
    {
        self.members[uid] = name
    }
    
    func addAndStoreMember(uid: String , name : String)
    {
        self.addMember(uid, name: name)
        let ref = self.ref.child("members").child(uid)
        ref.setValue(["name" : name])
    }
    
    func hasMember(uid : String) -> Bool
    {
        for key in self.members.keys
        {
            if(key == uid)
            {
                return true
            }
        }
        return false
    }
    
    func save(saveSuccessLabel : UILabel)
    {
        //update image if needed
        if(imageChanged)
        {
            self.imageName = Core.storeImage(self.image!, fileName: self.imageName, isProfile: false)
        }
        
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
    
    func updateApprovedAndStore(value : Bool)
    {
        self.approved = value
        self.ref.updateChildValues(["approved" : self.approved])
    }
    
    func loadMembers(members: NSDictionary)
    {
        print(members)
        for member in members
        {
            let value = member.value as! NSDictionary
            self.addMember(member.key as! String, name: value["name"] as! String)
        }
    }
    
    func loadSubCommunities(subs : NSDictionary)
    {
        for sub in subs
        {
            let c = Community()
            c.parentCommunity = self
            c.key = sub.key as! String
            c.ref = self.ref.child("sub_communities").child(c.key)
            let obj = sub.value as! NSDictionary
            c.name = obj["name"] as! String
            c.communityDescription = obj["description"] as! String
            c.admin = obj["admin"] as! String
            c.imageName = obj["imageName"] as! String
            c.approved = obj["approved"] as! Bool
            
            let possibleMembers = obj["members"]
            if(possibleMembers != nil)
            {
                c.loadMembers(possibleMembers as! NSDictionary)
            }
            
            let possibleSubs = obj["sub_communities"]
            if(possibleSubs != nil)
            {
                c.loadSubCommunities(possibleSubs as! NSDictionary)
            }
            self.subCommunities.append(c)
        }
    }
    
    func hasSubCommunityWithName(name: String) -> Bool
    {
        for c in self.subCommunities
        {
            if(c.name == name)
            {
                return true
            }
        }
        return false
    }
    
    func addSubCommunity(sub : Community, savedLabel: UILabel)
    {
        let ref = self.ref.child("sub_communities").childByAutoId()
        sub.parentCommunity = self
        sub.key = ref.key
        ref.setValue(sub.getDictionary()){ (error, firebase) in
            let currPerm = Core.getPermissionFromCache(self)
            let uid = FIRAuth.auth()!.currentUser!.uid
            let perm = CommunityPermissions(uid: uid)
            perm.contact = currPerm!.contact
            perm.infoShare = currPerm!.infoShare
            perm.communityKey = sub.key
            perm.save(savedLabel)
        }
        self.subCommunities.append(sub)
    }
    
    func getDictionary() -> [String : AnyObject]
    {
        var dict = [String : AnyObject]()
        dict["name"] = self.name
        dict["description"] = self.communityDescription
        dict["imageName"] = self.imageName
        dict["admin"] = FIRAuth.auth()?.currentUser?.uid
        dict["approved"] = self.approved
        var subComs = [String: [String: AnyObject]]()
        for sub in self.subCommunities
        {
            subComs[sub.key] = sub.getDictionary()
        }
        dict["sub_communities"] = subComs
        return dict
    }
}
