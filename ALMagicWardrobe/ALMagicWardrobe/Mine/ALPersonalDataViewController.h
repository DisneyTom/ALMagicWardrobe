//
//  ALPersonalDataViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
@class ALUserDetailModel;
/**
 *  个人资料
 */
@interface ALPersonalDataViewController : ALBaseViewController
@property(nonatomic,strong) ALUserDetailModel *theUserDetailModel;
@end
