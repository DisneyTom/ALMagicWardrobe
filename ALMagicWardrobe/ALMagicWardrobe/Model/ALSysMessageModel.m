//
//  ALSysMessageModel.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-28.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALSysMessageModel.h"

@implementation ALSysMessageModel
- (NSDictionary*)attributeMapDictionary{
    return @{
             @"sysMessageId": @"id",
             @"userId": @"userId",
             @"message": @"message",
             @"opentype": @"opentype",
             @"createdate": @"createdate"
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    return [[ALSysMessageModel alloc] initWithDataDic:comeDic];
}
-(NSString *)description{
    [self printAll:self];
    return nil;
}
@end
