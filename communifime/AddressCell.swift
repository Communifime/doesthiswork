//
//  AddressCell.swift
//  communifime
//
//  Created by Michael Litman on 4/4/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell
{
    @IBOutlet weak var street1: UILabel!
    @IBOutlet weak var street2: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var zip: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
