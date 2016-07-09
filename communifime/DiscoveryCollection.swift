//
//  DiscoveryCollection.swift
//  communifime
//
//  Created by Michael Litman on 6/29/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class DiscoveryCollection: UICollectionViewController
{
    var data = [Community : [UserProfile]]()
    var filtered_data : [Community : [UserProfile]]!
    var currentFilter = [String : String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let theLayout = DiscoveryFlowLayout()
        theLayout.numCols = 3
        theLayout.relativeHeight = 1.15
        theLayout.headerReferenceSize = CGSizeMake(self.collectionView!.frame.size.width, 50.0)
        self.collectionView?.collectionViewLayout = theLayout
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        self.data.removeAll()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(profileUpdatedNotification), name: "Profile Data Loaded", object: nil)
        //Let core know about me so I can be removed as an observer upon login
        Core.discoveryCollectionObserver = self
        
        for community in Core.myCommunities
        {
            data[community] = [UserProfile]()
            for member in community.members
            {
                data[community]!.append(UserProfile(uid: member.0))
            }
        }
        self.applyFilter([:])
    }

    func profileUpdatedNotification()
    {
        self.collectionView!.reloadData()
    }

    func applyFilter(filter: [String: String])
    {
        self.currentFilter = filter
        self.filtered_data = self.data
        for entry in self.data
        {
            for profile in entry.1
            {
                for pair in filter
                {
                    if(pair.0 == "Name" && !"\(profile.firstName) \(profile.lastName)".containsString(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Age Range")
                    {
                        let parts = pair.1.componentsSeparatedByString(":")
                        if(!profile.hasFamilyMemberWithAgeInRange(Int(parts[0])!, max: Int(parts[1])!))
                        {
                            let pos = self.filtered_data[entry.0]?.indexOf(profile)
                            self.filtered_data[entry.0]?.removeAtIndex(pos!)
                            break

                        }
                    }
                    else if(pair.0 == "Age Range")
                    {
                        let parts = pair.1.componentsSeparatedByString(":")
                        if(!profile.hasAgeInRange(Int(parts[0])!, max: Int(parts[1])!))
                        {
                            let pos = self.filtered_data[entry.0]?.indexOf(profile)
                            self.filtered_data[entry.0]?.removeAtIndex(pos!)
                            break
                            
                        }
                    }
                    else if(pair.0 == "Email" && !profile.hasEmailContaining(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Address" && !profile.hasAddressContaining(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Phone" && !profile.hasPhoneContaining(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Company" && !profile.company.containsString(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Position" && !profile.position.containsString(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "College" && !profile.hasCollegeContaining(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "High School" && !profile.highSchool.containsString(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Hometown" && !profile.hometown.containsString(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Gender" && profile.gender != pair.1)
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Hair Length" && profile.hairLength != pair.1)
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Hair Color" && profile.hairColor != pair.1)
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Eye Color" && profile.eyeColor != pair.1)
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Birth Date" && !profile.hasBirthDate(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Name" && !profile.hasFamilyMemberNamed(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Grade" && !profile.hasFamilyMemberInGrade(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Company" && !profile.hasFamilyMemberInCompany(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Position" && !profile.hasFamilyMemberWithPosition(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                    else if(pair.0 == "Family Member Birth Date" && !profile.hasFamilyMemberWithBirthday(pair.1))
                    {
                        let pos = self.filtered_data[entry.0]?.indexOf(profile)
                        self.filtered_data[entry.0]?.removeAtIndex(pos!)
                        break
                    }
                }
            }
        }
        self.collectionView!.reloadData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Core.myCommunities.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of items
        return self.filtered_data[Core.myCommunities[section]]!.count
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath) as! DiscoveryCollectionHeader
        header.name.text = Core.myCommunities[indexPath.section].name
        return header
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! DiscoveryCollectionCell
   
        // Configure the cell...
        let community = Core.myCommunities[indexPath.section]
        let profile = self.filtered_data[community]![indexPath.row]
        cell.fname.text = profile.firstName
        cell.lname.text = profile.lastName
        if(profile.imageName != "")
        {
            Core.getImage(cell.profileImageView, imageName: profile.imageName, isProfile: true)
        }
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileVC") as! ProfileVC
        let community = Core.myCommunities[indexPath.section]
        let profile = self.filtered_data[community]![indexPath.row]
        vc.profile = profile
        vc.readOnly = true
        vc.fullView = Core.hasFullViewPermission(profile.uid)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
