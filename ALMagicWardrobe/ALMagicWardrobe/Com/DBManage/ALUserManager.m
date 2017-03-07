//
//  ALUserManager.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-1.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALUserManager.h"
#import "ALDBManage.h"
@implementation ALUserManager
+(id)getLoginUser{
    __block NSDictionary *recordDic=nil;
    [[ALDBManage sharedInstance] inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"Select * From OcnUser where isLogin = 1"];
        FMResultSet *rs = [db executeQuery:sql];
        NSMutableDictionary *recordDic = [NSMutableDictionary dictionary];
        while ([rs next]) {
            for (NSInteger i = 0; i < rs.columnCount; i ++) {
                NSString *key = [rs columnNameForIndex:i];
                NSString *valus = [NSString stringWithFormat:@"%@",[rs stringForColumn:key]];
                [recordDic setObject:valus forKey:key];
            }
        }
    }];
    return recordDic;
}
@end
