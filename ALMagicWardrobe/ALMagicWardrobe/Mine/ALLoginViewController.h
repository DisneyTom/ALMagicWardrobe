//
//  ALLoginViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"

typedef void (^LoginAfterBlock)(id sender);
/**
 *  登录
 */
@interface ALLoginViewController : ALBaseViewController
@property(nonatomic,copy) LoginAfterBlock theBlock;
@property(nonatomic,strong) ALBaseViewController *theUpCtrl;
@end
