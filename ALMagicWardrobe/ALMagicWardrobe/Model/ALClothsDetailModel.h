//
//  ALClothsDetailModel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"
@interface ALClothsDetailModel : ALBaseModel
@property(nonatomic,copy) NSString *color;
@property(nonatomic,copy) NSString *clothsDescription;
@property(nonatomic,copy) NSString *clothsId;
@property(nonatomic,copy) NSString *images;
@property(nonatomic,copy) NSString *isStick;
@property(nonatomic,copy) NSString *mainImage;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *size;
@property(nonatomic,copy) NSString *styleNumber;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *isSale;
@property(nonatomic,copy) NSArray *collection;
@property(nonatomic,copy) NSString *selectSize;
@property(nonatomic,copy) NSString *selectColor;
@property(nonatomic,copy) NSArray* assortFashions;
@property(nonatomic,copy) NSArray* fashionSize;

@property(nonatomic,assign) BOOL isCollected;

+(instancetype)questionWithDict:(NSDictionary *)comeDic;
@end
