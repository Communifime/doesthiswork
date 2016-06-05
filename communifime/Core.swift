//
//  Core.swift
//  communifime
//
//  Created by Michael Litman on 3/26/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import AWSS3
import AWSCore
import Firebase
import FirebaseDatabase
import FirebaseAuth

class Core: NSObject
{
    static var storyboard : UIStoryboard!
    static var fireBaseRef = FIRDatabase.database().reference()
    static var allCommunities = [Community]()
    static var myCommunities = [Community]()
    static var allPermissions = [CommunityPermissions]()
    
    static var currentUserProfile : UserProfile!
    static var communityPermissionsCache = [CommunityPermissions]()
    static var imagesToDelete = [String]()
    static var discoveryListObserver : DiscoveryList!
    static var imageCache = [String: UIImage]()
    static var appAdmin = false
    static var adminCommunityList : AdminCommunityList!
    static var communityList : CommunityList!
    
    static func setAppAdmin()
    {
        let ref = fireBaseRef.child("admins")
        let uid = FIRAuth.auth()?.currentUser?.uid
        ref.observeSingleEventOfType(.Value) { (snapshot:FIRDataSnapshot) in
            if(!(snapshot.value is NSNull))
            {
                print(snapshot.value)
                let objects = snapshot.value as! NSArray
                for obj in objects
                {
                    if(obj as! String == uid!)
                    {
                        appAdmin = true
                        return
                    }
                }
                appAdmin = false
            }
        }
    }
    /*
     returns true if the logged in user has full view perms
     for the uid that was passed in based on comparing all
     the communities the two users have in common and the BEST
     perm within those
     */
    static func hasFullViewPermission(uid : String) -> Bool
    {
        for community in myCommunities
        {
            for perm in allPermissions
            {
                if(perm.communityKey == community.key && perm.uid == uid && perm.infoShare == "full")
                {
                    return true
                }
            }
            
            //check sub-communities
            if(community.subCommunities.count > 0)
            {
                if(checkSubCommunityFullPerms(uid, subs: community.subCommunities))
                {
                    return true
                }
            }
        }
        return false
    }
    
    static func checkSubCommunityFullPerms(uid: String, subs: [Community]) -> Bool
    {
        var answer = false
        for sub in subs
        {
            for perm in allPermissions
            {
                if(perm.communityKey == sub.key && perm.uid == uid && perm.infoShare == "full")
                {
                    return true
                }
            }
            
            if(sub.subCommunities.count > 0)
            {
                answer = answer || checkSubCommunityFullPerms(uid, subs: sub.subCommunities)
            }
        }
        return answer
    }
    
    static func getCommunicationSettings(uid: String) -> String
    {
        var inMail = false
        var email = false
        var both = false
        
        for community in myCommunities
        {
            for perm in allPermissions
            {
                if(perm.communityKey == community.key && perm.uid == uid)
                {
                    if(perm.contact == "in-mail")
                    {
                        inMail = true
                    }
                    else if(perm.contact == "email")
                    {
                        email = true
                    }
                    else if(perm.contact == "both")
                    {
                        both = true
                    }
                }
            }
            
            //check sub-communities
            if(community.subCommunities.count > 0)
            {
                var comms = [false, false, false]
                self.getSubCommunityCommunicationSettings(uid, subs: community.subCommunities, comms: &comms)
                if(comms[0])
                {
                    inMail = true
                }
                else if(comms[1])
                {
                    email = true
                }
                else if(comms[2])
                {
                    both = true
                }
            }
        }
        if(both)
        {
            return "Both"
        }
        else if(email)
        {
            return "Email"
        }
        else
        {
            return "In-Mail"
        }
    }
    
    static func getSubCommunityCommunicationSettings(uid: String, subs: [Community], inout comms: [Bool])
    {
        for sub in subs
        {
            for perm in allPermissions
            {
                if(perm.communityKey == sub.key && perm.uid == uid)
                {
                    if(perm.contact == "in-mail")
                    {
                        comms[0] = true
                    }
                    else if(perm.contact == "email")
                    {
                        comms[1] = true
                    }
                    else if(perm.contact == "both")
                    {
                        comms[2] = true
                    }

                }
            }
            
            if(sub.subCommunities.count > 0)
            {
                getSubCommunityCommunicationSettings(uid, subs: sub.subCommunities, comms: &comms)
            }
        }
    }
    
    static func getAllPerms()
    {
        allPermissions.removeAll()
        let ref = fireBaseRef.child("community_permissions")
    
        ref.observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot!) in
            if(!(snapshot.value is NSNull))
            {
                for snap in snapshot.value as! NSDictionary
                {
                    let uid = snap.key as! String
                    let perms = snap.value as! NSDictionary
                    for perm in perms
                    {
                        let communityKey = perm.key as! String
                        let newPermission = CommunityPermissions(uid: uid)
                        let parts = perm.value as! NSDictionary
                        
                        newPermission.communityKey = communityKey
                        newPermission.contact = parts["contact"] as! String
                        newPermission.infoShare = parts["infoShare"] as! String
                        allPermissions.append(newPermission)
                    }
                }
            }
        }
    }
    static func getPermissionFromCache(community: Community) -> CommunityPermissions?
    {
        //check cache
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        for perm in communityPermissionsCache
        {
            if(perm.communityKey == community.key && perm.uid == uid)
            {
                return perm
            }
        }
        return nil
    }
    
    static func addPermissionToCache()
    {
        //retrieve from firebase
        let ref = fireBaseRef.child("community_permissions").child((FIRAuth.auth()?.currentUser!.uid)!)
        ref.observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot!) in
            if(!(snapshot.value is NSNull))
            {
                let data = snapshot.value as! NSDictionary
                for datum in data
                {
                    let perm = CommunityPermissions(uid: (FIRAuth.auth()?.currentUser!.uid)!)
                    perm.communityKey = datum.key as! String
                    perm.infoShare = datum.value["infoShare"]!
                    perm.contact = datum.value["contact"]!
                    communityPermissionsCache.append(perm)
                }
            }
        }
    }
    
    static func dictionaryToPairArray(pairDictionary : [String : String]?) -> [Pair]
    {
        var pairs = [Pair]()
        if(pairDictionary == nil)
        {
            return pairs
        }
        for datum in pairDictionary!
        {
            pairs.append(Pair(name: datum.0, value: datum.1))
        }
        return pairs
    }
    
    static func pairArrayToDictionary(pairs : [Pair]) -> [String : String]
    {
        var pairDictionary = [String : String]()
        for pair in pairs
        {
            pairDictionary[pair.name] = pair.value
        }
        return pairDictionary
    }

    static func setButtonImage(buttonForImage: UIButton, image: UIImage)
    {
        buttonForImage.setBackgroundImage(image, forState: .Normal)
        buttonForImage.setBackgroundImage(image, forState: .Highlighted)
        buttonForImage.setBackgroundImage(image, forState: .Selected)
    }
    
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage
    {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = UIImageJPEGRepresentation(newImage, 0.5);
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }

    static func storeImage(image: UIImage, fileName: String?, isProfile: Bool) -> String
    {
        // Construct the upload request.
        var hashString = fileName
        if(hashString == nil || hashString == "")
        {
            let date = NSDate()
            let hashableString = NSString(format: "%f", date.timeIntervalSinceReferenceDate)
            hashString = hashableString.aws_md5String() + ".png"
        }
        var maxWidth = 250
        var folderName = "logo_pics/"
        if(isProfile)
        {
            maxWidth = 150
            folderName = "profile_pics/"
        }
        let compressedImage = self.resizeImage(image, newWidth: CGFloat(maxWidth))
        
        //save to local cache
        imageCache[hashString!] = compressedImage
        
        let path:NSString = NSTemporaryDirectory().stringByAppendingString(hashString!)
        let imageData = UIImagePNGRepresentation(compressedImage)
        imageData!.writeToFile(path as String, atomically: true)
        let url: NSURL = NSURL(fileURLWithPath: path as String)
        let uploadRequest: AWSS3TransferManagerUploadRequest = AWSS3TransferManagerUploadRequest()
        // set the bucket
        uploadRequest.bucket = "communifi"
        uploadRequest.key = folderName +
            hashString!
        uploadRequest.contentType =
        "png"
        uploadRequest.body = url
        uploadRequest.uploadProgress = { (currSent, totalSent, totalExpected) in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                
            })
        }
        let transferManager:AWSS3TransferManager =
            AWSS3TransferManager.defaultS3TransferManager()
        transferManager.upload(uploadRequest)
        return hashString!
    }
    
    static func deleteImageList()
    {
        for imageName in imagesToDelete
        {
            deleteImage(imageName)
        }
        imagesToDelete.removeAll()
    }
    
    static func deleteImage(imageName : String)
    {
        let deleteRequest = AWSS3DeleteObjectRequest.init()
        deleteRequest.bucket = "communifi";
        deleteRequest.key = "profile_pics/\(imageName)";
        let s3 = AWSS3.defaultS3()
        s3.deleteObject(deleteRequest)
    }
    
    static func getImage(button: UIButton, imageContainer: ImageContainer, isProfile: Bool)
    {
        //check local cache
        if(imageCache[imageContainer.imageName] != nil)
        {
            let image = imageCache[imageContainer.imageName]!
            button.setBackgroundImage(image, forState: .Normal)
            button.setBackgroundImage(image, forState: .Highlighted)
            button.setBackgroundImage(image, forState: .Selected)
            return
        }
        
        let imagePath = NSBundle.mainBundle().pathForResource("loadingImage", ofType: "png")
        let loadingImage = UIImage(contentsOfFile: imagePath!)
        button.setBackgroundImage(loadingImage, forState: .Normal)
        button.setBackgroundImage(loadingImage, forState: .Highlighted)
        button.setBackgroundImage(loadingImage, forState: .Selected)
        
        // Construct the NSURL for the download location.
        let downloadingFilePath = NSTemporaryDirectory().stringByAppendingString(imageContainer.imageName)
        
        let downloadingFileURL = NSURL.fileURLWithPath(downloadingFilePath)
        
        // Construct the download request.
        let downloadRequest = AWSS3TransferManagerDownloadRequest.init()
        var folderName = "logo_pics/"
        if(isProfile)
        {
            folderName = "profile_pics/"
        }
        
        downloadRequest.bucket = "communifi";
        downloadRequest.key = "\(folderName)\(imageContainer.imageName)";
        downloadRequest.downloadingFileURL = downloadingFileURL;
        
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        transferManager.download(downloadRequest).continueWithSuccessBlock { (task) -> AnyObject? in
            dispatch_async(dispatch_get_main_queue(), { 
                let image = UIImage(contentsOfFile: downloadingFilePath)
                Core.setButtonImage(button, image: image!)
                if(imageContainer is UserProfile)
                {
                    (imageContainer as! UserProfile).image = image!
                }
                else if(imageContainer is FamilyMember)
                {
                    (imageContainer as! FamilyMember).image = image!
                }
            })
            return nil
        }
    }
    
    static func getImage(iv: UIImageView, imageName: String, isProfile: Bool)
    {
        //check local cache
        if(imageCache[imageName] != nil)
        {
            let image = imageCache[imageName]!
            iv.image = image
            return
        }

        let imagePath = NSBundle.mainBundle().pathForResource("loadingImage", ofType: "png")
        let loadingImage = UIImage(contentsOfFile: imagePath!)
        iv.image = loadingImage
        
        // Construct the NSURL for the download location.
        let downloadingFilePath = NSTemporaryDirectory().stringByAppendingString(imageName)
        
        let downloadingFileURL = NSURL.fileURLWithPath(downloadingFilePath)
        
        // Construct the download request.
        let downloadRequest = AWSS3TransferManagerDownloadRequest.init()
        var folderName = "logo_pics/"
        if(isProfile)
        {
            folderName = "profile_pics/"
        }
        
        downloadRequest.bucket = "communifi";
        downloadRequest.key = "\(folderName)\(imageName)";
        downloadRequest.downloadingFileURL = downloadingFileURL;
        
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        transferManager.download(downloadRequest).continueWithSuccessBlock { (task) -> AnyObject? in
            dispatch_async(dispatch_get_main_queue(), {
                let image = UIImage(contentsOfFile: downloadingFilePath)
                iv.image = image!
            })
            return nil
        }
    }

    static func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
}
