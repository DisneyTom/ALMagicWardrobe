//
//  ALUserDetailModel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-27.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"
#import "ALUserModel.h"

@interface ALUserDetailModel : ALBaseModel
@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *magic;
@property(nonatomic,copy) NSString *magicLeavel;
@property(nonatomic,copy) NSString *surplusDays;
@property(nonatomic,copy) NSString *totalDays;
@property(nonatomic,copy) NSString *useDays;
@property(nonatomic,strong) ALUserModel *theUserModel;
+(instancetype)questionWithDict:(NSDictionary *)comeDic;
@end
