//
//  DBManage+SearchRecords.m
//  OcnO2O
//
//  Created by 紫月 on 14-10-22.
//  Copyright (c) 2014年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import "DBManage+SearchRecords.h"

@implementation DBManage (SearchRecords)

+ (BOOL)insertSearchRecord:(NSString *)searchRecord {
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Insert Into SearchRecords ('SearchRecord') Values ('%@')",searchRecord];
    return [dbManage insertWithSQLStr:sql];
}

+ (id)selectSearchRecords {
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Select * From SearchRecords Order By CreatedTime Desc"];
    FMResultSet *rs = [dbManage selectWithSQLStr:sql];
    NSMutableArray *recordArray = [NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary *recordDic = [NSMutableDictionary dictionary];
        for (NSInteger i = 0; i < rs.columnCount; i ++) {
            NSString *key = [rs columnNameForIndex:i];
            NSString *valus = [NSString stringWithFormat:@"%@",[rs stringForColumn:key]];
            [recordDic setObject:valus forKey:key];
        }
        [recordArray addObject:recordDic];
    }
    return recordArray.count==0 ? nil:recordArray;
}

+ (id)selectWithSearchRecord:(NSString *)searchRecord {
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Select * From SearchRecords Where SearchRecord = '%@'",searchRecord];
    FMResultSet *rs = [dbManage selectWithSQLStr:sql];
    NSMutableArray *recordArray = [NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary *recordDic = [NSMutableDictionary dictionary];
        for (NSInteger i = 0; i < rs.columnCount; i ++) {
            NSString *key = [rs columnNameForIndex:i];
            NSString *valus = [NSString stringWithFormat:@"%@",[rs stringForColumn:key]];
            [recordDic setObject:valus forKey:key];
        }
        [recordArray addObject:recordDic];
    }
    return recordArray.count==0 ? nil:recordArray;
}

+ (BOOL)deleteWithSearchRecord:(NSString *)searchRecord {
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Delete From SearchRecords Where SearchRecord = '%@'",searchRecord];
    return [dbManage deleteWithSQLStr:sql];
}

+ (BOOL)deleteSearchRecordsWithSqlMinID {
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Delete From SearchRecords Where ID In (Select ID From SearchRecords Limit 0,1)"];
    return [dbManage deleteWithSQLStr:sql];
}

+ (BOOL)deleteAllSearchRecords {
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Delete From SearchRecords"];
    return [dbManage deleteWithSQLStr:sql];
}

@end
