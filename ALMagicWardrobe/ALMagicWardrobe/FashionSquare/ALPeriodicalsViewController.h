//
//  ALPeriodicalsViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
/**
 *  时尚周刊详情页
 */
@interface ALPeriodicalsViewController : ALBaseViewController
@property(nonatomic,copy) NSString *periodicalsId;
/**
 *  comeFromMycollecit  =  YES 来自我的收藏
 */
@property(nonatomic,assign) BOOL comeFromMyColecton;

@end
