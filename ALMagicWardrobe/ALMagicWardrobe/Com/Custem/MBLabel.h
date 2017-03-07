//
//  MBLabel.h
//  BOCMBCI
//
//  Created by Tracy E on 13-4-8.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//
#define MBLabelTipWillShowNotification @"MBLabelTipWillShowNotification"

#import <UIKit/UIKit.h>

@interface MBLabel : UILabel

//跑马灯
@property (nonatomic, unsafe_unretained) BOOL isPaoMaDeng;

//隐藏提示信息
- (void)hideTipIfNeeded;


//给中间几个字符设置 另外的颜色字体
-(void)setKeyWordTextArray:(NSArray *)keyWordArray WithFont:(UIFont *)font AndColor:(UIColor *)keyWordColor;

//给这个label设置统一的字体颜色
-(void)setText:(NSString *)text WithFont:(UIFont *)font AndColor:(UIColor *)color;

//给某些字段添加另外的字体和颜色
-(void)setKeyWordTextString:(NSString *)keyWordArray WithFont:(UIFont *)font AndColor:(UIColor *)keyWordColor;
@end






