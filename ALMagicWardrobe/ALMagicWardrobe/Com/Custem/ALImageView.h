//
//  ALImageView.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-19.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

typedef void (^OcnImageViewTouchClick_block)(id sender);
@interface ALImageView : UIImageView
@property (nonatomic,copy) OcnImageViewTouchClick_block theImageVimageTouchuBlock;
@end
