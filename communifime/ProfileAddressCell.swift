//
//  ProfileAddressCell.swift
//  communifime
//
//  Created by Michael Litman on 4/9/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ProfileAddressCell: UITableViewCell
{
    @IBOutlet weak var cityStateZipLabel: UILabel!
    @IBOutlet weak var street2Label: UILabel!
    @IBOutlet weak var street1Label: UILabel!
    @IBOutlet weak var addressNameLabel: UILabel!
    var address : Address?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    func updateAddress()
    {
        if(address!.street1 == "")
        {
            self.street1Label.text = "Street"
            self.street2Label.text = "Street"
            self.cityStateZipLabel.text = "City, State ZIP"
        }
        else
        {
            self.street1Label.text = address!.street1
            self.street2Label.text = address!.street2
            self.cityStateZipLabel.text = "\(address!.city), \(address!.state) \(address!.zip)"
        }
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
