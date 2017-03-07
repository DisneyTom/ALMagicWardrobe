//
//  ALClothsModel.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALClothsModel.h"

@implementation ALClothsModel
- (NSDictionary*)attributeMapDictionary{
    return @{
             @"collects": @"collects",
             @"clothsDescription": @"description",
             @"clothsId": @"id",
             @"mainImage": @"mainImage",
             @"name": @"name",
             @"styleNumber": @"styleNumber",
             @"type": @"type"
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    return [[ALClothsModel alloc] initWithDataDic:comeDic];
}
-(NSString *)description{
    [self printAll:self];
    return nil;
}
@end
