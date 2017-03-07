//
//  ALDBManage.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-1.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALDBManage.h"
#define OcnALDBCachePath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"ALDBManage.sqlite"])
static FMDatabaseQueue *_theALDBQueue;
@implementation ALDBManage
+(ALDBManage *)sharedInstance{
    static dispatch_once_t once;
    static ALDBManage * singleton;
    dispatch_once(&once, ^{
        singleton=[ALDBManage databaseQueueWithPath:OcnALDBCachePath];
        [singleton createTable];
    });
    return singleton;
}
- (void)createTable {
    NSArray *tableNames = @[@"OcnUser",@"SearchRecords"];
    NSDictionary *sqlCreateTables = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"CREATE TABLE 'OcnUser' ('ID' INTEGER PRIMARY KEY NOT NULL, 'OcnUserID' Text,  'MobilePhone' Text)",@"OcnUser",
                                     @"CREATE TABLE 'SearchRecords' ('ID' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'SearchRecord' TEXT, 'CreatedTime' TIMESTAMP DEFAULT (datetime('now','localtime')))",@"SearchRecords",nil];
    
    for (NSString *tableName in tableNames) {
        if (![self isTableOK:tableName]) {
            NSString *sql = [sqlCreateTables objectForKey:tableName];
            NSLog(@"创建表%@",tableName);
            [self inDatabase:^(FMDatabase *db) {
                [db executeUpdate:sql];
            }];
        }
    }
}

// 检查表是否已经存在
- (BOOL)isTableOK:(NSString *)tableName {
    __block BOOL isHasTable=NO;
    [self inDatabase:^(FMDatabase *db) {
        FMResultSet * set = [db executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",tableName]];
        [set next];
        NSInteger count = [set intForColumnIndex:0];
        BOOL existTable = !!count;
        
        if (existTable) {
            NSLog(@"%@表已经存在",tableName);
            isHasTable=YES;
        } else {
            NSLog(@"%@表不存在",tableName);
            isHasTable=NO;
        }
    }];
    return isHasTable;
}
@end
