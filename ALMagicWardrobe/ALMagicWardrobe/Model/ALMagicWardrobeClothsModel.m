//
//  ALMagicWardrobeClothsModel.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicWardrobeClothsModel.h"

@implementation ALMagicWardrobeClothsModel
- (NSDictionary*)attributeMapDictionary{
    return @{
             @"fashion_id": @"fashion_id",
             @"fashion_type": @"fashion_type",
             @"mwColothsId": @"id",
             @"isabandon": @"isabandon",
             @"main_image": @"main_image",
             @"name": @"name",
             @"user_id": @"user_id"
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    return [[ALMagicWardrobeClothsModel alloc] initWithDataDic:comeDic];
}
-(NSString *)description{
    [self printAll:self];
    return nil;
}
@end
