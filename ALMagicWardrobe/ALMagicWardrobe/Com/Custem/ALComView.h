//
//  ALComView.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALScrollView.h"
#import "ALButton.h"
#import "ALLabel.h"
#import "ALTextField.h"
#import "ALBlockUIAlertView.h"
#import "ALTableView.h"
#import "ALSelectView.h"
#import "ALImageView.h"
#import "ALImage.h"
#import "ALAlertView.h"
#import "LoadingView.h"
typedef enum {
    BothLine_type,
    TopLine_type,
    BottomLine_type
}OcnCustemViewEnum;
typedef void (^OnTheViewTouchClick_block)(id sender);
typedef void (^BackBlock)(id sender);

@interface ALComView : UIView
@property (nonatomic,copy) OnTheViewTouchClick_block theViewTouchuBlock;
/**
 *  若需要个性化UIview,调用此函数
 *
 *  @param theType     上下是否有线
 *  @param topColor    上线的颜色
 *  @param bottomColor 下线的颜色
 */
-(void)setCustemViewWithType:(OcnCustemViewEnum)theType
             andTopLineColor:(UIColor *)topColor
          andBottomLineColor:(UIColor *)bottomColor;
-(void)drawLine:(NSUInteger)startY;
@end
