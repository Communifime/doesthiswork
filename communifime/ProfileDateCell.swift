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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
