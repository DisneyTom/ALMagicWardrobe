//
//  MGData_Type.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/16.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGData_Type.h"

@implementation MGData_Type
- (NSDictionary*)attributeMapDictionary{
    return @{
             @"keyFashionsId":@"id",
             @"fashionId":@"fashion_id",
             @"styleNumber": @"style_number",
             @"name": @"name",
             @"imageUrl":@"mainImage",
             @"collects": @"collects",
             @"size": @"size",
             };
}
+(instancetype)questionWithDict:(NSDictionary *)comeDic{
    return [[MGData_Type alloc] initWithDataDic:comeDic];
}
-(NSString *)description{
    [self printAll:self];
    return nil;
}
@end
