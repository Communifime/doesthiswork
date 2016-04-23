//
//  ProfileDateCell.swift
//  communifime
//
//  Created by Michael Litman on 4/11/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ProfileDateCell: UITableViewCell
{
    @IBOutlet weak var varName: UILabel!
    @IBOutlet weak var date: UIDatePicker!
    var data : FormPair!
    var profile : UserProfile!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func dateDidChange(sender : AnyObject)
    {
        data.value = date.date
        self.profile.setValue(data.name, value: data.value)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
