//
//  ALUserDetailModel.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-27.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALUserDetailModel.h"
//#import "AFNconnectionImport.h"
@implementation ALUserDetailModel
- (NSDictionary*)attributeMapDictionary{
    return @{
             @"address": @"address",
             @"magic": @"magic",
             @"magicLeavel": @"magicLeavel",
             @"surplusDays": @"surplusDays",
             @"totalDays": @"totalDays",
             @"useDays": @"useDays"
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    ALUserDetailModel *theModel=[[ALUserDetailModel alloc] initWithDataDic:comeDic];
    ALUserModel *theUserModel=[[ALUserModel alloc] initWithDataDic:comeDic[@"user"]];
    [theModel setTheUserModel:theUserModel];
   // [AFNconnectionImport AFNconnectionStarttest];
    return theModel;
}
-(NSString *)description{
        [self printAll:self];
    return nil;
}

@end
