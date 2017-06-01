//
//  LWCircleCollectionViewFlowLayout.h
//  lottery
//
//  Created by 张星星 on 2017/4/26.
//  Copyright © 2017年 张星星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWCircleCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) NSInteger  cellCount;
@property (nonatomic,assign) CGSize      collectSize;
@property (nonatomic,assign) CGSize      cellSize;
@property (nonatomic,assign) CGPoint    center;
@property (nonatomic,assign) CGFloat    radius;

@end
