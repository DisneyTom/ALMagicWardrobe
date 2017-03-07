//
//  ALTestControlViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
typedef void (^BackBlock)(id sender);
/**
 *  测试主控制器
 */
@interface ALTestControlViewController : ALBaseViewController
@property(nonatomic,copy) BackBlock theBackBlock;

-(void)reTestRequestAndBlock:(void(^)())theBlock;

@end
