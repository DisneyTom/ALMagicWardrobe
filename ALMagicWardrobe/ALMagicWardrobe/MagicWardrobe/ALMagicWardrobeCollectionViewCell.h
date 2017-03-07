//
//  ALMagicWardrobeCollectionViewCell.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-20.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALClothsModel.h"
typedef void (^BackBlock)(id sender);
@interface ALMagicWardrobeCollectionViewCell : UICollectionViewCell
-(void)setModel:(ALClothsModel *)theModel;
@property(nonatomic,copy) BackBlock theBlock;
@end
