//
//  ALMagicBagViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
/**
 *  魔法包
 */
typedef void (^ALToMyAL)();
@interface ALMagicBagViewController : ALBaseViewController
@property(nonatomic,copy)ALToMyAL  theBlcokALToMyAL;
@end
