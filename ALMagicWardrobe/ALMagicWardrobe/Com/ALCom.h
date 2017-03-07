//
//  ALCom.h
//  GameRec
//
//  Created by anlun on 14-8-27.
//  Copyright (c) 2014年 anlun. All rights reserved.
//

#ifndef GameRec_GRCom_h
#define GameRec_GRCom_h

#define APPKEY @"5035cbb8"
#define BUNDLEID ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"])
#define PAGESIZE @"10" //列表，每页的大小
#define APPSECRET @"sdk.sharesdk.sdk"

#define isTest (0) //是否为测试状态

/*
 若为越狱状态时，需要添加
 GRJailAction.h,
 GRJailAction.m,
 GRVideoDownOrUpload.h,
 GRVideoDownOrUpload.m,
 AnLunRecoder.framework,
 AppSupport.framework,
 IOKit.framework,
 librocketbootstrap.dylib
 */
#define isJail (0) //是否为越狱状态,

#define __GR_LOG__ (1) //是否打印,自定义NSLog类，统一管理打印事件
#define __GR_SAVE_LOG__ (0) //是否保存日志

//视屏存放路径
#define videoStoragePath ([[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"videos"])
//bundleids存放路径
#define bundleidsStoragePath ([[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"bundleids"])

#define isIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0 && [[[UIDevice currentDevice] systemVersion] floatValue]< 7.0)
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0 && [[[UIDevice currentDevice] systemVersion] floatValue]< 8.0)
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)

//Global frames
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kStatusBarHeight (isIOS7||isIOS8?20:0)
#define kNavigationBarHeight (isIOS7||isIOS8 ? (20+44):(0+44))
#define kNavigationBarLandscapeHeight 33.0f
#define kTabBarHeight 49.0f
#define kContentViewHeight (kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)
#define kPickerViewHeight 216.0f
#define kToolBarHeight 44.0f
#define kStepViewHeight 25.0f
#define kTextFieldHeight 25.0f
#define kInputViewHeight (kPickerViewHeight + kToolBarHeight)

#define kBigAlertViewContentWidth 287.0
#define kBigAlertViewContentHeight (kScreenHeight - 170.0)
#define kTableViewSectionMargin 2.5

#define isBigScreen (kScreenHeight>480.0f)

//
#define kVideoRowHeight 283.0f+56.0f  //视频tableViewCell的高
#define kGameRowHeight 120/2.0f  //游戏tableViewCell的高
#define kUserRowHeight 130/2.0f  //用户tableViewCell的高
#define kTabbarItemWidth  (kScreenWidth/4.0f)  //tabbar的宽
#define kLeftSpace 15.0f  //布局右边的空
#define kRightSpace 15.0f  //布局左边的空
#define kTopBarHeight 38.0f  //topBar的高度

#define TXTRESIGNFIRSTRESPONDER  @"txtResignFirstResponder"

#define LOGNORSIGNUPNOTI @"LognOrSignUpNoTi" //弹出登录或注册Noti
#define LOGNORSIGNUPBACKNOTI @"LognOrSignUpBackNoTi" //登录或注册成功后通知

//#define LOGINBACKNOTI  @"LoginBackNoTi" //登录成功后通知
//
#define SIGNUPBACKNOTI  @"SignUpBackNoTi" //注册成功后通知

#define HIDETABBARVIEW @"hideTabBarView" //隐藏或显示tabBar通知

#define  IS_HAS_NEWEST  @"isHasNewest"  //有最新提示

#define  LOGIN_OUT @"loginOut" //推出登录通知

//rgb颜色
#define AL_RGB(__r, __g, __b) [UIColor colorWithRed:(__r / 255.0) green:(__g / 255.0) blue:(__b / 255.0) alpha:1]
#define AL_RGBA(__r, __g, __b, __a) [UIColor colorWithRed:(__r / 255.0) green:(__g / 255.0) blue:(__b / 255.0) alpha:__a]
#define ALUIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

//本地化获得值
#define getVal(key) NSLocalizedString((key), nil)
#define getErrorVal(key)  NSLocalizedStringFromTable((key), @"GRError", nil)

#define GRComBlackColor GR_RGB(32,32,32) //通用的黑色，避免纯黑色

//生成静态属性
#undef GR_STATIC_PROPERTY
#define GR_GET_PROPERTY( __name) \
@property (nonatomic, strong, readonly) NSString* __name; \
+ (NSString *)__name;

#undef GR_SET_PROPERTY
#define GR_SET_PROPERTY( __name, __value) \
@dynamic __name; \
+ (NSString *)__name \
{ \
return __value; \
}

//申明为单例
#undef	AL_AS_SINGLETON
#define AL_AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;\

#undef	AL_DEF_SINGLETON
#define AL_DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

//安全释放
#define GR_RELEASE_SAFELY(__POINTER) {  __POINTER = nil; }
#define GR_INVALIDATE_TIMER(__TIMER) { [__TIMER invalidate]; __TIMER = nil; }

//4.3的情况下兼容5.0的ARC关键字
#if (!__has_feature(objc_arc)) || \
(defined __IPHONE_OS_VERSION_MIN_REQUIRED && \
__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_5_0) || \
(defined __MAC_OS_X_VERSION_MIN_REQUIRED && \
__MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_7)
#undef weak
#define weak unsafe_unretained
#undef __weak
#define __weak __unsafe_unretained
#endif

#ifndef GR_STRONG
#if __has_feature(objc_arc)
#define GR_STRONG strong
#else
#define GR_STRONG retain
#endif
#endif

#ifndef GR_WEAK
#if __has_feature(objc_arc)
#define GR_WEAK unsafe_unretained
#elif __has_feature(objc_arc_weak)
#define GR_WEAK weak
#else
#define GR_WEAK assign
#endif
#endif


//独立属性的申明，是为了当变MRC时，达到统一控制
#define GR_PROPERTY_STRONG @property(nonatomic,GR_STRONG)
#define GR_PROPERTY_WEAK @property(nonatomic,GR_WEAK)

//--------------------------------------------------------------------------------------------------
//performSelector方法在ARC模式下会有警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#pragma clang diagnostic pop

#define RGB_BG_Black_Alpha RGBAlpha(0, 0, 0, 0.6)
#define RGB_BG_Clear [UIColor clearColor]
//#define Img_Loading IMG_WITH_NAME(@"img_loading_bg")
#define Img(name,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",name] ofType:[NSString stringWithFormat:@"%@",type]]]

#define IMG_WITH_NAME(__NAME__) ([UIImage imageNamed:__NAME__])

#define kToolBarHeight 44.0f
#define kTabBarHeight 49.0f

#define RGB_Font_Orange AL_RGB(235,97,0)
#define RGB_Font_First_Title AL_RGB(49,49,49)
#define RGB_Font_Second_Title AL_RGB(149,149,149)
#define RGB_Font_Third_Title AL_RGB(171,171,171)
#define RGB_Line_Gray AL_RGB(221,221,221)
#define RGB_BG_Black_Alpha RGBAlpha(0, 0, 0, 0.6)
#define RGB_BG_Clear [UIColor clearColor]

#define TSelectViewWillShowNotification @"TSelectViewWillShowNotification"
#define TSelectViewWillHideNotification @"TSelectViewWillHideNotification"
#define MBSelectViewDidShowNotification @"MBSelectViewDidShowNotification"
#define MBSelectViewDidHideNotification @"MBSelectViewDidHideNotification"
#define MBAlertViewDidHideNotification @"MBAlertViewDidHideNotification"
#define kPickerViewHeight 216.0f

#define kDateFormat @"yyyy-MM-dd"
#define D_MBS_DATE_Fortmat @"yyyyMMdd"
#define D_MBS_TIME_Format @"HHmmss"

#define IOS5_Height (([[UIScreen mainScreen] bounds].size.height > 500 ) ? (isIOS7?568:548):(isIOS7?480:460))

#define HIDETABBARVIEW @"hideTabBarView" //隐藏或显示tabBar通知

#define  FFSFIRST @"firstFashionSquare"  //潮流广场 第一次 使用
#define  MBFIRST  @"MagicBag"   //魔法包  第一次 使用
#define  MWFIRST  @"MagicWardrobe"  //我的衣橱 第一次  使用
#define  MWFIRSTINFO  @"MagicWardrobeInfo"  //我的衣橱 测试风格

//#define  @"hasTest" //是否已经测试

#define Line_Color AL_RGB(224, 224, 224)

//获得接口
#define GetApiByKey(__key__) ([NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MWApi" ofType:@"plist"]][__key__])

//
//#define LoadIngImg [ALImage imageNamed:@"icon"]
//#define LoadIngImg [ALImage imageNamed:@"icon_about@2x.png"]
#define LoadIngImg [ALImage imageNamed:@"loadPlaceHolder.png"]

#define getTxt(key)  NSLocalizedStringFromTable((key), @"ALComTxt", @"")

#define WXPAYSUCNOTI @"WXPaySucNoti" //微信支付完成通知
#define ALIPAYSUCNOTI @"AlipaySucNoti" //支付宝支付完成通知
#endif
