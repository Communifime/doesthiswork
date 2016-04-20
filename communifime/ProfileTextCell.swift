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
    var data : FormPair!
    var profile : UserProfile!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        // Initialization code
        tf.maskWithUnderline()
    }

    @IBAction func textDidChange(sender : UITextField)
    {
        data.value = sender.text!
        self.profile.setValue(data.name, value: data.value)
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
