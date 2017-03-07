//
//  NSObject+Truntimetest.m
//  tour Manager
//
//  Created by anlun on 14-8-27.
//  Copyright (c) 2014年 anlun. All rights reserved.
//

#import "NSObject+Truntimetest.h"
#import <objc/runtime.h>

@implementation NSObject (Truntimetest)
-(void)printAll:(id)obj{
    NSString * str = nil;
    str = [NSString stringWithFormat:@"\n%@:\n",object_getClass(obj)];
    str = [str stringByAppendingString:[self printStr:obj Num:0]];
    str = [NSString stringWithFormat:@"%@",str];
    NSLog(@"%@",str);
}

-(NSString *)printStr:(id)obj Num:(NSInteger)num{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    if (outCount == 0) {
        return [NSString stringWithFormat:@"%@",obj];
    }
    NSString * str = nil;
    NSString * nullStr = [self printNullStr:num];
    str = @"{";
    for (i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString * key = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        id value = [obj valueForKey:key];
        if (![value isKindOfClass:[NSString class]]) {
            [self printAll:value];
        }
        str = [NSString stringWithFormat:@"%@ \n %@%@:%@",str,nullStr,key,[self printStr:value Num:key.length + num +1]];
    }
    str = [NSString stringWithFormat:@"%@ \n %@}",str,nullStr];
    free(properties);
    return str;
}

-(NSString *)printNullStr:(NSInteger)num{
    NSString * str = @"";
    for (int i = 0 ; i<num; i++) {
        str = [str stringByAppendingString:@" "];
    }
    return str;
}
@end
