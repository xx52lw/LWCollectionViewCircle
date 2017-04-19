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
    
    
    
    
    
    override func prepare() {
        super.prepare()
        self.collectSize = self.collectionView?.frame.size
        self.cellCount   = self.collectionView?.numberOfItems(inSection: 0)
        self.center      = CGPoint(x: self.collectSize!.width * 0.5, y: self.collectSize!.height * 0.5)
        self.radius      = min(self.collectSize!.width, self.collectSize!.height)/2.5
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        if let count = self.cellCount {
            for i in 0..<count {
                let indexPath = IndexPath(item: i, section: 0)
                let attributes = self.layoutAttributesForItem(at: indexPath)
                attributesArray.append(attributes!)
            }
        }
        return attributesArray
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attrs.size = CGSize(width: 60, height: 60)
        let x = Double(self.center!.x) + Double(self.radius!) * cos(Double(2 * indexPath.item) * M_PI/Double(self.cellCount!))
        let y = Double(self.center!.y) + Double(self.radius!) * sin(Double(2 * indexPath.item) * M_PI/Double(self.cellCount!))
        attrs.center = CGPoint(x: CGFloat(x) ,y: CGFloat(y))
        return attrs
    }
    
}
