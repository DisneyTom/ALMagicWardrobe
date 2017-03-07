//
//  ALMagicShowBigShowViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-4-11.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
#import "ALMagicShowModel.h"
/**
 *  墨镜秀放大图片
 */
@interface ALMagicShowBigShowViewController : ALBaseViewController
@property(nonatomic,strong) ALMagicShowModel *theModel;
@property(nonatomic,assign) NSInteger curIndex;
@end
