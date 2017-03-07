//
//  DBManage.h
//  HanChuangScience
//
//  Created by yy on 13-12-5.
//  Copyright (c) 2013年 张 如毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DBManage : NSObject

{
    NSString * _name;
}

@property (nonatomic, readonly) FMDatabase * dataBase;  // 数据库操作对象

+ (DBManage *)standarDBManage;

//查询数据
- (FMResultSet*)selectWithSQLStr:(NSString*)sql;

// 插入数据
- (BOOL)insertWithSQLStr:(NSString*)sql;

// 修改数据
- (BOOL)updateWithSQLStr:(NSString*)sql;

// 删除数据
- (BOOL)deleteWithSQLStr:(NSString*)sql;

@end
