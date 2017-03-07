//
//  OcnCacheTool.m
//  OcnO2O
//
//  Created by anLun on 15-1-17.
//  Copyright (c) 2015年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import "OcnCacheTool.h"
#import "FMDB.h"

#define OcnIndexIndexCachePath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"OcnIndexIndex.sqlite"])

static FMDatabaseQueue *_theIndexQueue;

@implementation OcnCacheTool

AL_DEF_SINGLETON(OcnCacheTool);

+(void)initialize{
    [super initialize];
    _theIndexQueue=[FMDatabaseQueue databaseQueueWithPath:OcnIndexIndexCachePath];
}
/*
-(void)addIndexIndexCache:(NSDictionary *)indexDic{
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        //1.创建表
        BOOL result1=  [db executeUpdate:@"create table if not exists t_index (id integer primary key autoincrement,uniqueCode text,indexDic blob);"];
        if (result1) {
            NSLog(@"创建表成功");
        }
        else{
            NSLog(@"创建表失败");
        }
        
        // 2.存储数据
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        NSData *theIndexData=[NSKeyedArchiver archivedDataWithRootObject:indexDic];
       BOOL result2= [db executeUpdate:@"insert into t_index(uniqueCode,indexDic) values(?,?);",uniqueCode,theIndexData];
        
        if (result2) {
            NSLog(@"插入数据成功");
        }
        else{
            NSLog(@"插入数据失败");
        }
    }];
}

-(NSDictionary *)indexIndexCache{
    NSLog(@"path=%@",OcnIndexIndexCachePath);
    
    __block NSDictionary *indexDic;
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        FMResultSet *fs=[db executeQuery:@"select * from t_index where uniqueCode = ?;",uniqueCode];
        if ([fs next]) {
            indexDic=[NSKeyedUnarchiver unarchiveObjectWithData:[fs dataForColumn:@"indexDic"]];
        }
    }];
    return indexDic;
}

-(void)addShopListIndustryCache:(NSDictionary *)shopListIndustryDic{
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        //1.创建表
        BOOL result1=  [db executeUpdate:@"create table if not exists t_shoplistIndustry (id integer primary key autoincrement,uniqueCode text,shopListIndustryDic blob);"];
        if (result1) {
            NSLog(@"创建表成功");
        }
        else{
            NSLog(@"创建表失败");
        }
        
        // 2.存储数据
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        
        //清空数据
        BOOL result=  [db executeUpdate:@"delete from t_shoplistIndustry where uniqueCode = ?;",uniqueCode];
        if (result) {
            NSLog(@"清空成功");
        }
        
        NSData *theshopListIndustryData=[NSKeyedArchiver archivedDataWithRootObject:shopListIndustryDic];
        BOOL result2= [db executeUpdate:@"insert into t_shoplistIndustry(uniqueCode,shopListIndustryDic) values(?,?);",uniqueCode,theshopListIndustryData];
        
        if (result2) {
            NSLog(@"插入数据成功");
        }
        else{
            NSLog(@"插入数据失败");
        }
    }];
}

-(NSDictionary *)shopListIndustryCache{
    NSLog(@"path=%@",OcnIndexIndexCachePath);
    
    __block NSDictionary *shopListIndustryDic;
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        
        FMResultSet *fs=[db executeQuery:@"select * from t_shoplistIndustry where uniqueCode = ?;",uniqueCode];
        if ([fs next]) {
            shopListIndustryDic=[NSKeyedUnarchiver unarchiveObjectWithData:[fs dataForColumn:@"shopListIndustryDic"]];
        }
    }];
    return shopListIndustryDic;
}

-(void)addShopPageCache:(NSDictionary *)shopPageDic andToken:(NSDictionary *)params{
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        //1.创建表
        BOOL result1=  [db executeUpdate:@"create table if not exists t_shoppage (id integer primary key autoincrement,uniqueCode text,shoppageDic blob);"];
        if (result1) {
            NSLog(@"创建表成功");
        }
        else{
            NSLog(@"创建表失败");
        }
        
        // 2.存储数据
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        
        NSString *token=[NSString stringWithFormat:@"%@",[NSKeyedArchiver archivedDataWithRootObject:params]];
        uniqueCode=[NSString stringWithFormat:@"%@%@",uniqueCode,token];
        
        //清空数据
        BOOL result=  [db executeUpdate:@"delete from t_shoppage where uniqueCode = ?;",uniqueCode];
        if (result) {
            NSLog(@"清空成功");
        }
        
        NSData *theshopListIndustryData=[NSKeyedArchiver archivedDataWithRootObject:shopPageDic];
        BOOL result2= [db executeUpdate:@"insert into t_shoppage(uniqueCode,shoppageDic) values(?,?);",uniqueCode,theshopListIndustryData];
        
        if (result2) {
            NSLog(@"插入数据成功");
        }
        else{
            NSLog(@"插入数据失败");
        }
    }];

}

-(NSDictionary *)shopPageCacheAndToken:(NSDictionary *)params{
    NSLog(@"path=%@",OcnIndexIndexCachePath);
    
    __block NSDictionary *shopPageDic;
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        
        NSString *token=[NSString stringWithFormat:@"%@",[NSKeyedArchiver archivedDataWithRootObject:params]];
        uniqueCode=[NSString stringWithFormat:@"%@%@",uniqueCode,token];

        
        FMResultSet *fs=[db executeQuery:@"select * from t_shoppage where uniqueCode = ?;",uniqueCode];
        if ([fs next]) {
            shopPageDic=[NSKeyedUnarchiver unarchiveObjectWithData:[fs dataForColumn:@"shoppageDic"]];
        }
    }];
    return shopPageDic;
}

-(void)addCouponPageCache:(NSDictionary *)couponPageDic andToken:(NSDictionary *)params{
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        //1.创建表
        BOOL result1=  [db executeUpdate:@"create table if not exists t_couponpage (id integer primary key autoincrement,uniqueCode text,couponpageDic blob);"];
        if (result1) {
            NSLog(@"创建表成功");
        }
        else{
            NSLog(@"创建表失败");
        }
        
        // 2.存储数据
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        NSString *token=[NSString stringWithFormat:@"%@",[NSKeyedArchiver archivedDataWithRootObject:params]];
        uniqueCode=[NSString stringWithFormat:@"%@%@",uniqueCode,token];
        
        //清空数据
        BOOL result=  [db executeUpdate:@"delete from t_couponpage where uniqueCode = ?;",uniqueCode];
        if (result) {
            NSLog(@"清空成功");
        }
        
        NSData *theshopListIndustryData=[NSKeyedArchiver archivedDataWithRootObject:couponPageDic];
        BOOL result2= [db executeUpdate:@"insert into t_couponpage(uniqueCode,couponpageDic) values(?,?);",uniqueCode,theshopListIndustryData];
        
        if (result2) {
            NSLog(@"插入数据成功");
        }
        else{
            NSLog(@"插入数据失败");
        }
    }];

}
-(NSDictionary *)couponPageCacheAndToken:(NSDictionary *)params{
    NSLog(@"path=%@",OcnIndexIndexCachePath);
    
    __block NSDictionary *shopPageDic;
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        
        NSString *token=[NSString stringWithFormat:@"%@",[NSKeyedArchiver archivedDataWithRootObject:params]];
        uniqueCode=[NSString stringWithFormat:@"%@%@",uniqueCode,token];

        
        FMResultSet *fs=[db executeQuery:@"select * from t_couponpage where uniqueCode = ?;",uniqueCode];
        if ([fs next]) {
            shopPageDic=[NSKeyedUnarchiver unarchiveObjectWithData:[fs dataForColumn:@"couponpageDic"]];
        }
    }];
    return shopPageDic;

}

-(void)addActivityPageCache:(NSDictionary *)activityPageDic andToken:(NSDictionary *)params{
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        //1.创建表
        BOOL result1=  [db executeUpdate:@"create table if not exists t_activitypage (id integer primary key autoincrement,uniqueCode text,activitypageDic blob);"];
        if (result1) {
            NSLog(@"创建表成功");
        }
        else{
            NSLog(@"创建表失败");
        }
        
        // 2.存储数据
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        
        NSString *token=[NSString stringWithFormat:@"%@",[NSKeyedArchiver archivedDataWithRootObject:params]];
        uniqueCode=[NSString stringWithFormat:@"%@%@",uniqueCode,token];

        
        //清空数据
        BOOL result=  [db executeUpdate:@"delete from t_activitypage where uniqueCode = ?;",uniqueCode];
        if (result) {
            NSLog(@"清空成功");
        }
        
        NSData *theshopListIndustryData=[NSKeyedArchiver archivedDataWithRootObject:activityPageDic];
        BOOL result2= [db executeUpdate:@"insert into t_activitypage(uniqueCode,activitypageDic) values(?,?);",uniqueCode,theshopListIndustryData];
        
        if (result2) {
            NSLog(@"插入数据成功");
        }
        else{
            NSLog(@"插入数据失败");
        }
    }];

}

-(NSDictionary *)activityPageCacheAndToken:(NSDictionary *)params{
    NSLog(@"path=%@",OcnIndexIndexCachePath);
    
    __block NSDictionary *shopPageDic;
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        
        NSString *token=[NSString stringWithFormat:@"%@",[NSKeyedArchiver archivedDataWithRootObject:params]];
        uniqueCode=[NSString stringWithFormat:@"%@%@",uniqueCode,token];
        
        FMResultSet *fs=[db executeQuery:@"select * from t_activitypage where uniqueCode = ?;",uniqueCode];
        if ([fs next]) {
            shopPageDic=[NSKeyedUnarchiver unarchiveObjectWithData:[fs dataForColumn:@"activitypageDic"]];
        }
    }];
    return shopPageDic;
}

-(void)addShopListIndustryClassifyCache:(NSDictionary *)listIndustryClassifyDic andToken:(NSDictionary *)params{
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        //1.创建表
        BOOL result1=  [db executeUpdate:@"create table if not exists t_listIndustryClassify (id integer primary key autoincrement,uniqueCode text,listIndustryClassifyDic blob);"];
        if (result1) {
            NSLog(@"创建表成功");
        }
        else{
            NSLog(@"创建表失败");
        }
        
        // 2.存储数据
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        
        NSString *token=[NSString stringWithFormat:@"%@",[NSKeyedArchiver archivedDataWithRootObject:params]];
        uniqueCode=[NSString stringWithFormat:@"%@%@",uniqueCode,token];
        
        
        //清空数据
        BOOL result=  [db executeUpdate:@"delete from t_listIndustryClassify where uniqueCode = ?;",uniqueCode];
        if (result) {
            NSLog(@"清空成功");
        }
        
        NSData *theshopListIndustryData=[NSKeyedArchiver archivedDataWithRootObject:listIndustryClassifyDic];
        BOOL result2= [db executeUpdate:@"insert into t_listIndustryClassify(uniqueCode,listIndustryClassifyDic) values(?,?);",uniqueCode,theshopListIndustryData];
        
        if (result2) {
            NSLog(@"插入数据成功");
        }
        else{
            NSLog(@"插入数据失败");
        }
    }];

}
-(NSDictionary *)shopListIndustryClassifyCacheAndToken:(NSDictionary *)params{
    NSLog(@"path=%@",OcnIndexIndexCachePath);
    
    __block NSDictionary *shopPageDic;
    [_theIndexQueue inDatabase:^(FMDatabase *db) {
        
        NSDictionary *user=[DBManage getLoginUser];
        NSString *uniqueCode=@"allIndex";
        if ([DBManage IsLogin:user[@"OcnUserID"]]) {
            uniqueCode=[SRUtils md5:[NSString stringWithFormat:@"%@%@",user[@"OcnUserID"],[SRUtils uuid]]];
        }
        
        NSString *token=[NSString stringWithFormat:@"%@",[NSKeyedArchiver archivedDataWithRootObject:params]];
        uniqueCode=[NSString stringWithFormat:@"%@%@",uniqueCode,token];
        
        FMResultSet *fs=[db executeQuery:@"select * from t_listIndustryClassify where uniqueCode = ?;",uniqueCode];
        if ([fs next]) {
            shopPageDic=[NSKeyedUnarchiver unarchiveObjectWithData:[fs dataForColumn:@"listIndustryClassifyDic"]];
        }
    }];
    return shopPageDic;
}
 */
@end
