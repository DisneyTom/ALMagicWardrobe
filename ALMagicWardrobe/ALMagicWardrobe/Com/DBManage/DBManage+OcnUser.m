//
//  DBManage+OcnUser.m
//  OcnO2O
//
//  Created by 紫月 on 14-8-14.
//  Copyright (c) 2014年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import "DBManage+OcnUser.h"

@implementation DBManage (OcnUser)

+(BOOL)IsLogin:(NSString *)userID{
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Select count(*) From OcnUser where OcnUserID = '%@' and isLogin = 1",userID];
    
    FMResultSet *rs = [dbManage selectWithSQLStr:sql];
    if([rs next]){
        return [rs boolForColumnIndex:0];
    }
    return NO;
}

+(BOOL)logout{
    DBManage *dbManage = [DBManage standarDBManage];
    return [dbManage updateWithSQLStr:@"Update OcnUser Set IsLogin=0"];
}

+ (id)getLoginUser{
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Select * From OcnUser where isLogin = 1"];
    FMResultSet *rs = [dbManage selectWithSQLStr:sql];
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionary];
    while ([rs next]) {
        for (NSInteger i = 0; i < rs.columnCount; i ++) {
            NSString *key = [rs columnNameForIndex:i];
            NSString *valus = [NSString stringWithFormat:@"%@",[rs stringForColumn:key]];
            [recordDic setObject:valus forKey:key];
        }
    }
    return recordDic;
}

+ (id)searchOcnUser:(NSString *)userID{
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Select * From OcnUser where OcnUserID = '%@'",userID];
    FMResultSet *rs = [dbManage selectWithSQLStr:sql];
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionary];
    while ([rs next]) {
        for (NSInteger i = 0; i < rs.columnCount; i ++) {
            NSString *key = [rs columnNameForIndex:i];
            NSString *valus = [NSString stringWithFormat:@"%@",[rs stringForColumn:key]];
            [recordDic setObject:valus forKey:key];
        }
    }
    //    NSLog(@"%@",recordDic);
    return recordDic;
}

+ (BOOL)insertOcnUserWithUserID:(NSString *)userID
                       UserName:(NSString *)userName
                       NickName:(NSString *)nickName
                    MobilePhone:(NSString *)mobilePhone
                        UserImg:(NSString *)userImg
                            Sex:(NSInteger)sex
                       Birthday:(NSString *)birthday
                        IsLogin:(NSInteger)isLogin {
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql=[NSString stringWithFormat:@"Insert Into OcnUser ('OcnUserID','UserName','NickName','MobilePhone','UserImg','IsLogin','Sex',birthday) Values ('%@','%@','%@','%@','%@','%d','%d','%@')",userID,userName,nickName,mobilePhone,userImg,isLogin,sex,birthday];
    return [dbManage insertWithSQLStr:sql];
}

+ (BOOL)updateOcnUserWithUserID:(NSString *)userID NickName:(NSString *)nickName MobilePhone:(NSString *)mobilePhone UserImg:(NSString *)userImg Sex:(NSInteger)sex Birthday:(NSString *)birthday IsLogin:(NSInteger)isLogin{
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Update OcnUser Set NickName = '%@', mobilePhone = '%@', UserImg = '%@',IsLogin='%d',Sex='%d',Birthday ='%@' Where OcnUserID = '%@'",nickName,mobilePhone,userImg,isLogin,sex,birthday,userID];
    return [dbManage updateWithSQLStr:sql];
}

+ (BOOL)deleteOcnUser {
    DBManage *dbManage = [DBManage standarDBManage];
    NSString *sql = [NSString stringWithFormat:@"Delete From OcnUser"];
    return [dbManage deleteWithSQLStr:sql];
}

@end
