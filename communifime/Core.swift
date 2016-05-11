//
//  Core.swift
//  communifime
//
//  Created by Michael Litman on 3/26/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase
import AWSS3
import AWSCore

class Core: NSObject
{
    static var storyboard : UIStoryboard!
    
    static var fireBaseRef = Firebase(url: "https://amber-fire-7588.firebaseio.com/")
    static var allCommunities = [Community]()
    static var myCommunities = [Community]()
    static var permsInMyCommunities = [CommunityPermissions]()
    
    static var currentUserProfile : UserProfile!
    static var communityPermissionsCache = [CommunityPermissions]()
    static var imagesToDelete = [String]()
    
    static func fillPermsInMyCommunities()
    {
        let ref = fireBaseRef.childByAppendingPath("community_permissions")
        ref.observeSingleEventOfType(.Value) { (snapshot: FDataSnapshot!) in
            
            GET ALL PERMISSIONS AND THEN FIGURE OUT WHICH ARE IMPORTANT TO U
        }
    }
    static func getPermissionFromCache(community: Community) -> CommunityPermissions?
    {
        //check cache
        for perm in communityPermissionsCache
        {
            if(perm.communityKey == community.key)
            {
                return perm
            }
        }
        return nil
    }
    
    static func addPermissionToCache()
    {
        //retrieve from firebase
        let ref = fireBaseRef.childByAppendingPath("community_permissions").childByAppendingPath(fireBaseRef.authData.uid)
        ref.observeSingleEventOfType(.Value) { (snapshot: FDataSnapshot!) in
            if(!(snapshot.value is NSNull))
            {
                let data = snapshot.value as! NSDictionary
                for datum in data
                {
                    let perm = CommunityPermissions()
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
    
    static func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
}
