//
//  ALClothesDetailViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-19.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
#import "ALClothsModel.h"
/**
 *  衣服详情页面
 */
@interface ALClothesDetailViewController : ALBaseViewController<UIScrollViewDelegate>
@property(nonatomic,copy) NSString *fashionId;
@property(nonatomic,copy) NSString *mwColothsId;
@property(nonatomic,copy) NSString *wardrobeId;
@property(nonatomic, strong) ALClothsModel *clothsModel;
@property(nonatomic,assign)BOOL fromMyMagicWardrobe;
//是我的垃圾篓
@property(nonatomic, assign) BOOL isMyBash;
@end
