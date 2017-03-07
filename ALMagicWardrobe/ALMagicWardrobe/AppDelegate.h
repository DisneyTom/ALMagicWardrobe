//
//  AppDelegate.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBGuideView.h"
#import "WXApi.h"
@class ALTabBarViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,MBGuideViewDelegate,WXApiDelegate>
{
    MBGuideView *_guideView;
    ALImageView *_startTwoView;
    
}
@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)ALTabBarViewController *mainTabBarCtrl;
-(void)wxLoginAndBlock:(void(^)(id sender))theBlock;
#pragma mark QQ登陆
-(void)qqLoginAndBlock:(void(^)(id sender))theBlock;
#pragma mark 新浪微博登陆
-(void)wbLoginAndBlock:(void(^)(id sender))theBlock;
@end
