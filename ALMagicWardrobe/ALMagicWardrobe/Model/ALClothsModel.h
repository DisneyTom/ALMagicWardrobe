//
//  ALClothsModel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"

@interface ALClothsModel : ALBaseModel
@property(nonatomic,copy) NSString *collects;
@property(nonatomic,copy) NSString *clothsDescription;
@property(nonatomic,copy) NSString *clothsId;
@property(nonatomic,copy) NSString *mainImage;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *styleNumber;
@property(nonatomic,copy) NSString *type;

+(instancetype)questionWithDict:(NSDictionary *)comeDic;
@end
