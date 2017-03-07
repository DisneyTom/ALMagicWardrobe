//
//  ALAddressModel.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-28.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALAddressModel.h"

@implementation ALAddressModel
- (NSDictionary*)attributeMapDictionary{
    return @{
             @"address": @"address",
             @"addresstitle": @"addresstitle",
             @"area": @"area",
             @"city": @"city",
             @"addressId": @"id",
             @"isdefault": @"isdefault",
             @"linkman": @"linkman",
             @"postcode": @"postcode",
             @"province": @"province",
             @"tel": @"tel",
             @"usreId": @"usreId"
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    return [[ALAddressModel alloc] initWithDataDic:comeDic];
}
-(NSString *)description{
        [self printAll:self];
    return nil;
}

@end
