//
//  ALLoginUserManager.m
//  OcnO2O
//
//  Created by OCN on 15-1-9. //

#import "ALLoginUserManager.h"
#import "DataRequest.h"
#import "APService.h"

@implementation ALLoginUserManager{
    ALUserDetailModel *_theUserDetailInfo;
    NSString *_userId;
    
    int _repeatCount;
}
AL_DEF_SINGLETON(ALLoginUserManager);
-(void)getUserInfo:(NSString *)userId
           andBack:(void(^)(ALUserDetailModel *theUserDetailInfo))theBack andReLoad:(BOOL)reLoad{
    if (reLoad) {
        [self loadUserInfoData:userId andFinish:^{
            if (theBack) {
                theBack(_theUserDetailInfo);
            }
        }];
    }else{
        if (_theUserDetailInfo==nil) {
            [self loadUserInfoData:userId andFinish:^{
                if (theBack) {
                    theBack(_theUserDetailInfo);
                }
            }];
        }
        else{
            if (theBack) {
                theBack(_theUserDetailInfo);
            }
        }
    }
}
-(void)loadUserInfoData:(NSString *)userId andFinish:(void(^)())theFinish{
    
    NSDictionary *sendDic=@{
                            @"userId":userId
                            };
    [DataRequest requestApiName:@"userCenter_getUserCenterData"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       _theUserDetailInfo=[ALUserDetailModel questionWithDict:sucContent[@"body"][@"result"]];
                       if (theFinish) {
                           theFinish();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}
-(void)userInfoClean{
    _theUserDetailInfo=nil;
    _userId=nil;
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"_userId"];
}
-(void)setUserId:(NSString *)theUserId{
    _userId=theUserId;
    [[NSUserDefaults standardUserDefaults] setValue:_userId forKey:@"_userId"];
    
//    NSString *alias=[[NSString stringWithFormat:@"mfyc%@",_userId] md5];
//    [APService setAlias:alias callbackSelector:nil object:nil];
//    [APService setTags:nil alias:alias callbackSelector:nil target:self];
    [self setUserBieMing];
}

#pragma mark - 设置别名
- (void)setUserBieMing
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"_userId"];
    if (userId.length > 0)
    {
        NSString *alias=[[NSString stringWithFormat:@"mfyc%@",userId] md5];
        [APService setAlias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    }
    else
    {
        NSLog(@"没有设置别名");
    }

}


-(void)tagsAliasCallback:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias
{
    //设置别名
    NSLog(@"设置别名 rescode: %d, \n设置别名 tags: %@, \n设置别名 alias: %@\n", iResCode, tags , alias);
    
    if (iResCode == 6002)
    {
        _repeatCount ++;
        if (_repeatCount >=2)
        {
            _repeatCount = 0;
        }
        else
        {
            [self setUserBieMing];
        }
    }
}

-(void)test:(id)sender{
    
}
-(BOOL)loginCheck{
    _userId = MBNonEmptyStringNo_([[NSUserDefaults standardUserDefaults]valueForKey:@"_userId"]);
    if (_userId&&_userId.length>0) {
        return YES;
    }else{
        return NO;
    }
}
-(NSString *)getUserId{
    if (_userId==nil) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"ToLogin" object:nil];
        _userId = MBNonEmptyStringNo_([[NSUserDefaults standardUserDefaults]valueForKey:@"_userId"]);
        return _userId;
    }else{
        return _userId;
    }
}

-(void)checkHasTestAndBlock:(void(^)(BOOL hasTest))theBlock{
    if (![[ALLoginUserManager sharedInstance] loginCheck]) {
        if (theBlock) {
            theBlock(NO);
        }
        return;
    }
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"userCenter_getUserCenterData"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       if (sucContent[@"body"][@"result"][@"user"][@"testResult"]&&[sucContent[@"body"][@"result"][@"user"][@"testResult"] length]>0) { //已经测试
                           if (theBlock) {
                               theBlock(YES);
                           }
                       }else{ //没有测试
                           if (theBlock) {
                               theBlock(NO);
                           }
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}
@end
