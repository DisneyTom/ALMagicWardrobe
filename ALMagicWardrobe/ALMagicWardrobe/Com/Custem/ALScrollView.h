//
//  ALScrollView.h
//  GameRec
//
//  Created by anlun on 14-8-27.
//  Copyright (c) 2014年 anlun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALImageView.h"
typedef void (^OnTheScrollViewTouchClick_block)(id sender);

@interface ALScrollView : UIScrollView
@property (retain, nonatomic, readonly) ALImageView *verticalIndicator;
@property (retain, nonatomic, readonly) ALImageView *horizontalIndicator;
@property (nonatomic,copy) OnTheScrollViewTouchClick_block theViewTouchuBlock;

- (void)scrollToTopAnimated:(BOOL)animation;
- (void)scrollToBottomAnimated:(BOOL)animation;

//子视图位置变化时调整contentSize。
- (void)contentSizeToFit;

@end
