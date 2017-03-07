//
//  DBManage+OcnUser.h
//  OcnO2O
//
//  Created by 紫月 on 14-8-14.
//  Copyright (c) 2014年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import "DBManage.h"

@interface DBManage (OcnUser)

//搜索Ocn用户
+ (id)searchOcnUser:(NSString *)userID;
//是否登录
+(BOOL)IsLogin:(NSString *)userID;
//登出
+(BOOL)logout;
//获取登录的用户信息
+(id)getLoginUser;
//插入Ocn用户信息
+ (BOOL)insertOcnUserWithUserID:(NSString *)userID
                       UserName:(NSString *)userName
                       NickName:(NSString *)nickName
                    MobilePhone:(NSString *)mobilePhone
                        UserImg:(NSString *)userImg
                            Sex:(NSInteger)sex
                       Birthday:(NSString *)birthday
                        IsLogin:(NSInteger)isLogin;
//更新Ocn用户信息
+ (BOOL)updateOcnUserWithUserID:(NSString *)userID
                       NickName:(NSString *)nickName
                    MobilePhone:(NSString *)mobilePhone
                        UserImg:(NSString *)userImg
                            Sex:(NSInteger)sex
                       Birthday:(NSString *)birthday
                        IsLogin:(NSInteger)isLogin;

//删除Ocn用户
+ (BOOL)deleteOcnUser;

@end
