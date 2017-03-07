//
//  MGData_Type.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/16.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"

@interface MGData_Type : ALBaseModel
@property(nonatomic,copy) NSString *keyFashionsId;
@property(nonatomic,copy) NSString *fashionId;
@property(nonatomic,copy) NSString *styleNumber;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *imageUrl;
@property(nonatomic,copy) NSString *collects;
@property(nonatomic,copy) NSString *size;

+(instancetype)questionWithDict:(NSDictionary *)comeDic;
@end
