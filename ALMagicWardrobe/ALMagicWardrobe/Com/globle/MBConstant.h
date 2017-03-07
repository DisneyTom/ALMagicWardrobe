//
//  MBConstant.h
//  BOCMBCI
//
//  Created by Tracy E on 13-3-25.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBAdditions.h"
#import "MBGlobalCore.h"

#define ChangeLimiteValueStepHeight 25
#define kDeviceOnly @"com.boc.BOCMBCI"
//--------------------------------------------------------------------------------------------------
//Global frames
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kStatusBarHeight 20.0f
#define kNavigationBarHeight 44.0f
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

//--------------------------------------------------------------------------------------------------
//Global Fonsts

//大标题 40点
#define kBigTitleFont [UIFont systemFontOfSize:20]

//小标题 28点
#define kSmallTitleFont [UIFont boldSystemFontOfSize:14]

//普通文本，正文
#define kNormalTextFont [UIFont boldSystemFontOfSize:15]

//步骤条文字
#define kSmallTextFont [UIFont systemFontOfSize:11]

//正文按钮字体
#define kButtonTitleFont [UIFont boldSystemFontOfSize:14]

//弹出框按钮大小
#define kSmallButtonTitleFont [UIFont boldSystemFontOfSize:13]

//#202020
#define kNormalTextColor [UIColor colorWithRed:(32 / 255.0) green:(32 / 255.0) blue:(32 / 255.0) alpha:1]

//#ffffff
#define kWhiteTextColor [UIColor whiteColor]

//#ba001d
#define kRedTextColor [UIColor colorWithRed:(186 / 255.0) green:0 blue:(29 / 255.0) alpha:1]

//#919191
#define kTipTextColor [UIColor colorWithRed:(145 / 255.0) green:(145 / 255.0) blue:(145 / 255.0) alpha:1]

//#c6c6c6
#define kStepViewTextColor [UIColor colorWithRed:(198 / 255.0) green:(198 / 255.0) blue:(198 / 255.0) alpha:1]

//#016622
#define kGreenColor [UIColor colorWithRed:(1 / 255.0) green:(102 / 255.0) blue:(34 / 255.0) alpha:1]

//--------------------------------------------------------------------------------------------------
//Button Frames
#define kLeftButtonFrame(__offsetY) CGRectMake(10, __offsetY, 137, 41)
#define kRightButtonFrame(__offsetY) CGRectMake(172, __offsetY, 137, 41)

#define kMiddleButtonFrame(__offsetY) CGRectMake(56, __offsetY,208, 40)

//一行三个按钮
#define kLineButton1(__offsetY) CGRectMake(5, __offsetY, 104, 39)
#define kLineButton2(__offsetY) CGRectMake(108, __offsetY, 104, 39)
#define kLineButton3(__offsetY) CGRectMake(211, __offsetY, 104, 39)

//--------------------------------------------------------------------------------------------------
//View Frames

//MBScrollMenu
#define kScrollCellWidth 66.0f
#define kScrollCellHeight 72.0f
#define kScrollButtonWidth 27.0f
#define kScrollButtonHeight 66.0f
#define kScrollMenuWidth (kScrollCellWidth + kScrollButtonWidth)

//MBMessageBoard
#define kMessageBoardWidth 318.0f
#define kMessageBoardHeight 233.0f
#define kMessageBoardMargin 1.0f
#define kMessageButtonWidth 28.0f
#define kMessageButtonHeight 32.0f

//view tag
#define kViewTagDontRemove 4001

#define kSipActiv @"66817"
#define kSipState @"41943040"

#define kDateFormat @"yyyy-MM-dd"

#define kConfirmButtonTitle @"确定"
#define kNextButtonTitle @"下一步"
#define kCompleteButtonTitle @"完成"
#define kAcceptButtonTitle @"接受"
#define kDisAcceptButtonTitle @"不接受"
#define kCancelButtonTitle @"取消"
#define kMoreTitle @"更多"
#define kCloseButtonTitle @"关闭"

#define kCheckUpdate @"ExchangeVersionInfo"
#define kFidgetList @"GetFidgetList"
#define kFidgetDetail @"GetFidgetDetail"
#define kFidgetURL @"url"
#define kFidgetVersion @"ver"
#define kFidgetMD5 @"md5"

#define kBooleanTrueString @"1"
#define kBooleanFalseString @"0"

#define kCombinListKey @"_combinList"
#define kDefaultCombinKey @"_defaultCombin"

#define kSmcErrorMessage @"手机交易码由6位数字组成"
#define kOtpErrorMessage @"动态口令由6位数字组成"
#define kPromiseErrorMessage @"保证金密码由6位数字组成"
#define kATMErrorMessage @"取款密码由6位数字组成"
#define kPswdErrorMessage @"密码为8-20位，必须含有数字和字母"
#define kNoRecordMessage @"没有查到符合条件的记录"

#define kPswdTipString @"温馨提示：密码长度为8－20位，区分大小写，至少需要包含一个字母或者一个数字，支持键盘可见字符（不包括空格，不包括汉字），不允许全角的字符"

#define kSmcTitle @"手机交易码"
#define kOtpTitle @"动态口令"
#define kPageSize @"10"

#define kEmptyString @""

//--------------------------------------------------------------------------------------------------
//Notification Names
#define MBUserDidLoginNotification @"MBUserDidLoginNotification"
#define MBUserDidLogoutNotification @"MBUserDidLogoutNotification"

#define MBSelectViewWillShowNotification @"MBSelectViewWillShowNotification"
#define MBSelectViewWillHideNotification @"MBSelectViewWillHideNotification"
#define MBSelectViewDidShowNotification @"MBSelectViewDidShowNotification"
#define MBSelectViewDidHideNotification @"MBSelectViewDidHideNotification"

#define MBAlertViewDidShowNotification @"MBAlertViewDidShowNotification"
#define MBAlertViewDidHideNotification @"MBAlertViewDidHideNotification"
#define MBProtocolChangeLimiteCompleteNotification @"MBProtocolChangeLimiteCompleteNotification"

#define MBLoadingViewDidHideNotification @"MBLoadingViewDidHideNotification"
#define MBExceptionAlertViewDidHideNotification @"MBExceptionAlertViewDidHideNotification"

//消息通知，非固定产品签约成功刷新表格通知
#define MBFGDSingNotification @"MBFGDSingNotification"
#define MBRemindRefresh @"MBRemindRefresh"


//--------------------------------------------------------------------------------------------------
//NSUserDefault keys:
#define kAppVersion             @"appVersion"
#define kBizMenuOrder           @"bizMenuOrder"
#define kSubShortcutMenus       @"SubShortcutMenus"
#define kAppLaunchedTimes       @"appLaunchedTimes"
#define kAcctLaunchedTimes      @"acctLaunchedTimes"
#define kAppTimeoutInterval     @"AppTimeoutInterval"
#define kFidgetCityName         @"fidgetCityName"
#define kFidgetCityCode         @"fidgetCityCode"
#define kRememberLoginName      @"shouldRememberLoginName"
#define kLoginName              @"loginName"
#define kLoginHint              @"loginHint"
#define kZuoTiAccount           @"zuoTiAccount"

//--------------------------------------------------------------------------------------------------
//交易数据字典
@interface MBConstant : NSObject


@end