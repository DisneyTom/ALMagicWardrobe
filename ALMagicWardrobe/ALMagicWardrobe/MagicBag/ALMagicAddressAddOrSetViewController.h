//
//  ALMagicAddressAddOrSetViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
#import "ALAddressModel.h"
/**
 *  增加或修改魔法包地址
 */
@interface ALMagicAddressAddOrSetViewController : ALBaseViewController
@property(nonatomic,strong)ALAddressModel *addRessModel; //有值 为修改  无值 为增加

@end
