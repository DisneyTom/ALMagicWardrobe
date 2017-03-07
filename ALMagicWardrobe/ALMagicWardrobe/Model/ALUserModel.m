//
//  ALUserModel.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-27.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALUserModel.h"

@implementation ALUserModel
- (NSDictionary*)attributeMapDictionary{
    return @{
             @"userId": @"id",
             @"nickname": @"nickname",
             @"username": @"username",
             @"userpic": @"userpic",
             @"usertel": @"usertel"
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    return [[ALUserModel alloc] initWithDataDic:comeDic];
}
-(NSString *)description{
    [self printAll:self];
    return nil;
}

@end
