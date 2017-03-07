//
//  ALTabBarViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALTabBarViewController : UITabBarController
/**
 *  隐藏tabBar
 *
 *  @param hidden YES 为隐藏 NO 为显示
 */
-(void)tabBarHidden:(BOOL)hidden;
/**
 *  选择的下标
 *
 *  @param index 下标值
 */
-(void)selectTabIndex:(NSInteger)index;
-(void)getMessage;
+ (instancetype)shareALTabBarVC;
@end
