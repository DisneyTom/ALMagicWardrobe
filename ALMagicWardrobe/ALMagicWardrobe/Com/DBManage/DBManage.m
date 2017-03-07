//
//  DBManage.m
//  HanChuangScience
//
//  Created by yy on 13-12-5.
//  Copyright (c) 2013年 张 如毅. All rights reserved.
//

#import "DBManage.h"

#define DefaultDBName @"OcnO2O.sqlite"

static DBManage *_dbManage = nil;

@implementation DBManage

+ (DBManage *) standarDBManage {
	if (!_dbManage) {
		_dbManage = [[DBManage alloc] init];
	}
	return _dbManage;
}

- (void) dealloc {
    [self close];
}

- (id) init {
    self = [super init];
    if (self) {
        int state = [self initializeDBWithName:DefaultDBName];
        if (state == -1) {
            NSLog(@"数据库初始化失败");
        } else {
            NSLog(@"数据库初始化成功");
            [self createTable];
        }
    }
    return self;
}

/**
 * @brief 初始化数据库操作
 * @param name 数据库名称
 * @return 返回数据库初始化状态， 0 为 已经存在，1 为创建成功，-1 为创建失败
 */
- (int) initializeDBWithName : (NSString *) name {
    if (!name) {
		return -1;  // 返回数据库创建失败
	}
    // 沙盒Docu目录
    NSString * docp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    _name=[docp stringByAppendingPathComponent:name];
	NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:_name];
    [self connect];
    if (!exist) {
        return 0;
    } else {
        return 1;          // 返回 数据库已经存在
	}
}

// 连接数据库
- (void) connect {
	if (!_dataBase) {
		_dataBase = [[FMDatabase alloc] initWithPath:_name];
	}
	if (![_dataBase open]) {
		NSLog(@"不能打开数据库");
	}
}

// 关闭连接
- (void) close {
	[_dataBase close];
    _dbManage = nil;
}

- (void)createTable {
    NSArray *tableNames = @[@"OcnUser",@"SearchRecords"];
    NSDictionary *sqlCreateTables = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"CREATE TABLE 'OcnUser' ('ID' INTEGER PRIMARY KEY NOT NULL, 'OcnUserID' Text, 'UserName' Text, 'NickName' Text, 'MobilePhone' Text, 'UserImg' Text,'IsLogin' Inetger,'SEX' Inetger,'Birthday' Text,'QQID' Text,'QQToken' Text,'WeiboID' Text,'WeiboToken' Text,'WeixinID' Text,'WeixinToken' Text)",@"OcnUser",
                                     @"CREATE TABLE 'SearchRecords' ('ID' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'SearchRecord' TEXT, 'CreatedTime' TIMESTAMP DEFAULT (datetime('now','localtime')))",@"SearchRecords",nil];

    for (NSString *tableName in tableNames) {
        if (![self isTableOK:tableName]) {
            NSString *sql = [sqlCreateTables objectForKey:tableName];
            NSLog(@"创建表%@",tableName);
            if ([_dataBase executeUpdate:sql]) {
                NSLog(@"成功");
            } else {
                NSLog(@"失败");
            }
        }
    }
}

// 检查表是否已经存在
- (BOOL)isTableOK:(NSString *)tableName {
    FMResultSet * set = [_dataBase executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",tableName]];
    [set next];
    NSInteger count = [set intForColumnIndex:0];
    BOOL existTable = !!count;
    
    if (existTable) {
        NSLog(@"%@表已经存在",tableName);
        return YES;
    } else {
        NSLog(@"%@表不存在",tableName);
        return NO;
    }
}

//查询数据
- (FMResultSet*)selectWithSQLStr:(NSString*)sql {
    FMResultSet *rs = [_dataBase executeQuery:sql];
    return rs;
}

// 插入数据
- (BOOL)insertWithSQLStr:(NSString*)sql {
    return [_dataBase executeUpdate:sql];
}

// 修改数据
- (BOOL)updateWithSQLStr:(NSString*)sql {
    return [_dataBase executeUpdate:sql];
}

// 删除数据
- (BOOL)deleteWithSQLStr:(NSString*)sql {
    return [_dataBase executeUpdate:sql];
}

@end
