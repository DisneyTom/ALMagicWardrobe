//
//  ALClothsDetailModel.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALClothsDetailModel.h"

@implementation ALClothsDetailModel
- (NSDictionary*)attributeMapDictionary{
    return @{
             @"color": @"color",
             @"clothsDescription": @"description",
             @"clothsId": @"id",
             @"images": @"images",
             @"isStick": @"isStick",
             @"mainImage": @"mainImage",
             @"name": @"name",
             @"size": @"size",
             @"styleNumber": @"styleNumber",
             @"type": @"type",
             @"isSale":@"isSale",
             @"collection":@"collection",
             @"selectSize":@"selectSize",
             @"selectColor":@"selectColor",
             @"isCollected":@"isCollected",
             @"assortFashions":@"assortFashions",
             @"fashionSize":@"fashionSize"
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    return [[ALClothsDetailModel alloc] initWithDataDic:comeDic];
}
-(NSString *)description{
    [self printAll:self];
    return nil;
}
@end
