//
//  ALEditAddressViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
#import "ALAddressModel.h"

typedef void (^AddressSelBlock)(ALAddressModel *theAddressModel);
typedef void (^SetDefaultBackBlock)(id sender);
/**
 *  修改地址
 */
@interface ALEditAddressViewController : ALBaseViewController
@property(nonatomic,copy) AddressSelBlock theBlock;
@property(nonatomic,copy) SetDefaultBackBlock theBackBlock;

/**
 *  是否是选择地址
 */
@property (nonatomic, assign) BOOL isSelectedAddress;
@end
