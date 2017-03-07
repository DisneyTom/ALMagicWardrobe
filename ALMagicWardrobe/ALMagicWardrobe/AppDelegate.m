//
//  AppDelegate.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "AppDelegate.h"

#import "ALTabBarViewController.h"
#import "ALComAction.h"

//#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "WeiboSDK.h"
//#import "WeiboApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "APService.h"
#import "WXApi.h"
#import "DataRequest.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlipyInfo.h"
#import "MobClick.h"
#import "ALLoginUserManager.h"
#import "ALSystemMessageViewController.h"

#define kPushNotification   @"kPushNotification" //发送push 推送

typedef void(^theSecLoginBlock)(id sender);

@interface AppDelegate()
<TencentSessionDelegate,WeiboSDKDelegate>
@end

@implementation AppDelegate{
    TencentOAuth *theTencentOAuth;
    theSecLoginBlock theWXBlock;
    theSecLoginBlock theQQBlock;
    theSecLoginBlock theWBBlock;
    ALImageView * adImgView;
    NSDictionary* dict_Im;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self _loadGetSysConfigAndBlock:^{
        
        if ([dict_Im[@"configvalue"]isEqualToString:@"Y"])
        {
            [MobClick checkUpdate:@"发现新版本" cancelButtonTitle:@"取消" otherButtonTitles:@"下载新版本"];
        }
        
    }];
    
  ///  [AFNconnectionImport AFNconnectionStarttest];
    //=============极光推送==========start
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                       UIUserNotificationTypeSound |
//                                                       UIUserNotificationTypeAlert)
//                                           categories:nil];
//        
//    } else {
//        //categories 必须为nil
//        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                       UIRemoteNotificationTypeSound |
//                                                       UIRemoteNotificationTypeAlert)
//                                           categories:nil];
//    }
//#else
//    //categories 必须为nil
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)
//                                       categories:nil];
//#endif
    // Required
    [APService setupWithOption:launchOptions];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];


    //=============极光推送==========end
    
//    [APService
//     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                         UIRemoteNotificationTypeSound|
//                                         UIRemoteNotificationTypeAlert)
//     categories:nil];
    
    //注册消息推送的功能；
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
    
    // Required

    NSDictionary* dict = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (!dict)
    {
        _mainTabBarCtrl = [ALTabBarViewController shareALTabBarVC];
        self.window.rootViewController = _mainTabBarCtrl;
    }
    else
    {
      
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"messageStatu"];
        if (![[[ALLoginUserManager sharedInstance] getUserId]isEqualToString:@""])
        {
            UINavigationController* naviCtrl_ = [[UINavigationController alloc]initWithRootViewController:[[ALSystemMessageViewController alloc]init]];
            self.window.rootViewController = naviCtrl_;
        }
        else
        {
            _mainTabBarCtrl = [ALTabBarViewController shareALTabBarVC];
            self.window.rootViewController = _mainTabBarCtrl;
        }

    }
   // [AFNconnectionImport connectionWifi];
    [self.window makeKeyAndVisible];

    
    
    //****shareSDK
//    [ShareSDK registerApp:@"783b9ac2495"];
//    [ShareSDK registerApp:getTxt(@"ShareSDKAppKey")];
//    [self initializePlat];
    
//    [WXApi registerApp:@"wx00118fe125d59786" withDescription:@"魔法衣橱"];
    
    //分享相关
  // [self initSecond];
    
    [MobClick startWithAppkey:@"556d742967e58ec4fc002bc9" reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    [MobClick setLogEnabled:NO];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少ios消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
   // [MobClick checkUpdate];
    
    __block AppDelegate *theDelegate=self;
    
    NSInteger indexShow = [[NSUserDefaults standardUserDefaults]integerForKey:@"showStartImage"];

    if (indexShow==0) {
        //启动引导页
        _guideView = [[MBGuideView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _guideView.backgroundColor = [UIColor yellowColor];
        _guideView.delegate = self;
        [_guideView setTheBlock:^(id sender){
            MBGuideView *theView=sender;
            [theView removeFromSuperview];
//            [theDelegate _getStartImageAndBlock:^(NSString *imgUrl) {
//                [theDelegate showADImgView:imgUrl];
//            }];
        }];
        [self.window addSubview:_guideView];
        indexShow++;
        [[NSUserDefaults standardUserDefaults] setInteger:indexShow forKey:@"showStartImage"];
        
        [self loadStartViewAndFinishBlock:^{
            
        }];
    }else{
        indexShow++;
        [[NSUserDefaults standardUserDefaults] setInteger:indexShow forKey:@"showStartImage"];
//        [self performSelector:@selector(doLoadAnimation) withObject:nil afterDelay:1];
//        [self doLoadAnimation];
//        [self loadStartViewAndFinishBlock:^{
//
//        }];
        [self loadStartSecFinishBlock:^{
            
        }];
    }
    return YES;
}

- (void)doLoadAnimation
{
    __weak typeof(self) _self = self;
    [self _getStartImageAndBlock:^(NSString *imgUrl) {
        [_self showADImgView:imgUrl];
      //  [AFNconnectionImport connectionWifi];
    }];

}

#pragma mark - 极光推送
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidSetupNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidCloseNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidRegisterNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidLoginNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidReceiveMessageNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFServiceErrorNotification
                           object:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
   
    [APService registerDeviceToken:deviceToken];
    NSString *log = [NSString stringWithFormat:@"执行注册成功%@",deviceToken];
     NSLog(@"1111 %@",log);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
        NSLog(@"收到内容");
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
        NSLog(@"执行注册失败");
    NSString *str = [NSString stringWithFormat: @"Error: %@", error];
    
    NSLog(@"error is %@",str);
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void
                        (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
     [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"messageStatu"];
    [_mainTabBarCtrl getMessage];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [APService setBadge:0];
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [APService setBadge:0];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [APService setBadge:0];
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    //    NSLog(@"userInfo3 is %@",userInfo);
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}


- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"已注册");
    
}

- (void)networkDidLogin:(NSNotification *)notification {
    
    //获取到的RegistrationID 通过注册接口发送给咱们自己后台
    NSString *registid2 = [APService registrationID];
    //    NSString *str = [NSString stringWithFormat:@"%@",deviceToken];
    //    NSLog(@"first token is %@",str);
    //    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:
    ////                       [NSCharacterSet characterSetWithCharactersInString:@"<>"]];//转换成NSString，并去掉< 和>
    //    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (registid2.length > 0)
    {
        [[NSUserDefaults standardUserDefaults] setObject:registid2 forKey:kPushNotification];
    }
    
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSLog(@"接受到消息");
    
    
}

- (void)serviceError:(NSNotification *)notification {
    
    NSLog(@"消息错误");
}




-(void)showADImgView:(NSString *)imgUrl{
    
    
    
    [UIView animateWithDuration:1 animations:^{
        [adImgView setAlpha:1];
    } completion:^(BOOL finished) {
         self.window.rootViewController.view.alpha = 1;
        [UIView animateWithDuration:3 animations:^{
            [adImgView setAlpha:.1f];
        } completion:^(BOOL finished) {
            [adImgView removeFromSuperview];
           
        }];
    }];
}

- (void)loadStartSecFinishBlock:(void(^)())theBlock
{
    self.window.rootViewController.view.alpha = 0.0f;
    
    adImgView = [[ALImageView alloc]
                 initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    adImgView.backgroundColor = [UIColor clearColor];
    [adImgView setAlpha:.1f];
    adImgView.hidden = YES;
    [self.window addSubview:adImgView];
    
    [self _getStartImageAndBlock:^(NSString *imgUrl) {
        [adImgView setImageWithURL:[NSURL URLWithString:imgUrl]
                  placeholderImage:[UIImage imageNamed:@"DownLoadImg.jpg"]];
    }];
    
    _startTwoView = [[ALImageView alloc]
                     initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _startTwoView.backgroundColor = [UIColor whiteColor];
    
    _startTwoView.image = [UIImage imageNamed:@"start_page"];
    
    _startTwoView.alpha=1;
    [self.window addSubview:_startTwoView];
    
    [UIView animateWithDuration:2 animations:^{
        _startTwoView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
        adImgView.hidden = NO;
        [self.window bringSubviewToFront:adImgView];
        [self showADImgView:nil];
        [_startTwoView removeFromSuperview];
        if (theBlock) {
          //  [AFNconnectionImport connectionWifi];
            theBlock();
        }
    }];
}


//启动页面
- (void)loadStartViewAndFinishBlock:(void(^)())theBlock
{
    _startTwoView = [[ALImageView alloc]
                     initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _startTwoView.backgroundColor = [UIColor whiteColor];
    _startTwoView.image = [UIImage imageNamed:@"start_page"];
    _startTwoView.alpha=1;
    [self.window addSubview:_startTwoView];
    
    [UIView animateWithDuration:2 animations:^{
        _startTwoView.alpha = 0;
    } completion:^(BOOL finished) {
        [_startTwoView removeFromSuperview];
        if (theBlock) {
          //  [AFNconnectionImport connectionWifi];
            theBlock();
        }
    }];
}

//- (void)startTwoViewAction
//{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:3];
//    _startTwoView.alpha = 0;
//    [UIView commitAnimations];
//}

- (void)guideViewHide
{
    [_guideView removeFromSuperview];
   // [AFNconnectionImport netWorkingCon];
}

//- (void)initializePlat
//{
//    /**
//     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
//     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
//     **/
//    [ShareSDK connectSinaWeiboWithAppKey:getTxt(@"sinaAppKey")
//                               appSecret:getTxt(@"sinaAppSecret")
//                             redirectUri:@"https://api.weibo.com/oauth2/default.html"];
//    
//    /**
//     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
//     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
//     
//     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
//     **/
//    [ShareSDK connectTencentWeiboWithAppKey:getTxt(@"qqAppKey")
//                                  appSecret:getTxt(@"qqAppSecret")
//                                redirectUri:@"http://www.mofayichu.net/"
//                                   wbApiCls:[WeiboApi class]];
//    
//    /**
//     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
//     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
//     
//     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
//     **/
////    [ShareSDK connectQZoneWithAppKey:@"100371282"
////                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
////                   qqApiInterfaceCls:[QQApiInterface class]
////                     tencentOAuthCls:[TencentOAuth class]];
//    
//    [ShareSDK connectQZoneWithAppKey:getTxt(@"qqAppKey")
//                           appSecret:getTxt(@"qqAppSecret")
//                   qqApiInterfaceCls:[QQApiInterface class]
//                     tencentOAuthCls:[TencentOAuth class]];
//    
//    /**
//     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
//     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
//     **/
////        [ShareSDK connectWeChatWithAppId:@"wx00118fe125d59786" wechatCls:[WXApi class]];
//    [ShareSDK connectWeChatWithAppId:getTxt(@"wxAppKey")
//                           appSecret:getTxt(@"wxAppSecret")
//                           wechatCls:[WXApi class]];
//    /**
//     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
//     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
//     **/
//    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
//    //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
//    
//    [ShareSDK connectQQWithQZoneAppKey:getTxt(@"qqAppKey")
//                     qqApiInterfaceCls:[QQApiInterface class]
//                       tencentOAuthCls:[TencentOAuth class]];
//    
//    
//}


#pragma mark loadData
#pragma mark -
#pragma mark 获得广告图片
-(void)_getStartImageAndBlock:(void(^)(NSString *imgUrl))theBlock{
    NSDictionary *sendDic=@{};
    [DataRequest requestApiName:@"fashionSquare_getStartImage"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       if (theBlock) {
                           theBlock(sucContent[@"body"][@"result"][0][@"image"]);
                       }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
        showFail(reloginContent);
    } andShowLoad:NO];
}


#pragma mark 第三方相关 
#pragma mark -
-(void)initSecond{
    
    NSString *weixinKey = getTxt(@"wxAppKey");
    
    [WXApi registerApp:weixinKey withDescription:@"魔法衣橱"];
    theTencentOAuth= [[TencentOAuth alloc]
                           initWithAppId:getTxt(@"qqAppKey") andDelegate:self];
    [WeiboSDK registerApp:getTxt(@"sinaAppKey")];
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self _loadGetSysConfigAndBlock:^{
    
        if ([dict_Im[@"configvalue"]isEqualToString:@"Y"])
        {
            [MobClick checkUpdate:@"发现新版本" cancelButtonTitle:@"取消" otherButtonTitles:@"下载新版本"];
        }
        
    }];
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return
    [WXApi handleOpenURL:url delegate:self]||[TencentOAuth HandleOpenURL:url]||[WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([WXApi handleOpenURL:url delegate:self]&&[[url host] isEqualToString:@"pay"]) { //微信支付完成
        [[NSNotificationCenter defaultCenter] postNotificationName:WXPAYSUCNOTI object:nil];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processAuthResult:url
         standbyCallback:^(NSDictionary *resultDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ALIPAYSUCNOTI object:nil];
        }];
    }
    return
    [WXApi handleOpenURL:url delegate:self]||[TencentOAuth HandleOpenURL:url]||[WeiboSDK handleOpenURL:url delegate:self];
    
}
#pragma mark 是否更新
-(void)_loadGetSysConfigAndBlock:(void(^)())theBlock
{
    NSDictionary *sendDic=@{@"configKey":@"isCueUpdate"};
    [DataRequest requestApiName:@"fashionSquare_SysCongfig"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       @try {
                           @try {
                               //configdesc   configvalue
                               dict_Im=sucContent[@"body"][@"result"];
                               // array_MostS = arr;
                           }
                           @catch (NSException *exception) {
                           }
                           @finally {
                           }
                       }
                       @catch (NSException *exception) {
                       }
                       @finally {
                           
                       }
                       if (theBlock)
                       {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                       
                   }];
    
    
}
#pragma mark 微信
-(void)wxLoginAndBlock:(void(^)(id sender))theBlock{
    theWXBlock = theBlock;
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"0744" ;
    [WXApi sendReq:req];
}

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    else if([resp isKindOfClass:[SendAuthResp class]]){
        /*
         ErrCode ERR_OK = 0(用户同意)
         ERR_AUTH_DENIED = -4（用户拒绝授权）
         ERR_USER_CANCEL = -2（用户取消）
         code    用户换取access_token的code，仅在ErrCode为0时有效
         state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
         lang    微信客户端当前语言
         country 微信用户当前国家信息
         */
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode== 0) {
            NSString *code = aresp.code;
            NSDictionary *dic = @{@"code":code};
            [self getAccess_token:dic];
        }
    }
}
-(void)getAccess_token:(NSDictionary *)dic{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",getTxt(@"wxAppKey"),getTxt(@"wxAppSecret"),dic[@"code"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                DLog(@"str is %@",str);
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 "access_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWiusJMZwzQU8kXcnT1hNs_ykAFDfDEuNp6waj-bDdepEzooL_k1vb7EQzhP8plTbD0AgR8zCRi1It3eNS7yRyd5A";
                 "expires_in" = 7200;
                 openid = oyAaTjsDx7pl4Q42O3sDzDtA7gZs;
                 "refresh_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWi2ZzH_XfVVxZbmha9oSFnKAhFsS0iyARkXCa7zPu4MqVRdwyb8J16V8cWw7oNIff0l-5F-4-GJwD8MopmjHXKiA";
                 scope = "snsapi_userinfo,snsapi_base";
                 }
                 */
                
                //                self.access_token.text = [dic objectForKey:@"access_token"];
                //                self.openid.text = [dic objectForKey:@"openid"];
                
                [self getUserInfo:[dic objectForKey:@"access_token"] andOpenId:[dic objectForKey:@"openid"] andBlock:^{
                    
                }];
            }
        });
    });
}
-(void)getUserInfo:(NSString *)access_token andOpenId:(NSString *)openid andBlock:(void(^)())theBlock
{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                DLog(@"str is %@",str);
                /*
                 {
                 city = Haidian;
                 country = CN;
                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
                 language = "zh_CN";
                 nickname = "xxx";
                 openid = oyAaTjsDx7pl4xxxxxxx;
                 privilege =     (
                 );
                 province = Beijing;
                 sex = 1;
                 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
                 }
                 */
                
                //                self.nickname.text = [dic objectForKey:@"nickname"];
                //                self.wxHeadImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]]];
                
                NSDictionary *sendDic=@{
                                        @"thirdAccount":filterStr(dic[@"unionid"]),
                                        @"thirdAccountType":@"微信",
                                        @"nickName":filterStr(dic[@"nickname"]),
                                        @"userPic":filterStr(dic[@"headimgurl"]),
                                        @"birthday":filterStr(@""),
                                        @"age":@""
                                        };
                if (theWXBlock) {
                    theWXBlock(sendDic);
                }
            }
        });
    });
}

#pragma mark QQ
-(void)qqLoginAndBlock:(void(^)(id sender))theBlock{
    theQQBlock=theBlock;
    theTencentOAuth= [[TencentOAuth alloc]
                           initWithAppId:@"1104505332" andDelegate:self];
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_IDOL,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_PIC_T,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_DEL_IDOL,
                            kOPEN_PERMISSION_DEL_T,
                            kOPEN_PERMISSION_GET_FANSLIST,
                            kOPEN_PERMISSION_GET_IDOLLIST,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_REPOST_LIST,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                            nil];
    
    [theTencentOAuth authorize:permissions inSafari:NO];
}
- (void)tencentDidLogin
{
    BOOL isLogin= [theTencentOAuth getUserInfo];
    if (isLogin) {
        NSLog(@"登陆成功");
    }
}
- (void)getUserInfoResponse:(APIResponse*) response
{
    NSDictionary *sendDic=@{
                            @"thirdAccount":filterStr(response.jsonResponse[@"nickname"]),
                            @"thirdAccountType":@"QQ",
                            @"nickName":filterStr(response.jsonResponse[@"nickname"]),
                            @"userPic":filterStr(response.jsonResponse[@"figureurl_qq_1"]),
                            @"birthday":filterStr(@""),
                            @"age":@""
                            };
    if (theQQBlock) {
        theQQBlock(sendDic);
    }
}
#pragma mark 新浪微博
-(void)wbLoginAndBlock:(void(^)(id sender))theBlock{
    theWBBlock=theBlock;
    
    [WeiboSDK enableDebugMode:YES];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = getTxt(@"wbRedirectURI");
    request.scope = @"all";
    request.userInfo = @{@"myKey": @"myValue"};
    [WeiboSDK sendRequest:request];
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        if ((int)response.statusCode == 0) {
            NSDictionary *sendDic=@{
                                    @"thirdAccount":filterStr([(WBAuthorizeResponse *)response userID]),
                                    @"thirdAccountType":@"WB",
                                    @"nickName":filterStr(@""),
                                    @"userPic":filterStr(@""),
                                    @"birthday":filterStr(@""),
                                    @"age":@""
                                    };
            
            if (theWBBlock) {
                theWBBlock(sendDic);
            }
        }else if((int)response.statusCode == -3){ //授权失败
            showWarn(@"授权失败");
        }
    }
}
@end
