//
//  LWCircleCollectionViewCell.swift
//  LWCollectionViewCircle
//
//  Created by 张星星 on 16/6/19.
//  Copyright © 2016年 LW. All rights reserved.
//

import UIKit

class LWCircleCollectionViewCell: UICollectionViewCell {
    // MARK : - 懒加载textLabel
  lazy var imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .ScaleAspectFill
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(self.imageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = bounds
    }
    
    
}
