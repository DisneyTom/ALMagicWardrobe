//
//  DBManage+SearchRecords.h
//  OcnO2O
//
//  Created by 紫月 on 14-10-22.
//  Copyright (c) 2014年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import "DBManage.h"

@interface DBManage (SearchRecords)

+ (id)selectSearchRecords;
+ (id)selectWithSearchRecord:(NSString *)searchRecord;
+ (BOOL)insertSearchRecord:(NSString *)searchRecord;
+ (BOOL)deleteWithSearchRecord:(NSString *)searchRecord;
+ (BOOL)deleteSearchRecordsWithSqlMinID;
+ (BOOL)deleteAllSearchRecords;

@end
