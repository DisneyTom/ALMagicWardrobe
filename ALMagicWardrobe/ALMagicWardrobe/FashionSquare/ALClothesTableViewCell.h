//
//  ALClothesTableViewCell.h
//  ALMagicWardrobe
//
//  Created by OCN on 15-4-2.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALClothsModel.h"
typedef void (^ClothsCellBackBlock)(NSInteger index);
@interface ALClothesTableViewCell : UITableViewCell

-(void)setLeftModel:(ALClothsModel *)theModel;
-(void)setRightModel:(ALClothsModel *)theModel;

@property(nonatomic,copy) ClothsCellBackBlock theBlock;
@end
