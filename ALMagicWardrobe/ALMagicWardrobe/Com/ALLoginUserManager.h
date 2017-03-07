//
//  ALLoginUserManager.h
//  OcnO2O
//
//  Created by OCN on 15-1-9. 
//

#import <Foundation/Foundation.h>
#import "ALUserDetailModel.h"
/**
 *  用户管理
 */
@interface ALLoginUserManager : NSObject
AL_AS_SINGLETON(ALLoginUserManager);
/**
 *  获得用户详情
 *
 *  @param userId 用户id
 *
 *  @param theBack 回调block
 */
-(void)getUserInfo:(NSString *)userId
           andBack:(void(^)(ALUserDetailModel *theUserDetailInfo))theBack andReLoad:(BOOL)reLoad;
-(void)userInfoClean;
-(void)setUserId:(NSString *)theUserId;
-(BOOL)loginCheck;
-(NSString *)getUserId;
//检查是否做过测试
-(void)checkHasTestAndBlock:(void(^)(BOOL hasTest))theBlock;

#pragma mark - 设置别名
- (void)setUserBieMing;
@end
