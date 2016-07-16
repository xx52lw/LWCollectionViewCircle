//
//  LWCircleLayout.swift
//  LWCollectionViewCircle
//
//  Created by 张星星 on 16/6/19.
//  Copyright © 2016年 LW. All rights reserved.
//

import UIKit

class LWCircleLayout: UICollectionViewFlowLayout {
    var cellCount   : Int?
    var collectSize :CGSize?
    var center      : CGPoint?
    var radius      : CGFloat?
    
    
    
    
    
    override func prepareLayout() {
        super.prepareLayout()
        self.collectSize = self.collectionView?.frame.size
        self.cellCount   = self.collectionView?.numberOfItemsInSection(0)
        self.center      = CGPointMake(self.collectSize!.width * 0.5, self.collectSize!.height * 0.5)
        self.radius      = min(self.collectSize!.width, self.collectSize!.height)/2.5
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        if let count = self.cellCount {
            for i in 0..<count {
                let indexPath = NSIndexPath(forItem: i, inSection: 0)
                let attributes = self.layoutAttributesForItemAtIndexPath(indexPath)
                attributesArray.append(attributes!)
            }
        }
        return attributesArray
    }
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attrs.size = CGSizeMake(60, 60)
        let x = Double(self.center!.x) + Double(self.radius!) * cos(Double(2 * indexPath.item) * M_PI/Double(self.cellCount!))
        let y = Double(self.center!.y) + Double(self.radius!) * sin(Double(2 * indexPath.item) * M_PI/Double(self.cellCount!))
        attrs.center = CGPointMake(CGFloat(x) ,CGFloat(y))
        return attrs
    }
    
}
