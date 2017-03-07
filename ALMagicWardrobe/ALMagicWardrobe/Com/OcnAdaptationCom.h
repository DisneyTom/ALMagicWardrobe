//
//  OcnAdaptationCom.h
//  OcnO2O
//
//  Created by anLun on 15-2-11.
//  Copyright (c) 2015年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef	CGRectMake
#define CGRectMake ALRectMake

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//Device
#define isIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]==4)
#define isIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]==5)
#define isAfterIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]>4)
#define isAfterIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]>5)
#define isAfterIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]>6)

#define iOS ([[[UIDevice currentDevice] systemVersion] floatValue])

#define isRetina ([[UIScreen mainScreen] scale]==2)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IOS5_Height (([[UIScreen mainScreen] bounds].size.height > 500 ) ? (isIOS7?568:548):(isIOS7?480:460))

#undef  IOS7_OR_LATER
#define IOS7_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

/**
 *  适配相关的处理
 */
@interface OcnAdaptationCom : NSObject

CGRect ALRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

@end
