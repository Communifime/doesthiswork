//
//  CommunityListCell.swift
//  communifime
//
//  Created by Michael Litman on 6/12/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import CGLMail

class CommunityListCell: UITableViewCell
{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var memberListButton: UIButton!
    var communityList : CommunityList!
    var community: Community!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func inviteButtonPressed()
    {
        let vc = CGLMailHelper.mailViewControllerWithRecipients([], subject: "Communifi Invite", message: "Join: \(self.community.name)\nCommunity ID: \(community.key)\nPassword: \(community.password)", isHTML: false, includeAppInfo: false, completion: nil)
        communityList.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func memberListButtonPressed()
    {
        let vc = self.communityList.storyboard?.instantiateViewControllerWithIdentifier("MemberListVC") as! MemberListVC
        vc.community = self.community
        self.communityList.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
