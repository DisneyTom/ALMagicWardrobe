//
//  ALMyMWTableViewCell.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-4-25.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "OcnTableViewCell.h"
#import "ALMagicWardrobeClothsModel.h"

typedef void (^ClothsCellBackBlock)(NSInteger index);

@interface ALMyMWTableViewCell : UITableViewCell

-(void)setLeftModel:(ALMagicWardrobeClothsModel *)theModel;
-(void)setRightModel:(ALMagicWardrobeClothsModel *)theModel;

@property(nonatomic,copy) ClothsCellBackBlock theBigBlock;
@property(nonatomic,copy) ClothsCellBackBlock theSmallBlock;

@property (nonatomic, assign) int index;
@end
