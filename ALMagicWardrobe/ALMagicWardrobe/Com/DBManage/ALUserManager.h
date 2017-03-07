//
//  ALUserManager.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-1.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  用户管理
 */
@interface ALUserManager : NSObject

//搜索用户
+ (id)searchOcnUser:(NSString *)userID;

////是否登录
//+(BOOL)IsLogin:(NSString *)userID;

//登出
+(BOOL)logout;

//获取登录的用户信息
+(id)getLoginUser;

//插入用户信息
+ (BOOL)insertOcnUserWithUserID:(NSString *)userID
                    MobilePhone:(NSString *)mobilePhone
                        IsLogin:(NSInteger)isLogin;
//更新用户信息
+ (BOOL)updateOcnUserWithUserID:(NSString *)userID
                    MobilePhone:(NSString *)mobilePhone
                        IsLogin:(NSInteger)isLogin;
//删除用户
+ (BOOL)deleteOcnUser;
@end
