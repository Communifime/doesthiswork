//
//  MemberListCell.swift
//  communifime
//
//  Created by Michael Litman on 7/5/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class MemberListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        print(CGFloat(self.indentationLevel) * self.indentationWidth)
        var ivFrame = self.imageView?.frame
        ivFrame?.origin.x = (ivFrame?.origin.x)! + CGFloat(self.indentationLevel) * self.indentationWidth
        self.imageView?.frame = ivFrame!
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
