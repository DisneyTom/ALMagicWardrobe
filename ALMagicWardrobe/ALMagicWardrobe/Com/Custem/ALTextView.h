//
//  OcnTextView.h
//  tour Manager
//
//  Created by admin on 14-5-21.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAccessoryView.h"
@protocol ALTextViewDelegate;

@interface ALTextView : UITextView<ALAccessoryViewDelegate>{
    NSString *placeholder;
    UIColor *placeholderColor;
    
@private
    UILabel *placeHolderLabel;
}
@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@property(nonatomic,unsafe_unretained) id<ALTextViewDelegate> textViewDelegate;

@end

@protocol ALTextViewDelegate <NSObject>

@optional
- (void)textViewDidCancelEditing:(ALTextView *)textField; //点击键盘上的“取消”按钮。
- (void)textViewDidFinsihEditing:(ALTextView *)textField; //点击键盘框上的"确认"按钮。


@end
