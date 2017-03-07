//
//  OcnTextField.h
//  tour Manager
//
//  Created by admin on 14-5-14.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAccessoryView.h"
@protocol ALTextFiledDelegate;

typedef enum {
    Nomal_type, //默认
    MyDot_type //支付宝
}TextFiledEnum;

@interface ALTextField : UITextField<ALAccessoryViewDelegate>
@property(nonatomic,unsafe_unretained) id<ALTextFiledDelegate> textViewDelegate;
@property(nonatomic,unsafe_unretained) TextFiledEnum theTextFiledType;
-(void)setPlaceColor:(UIColor *)theColor;
@end

@protocol ALTextFiledDelegate <NSObject>

@optional
- (void)textViewDidCancelEditing:(ALTextField *)textField; //点击键盘上的“取消”按钮。
- (void)textViewDidFinsihEditing:(ALTextField *)textField; //点击键盘框上的"确认"按钮。

@end