//
//  DiscoveryListCell.swift
//  communifime
//
//  Created by Michael Litman on 6/2/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class DiscoveryListCell: UITableViewCell
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImageView.maskAsCircle()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
