//
//  ProfileTextCell.swift
//  communifime
//
//  Created by Michael Litman on 4/9/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ProfileTextCell: UITableViewCell
{
    @IBOutlet weak var tf: UITextField!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        // Initialization code
        tf.maskWithUnderline()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
