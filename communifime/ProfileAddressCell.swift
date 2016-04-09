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
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var street2Label: UILabel!
    @IBOutlet weak var street1Label: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    var address : Address?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    func updateAddress()
    {
        self.street1Label.text = address!.street1
        self.street2Label.text = address!.street2
        self.cityLabel.text = address!.city
        self.stateLabel.text = address!.state
        self.zipLabel.text = address!.zip
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
