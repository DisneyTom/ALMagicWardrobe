//
//  ALPeriodicalsModel.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALPeriodicalsModel.h"

@implementation ALPeriodicalsModel
- (NSDictionary*)attributeMapDictionary{
    return @{
             @"content": @"content",
             @"createDate": @"createDate",
             @"createUser": @"createUser",
             @"periodicalsId": @"id",
             @"isshow": @"isshow",
             @"lead": @"lead",
             @"mainImage": @"mainImage",
             @"title": @"title"
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    return [[ALPeriodicalsModel alloc] initWithDataDic:comeDic];
}
-(NSString *)description{
    [self printAll:self];
    return nil;
}
@end
