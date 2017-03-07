//
//  ALMagicShowModel.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-4-8.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicShowModel.h"

@implementation ALMagicShowModel
- (NSDictionary*)attributeMapDictionary{
    return @{
             @"contents": @"contents",
             @"createTime": @"createTime",
             @"expressId": @"expressId",
             @"magicShowId": @"id",
             @"imageurls": @"imageurls",
             @"magicId": @"magicId",
             @"userId": @"userId"
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    return [[ALMagicShowModel alloc] initWithDataDic:comeDic];
}
-(NSString *)description{
    [self printAll:self];
    return nil;
}

@end
