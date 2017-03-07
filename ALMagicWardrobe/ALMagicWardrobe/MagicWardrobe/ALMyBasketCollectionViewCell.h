//
//  ALMyBasketCollectionViewCell.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ALMagicWardrobeClothsModel.h"
typedef void (^BackBlock)(id sender);

@interface ALMyBasketCollectionViewCell : UICollectionViewCell

/**
 *  是否是编辑状态
 */
@property (nonatomic, assign) BOOL isEdit;

-(void)setModel:(ALMagicWardrobeClothsModel *)theModel;
@property(nonatomic,copy) BackBlock theBlock;

@end
