//
//  ProfileSegmentCell.swift
//  communifime
//
//  Created by Michael Litman on 5/5/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ProfileSegmentCell: UITableViewCell
{
    @IBOutlet weak var title: UILabel!
    var data : FormPair!
    @IBOutlet weak var segments: UISegmentedControl!
    var segmentValues : [String]!
    var profile : UserProfile!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    @IBAction func segmentsChanged(sender : UISegmentedControl)
    {
        data.value = self.segmentValues[sender.selectedSegmentIndex]
        self.profile.setValue(data.name, value: data.value)
    }

    func setSelectedSegment(value: String)
    {
        var pos = 0
        segments.removeAllSegments()
        for s in segmentValues
        {
            segments.insertSegmentWithTitle(s, atIndex: pos, animated: false)
            pos += 1
        }

        pos = 0
        self.segments.selectedSegmentIndex = 0
        for s in self.segmentValues
        {
            if(s == value)
            {
                self.segments.selectedSegmentIndex = pos
                break
            }
            pos += 1
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
