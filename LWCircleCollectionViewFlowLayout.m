//
//  LWCircleCollectionViewFlowLayout.m
//  lottery
//
//  Created by 张星星 on 2017/4/26.
//  Copyright © 2017年 张星星. All rights reserved.
//

#import "LWCircleCollectionViewFlowLayout.h"
@implementation LWCircleCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.collectSize = self.collectionView.frame.size;
    self.cellCount   = [self.collectionView numberOfItemsInSection:0];
    self.center      = CGPointMake(self.collectSize.width * 0.5, self.collectSize.height * 0.5);
    self.radius      = MIN(self.collectSize.width, self.collectSize.height)/2.5;
}
-(CGSize)collectionViewContentSize {
    return [self collectionView].frame.size;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = self.cellSize;
    CGFloat x = self.center.x + self.radius * cos(2*indexPath.item * M_PI / self.cellCount);
    CGFloat y = self.center.x + self.radius * sin(2*indexPath.item * M_PI / self.cellCount);
    attrs.center = CGPointMake(x, y);
    return attrs;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributesArray  = [NSMutableArray array];
    for (NSInteger i = 0; i < self.cellCount; ++i) {
        UICollectionViewLayoutAttributes  *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [attributesArray addObject:attributes];
    }
    return attributesArray;
}

#pragma mark - 修复间隙
- (CGFloat)fixSlitWidth:(CGFloat) width colCount:(CGFloat) colCount space:(CGFloat)space {
    CGFloat totalSpace = (colCount - 1) * space;
    CGFloat itemWidth = (width - totalSpace) / colCount;
    CGFloat fixValue = 1 / [UIScreen mainScreen].scale;
    CGFloat realItemWidth = floor(itemWidth) + fixValue;
    if (realItemWidth < itemWidth) {
        realItemWidth += fixValue;
    }
    CGFloat realWidth = colCount * realItemWidth + totalSpace;
    return (realWidth - totalSpace) / colCount;
}


@end
