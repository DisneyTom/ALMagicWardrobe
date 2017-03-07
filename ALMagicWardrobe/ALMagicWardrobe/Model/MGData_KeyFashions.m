//
//  MGData_KeyFashions.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/6/23.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGData_KeyFashions.h"

@implementation MGData_KeyFashions
- (NSDictionary*)attributeMapDictionary{
    return @{
              @"keyFashionsId":@"id",
              @"fashionId":@"fashion_id",
             @"styleNumber": @"style_number",
             @"name": @"name",
              @"imageUrl":@"mainImage",
             @"collects": @"collects",
               @"size": @"size",
               @"saleTime": @"saleTime",
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    return [[MGData_KeyFashions alloc] initWithDataDic:comeDic];
}
-(NSString *)description{
    [self printAll:self];
    return nil;
}
@end
