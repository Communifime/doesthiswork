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
    
    static func getImage(button: UIButton)
    {
        // Construct the NSURL for the download location.
        let downloadingFilePath = NSTemporaryDirectory().stringByAppendingString("downloaded-testImage.jpg")
        
        let downloadingFileURL = NSURL.fileURLWithPath(downloadingFilePath)
        
        // Construct the download request.
        let downloadRequest = AWSS3TransferManagerDownloadRequest.init()
        
        downloadRequest.bucket = "communifi";
        downloadRequest.key = "testImage.jpg";
        downloadRequest.downloadingFileURL = downloadingFileURL;
        
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        transferManager.download(downloadRequest).continueWithSuccessBlock { (task) -> AnyObject? in
            dispatch_async(dispatch_get_main_queue(), { 
                let image = UIImage(contentsOfFile: downloadingFilePath)
                Core.setButtonImage(button, image: image!)
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
