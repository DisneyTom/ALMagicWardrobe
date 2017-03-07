//
//  ALMyMagicWardrobeCollectionViewCell.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-22.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALMagicWardrobeClothsModel.h"
typedef void (^BackBlock)(id sender);

@interface ALMyMagicWardrobeCollectionViewCell : UICollectionViewCell
-(void)setModel:(ALMagicWardrobeClothsModel *)theModel;
@property(nonatomic,copy) BackBlock theBlock;

@end
