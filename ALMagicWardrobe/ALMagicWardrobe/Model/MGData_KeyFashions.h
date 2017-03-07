//
//  MGData_KeyFashions.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/6/23.
//  Copyright (c) 2015年 anLun. All rights reserved.
//  描述:热门推荐Model

#import "ALBaseModel.h"

@interface MGData_KeyFashions : ALBaseModel
@property(nonatomic,copy) NSString *keyFashionsId;
@property(nonatomic,copy) NSString *fashionId;
@property(nonatomic,copy) NSString *styleNumber;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *imageUrl;
@property(nonatomic,copy) NSString *collects;
@property(nonatomic,copy) NSString *size;
@property(nonatomic,copy) NSString *saleTime;

+(instancetype)questionWithDict:(NSDictionary *)comeDic;
@end
