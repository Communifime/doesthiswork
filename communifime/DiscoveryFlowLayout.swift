//
//  DiscoveryFlowLayout.swift
//  communifime
//
//  Created by Michael Litman on 6/29/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

//
//  CustomImageFlowLayout.swift
//  ZDT_InstaTutorial
//
//  Created by Sztanyi Szabolcs on 22/12/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

import UIKit

class DiscoveryFlowLayout: UICollectionViewFlowLayout
{
    var numCols = CGFloat(2)
    var relativeWidth = CGFloat(1)
    var relativeHeight = CGFloat(1)
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize {
        set {
            
        }
        get {
            let numberOfColumns: CGFloat = numCols
            
            let itemWidth = (CGRectGetWidth(self.collectionView!.frame) - (numberOfColumns - 1)) / numberOfColumns
            return CGSizeMake(itemWidth*self.relativeWidth, itemWidth*self.relativeHeight)
        }
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .Vertical
    }
    
}
