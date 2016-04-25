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
    
    static var currentUserProfile : UserProfile!
    
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
    
    static func storeImage(image: UIImage, fileName: String?) -> String
    {
        // Construct the upload request.
        var hashString = fileName
        if(hashString == nil)
        {
            let date = NSDate()
            let hashableString = NSString(format: "%f", date.timeIntervalSinceReferenceDate)
            hashString = hashableString.aws_md5String() + ".png"
        }
        
        let path:NSString = NSTemporaryDirectory().stringByAppendingString(hashString!)
        let imageData = UIImagePNGRepresentation(image)
        imageData!.writeToFile(path as String, atomically: true)
        let url: NSURL = NSURL(fileURLWithPath: path as String)
        let uploadRequest: AWSS3TransferManagerUploadRequest = AWSS3TransferManagerUploadRequest()
        // set the bucket
        uploadRequest.bucket = "communifi"
        uploadRequest.key = "profile_pics/" +
            hashString!
        uploadRequest.contentType =
        "png"
        uploadRequest.body = url
        uploadRequest.uploadProgress = { (currSent, totalSent, totalExpected) in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                print("\(totalSent) of \(totalExpected) bytes sent")
            })
        }
        let transferManager:AWSS3TransferManager =
            AWSS3TransferManager.defaultS3TransferManager()
        transferManager.upload(uploadRequest)
        return hashString!
    }
    
    static func getImage(button: UIButton, imageContainer: ImageContainer)
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
        
        downloadRequest.bucket = "communifi";
        downloadRequest.key = "profile_pics/\(imageContainer.imageName)";
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
