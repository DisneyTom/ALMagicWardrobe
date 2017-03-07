//
//  UIPlaceTextView.h
//  PRMC
//
//  Created by 祥敏 罗 on 14-4-4.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ALAccessoryView.h"
@protocol ALPlaceTextDelegate;

@interface UIPlaceTextView : UITextView<ALAccessoryViewDelegate> {
    NSString *placeholder;
    UIColor *placeholderColor;
    
@private
    UILabel *placeHolderLabel;
}
@property(nonatomic,unsafe_unretained) id<ALPlaceTextDelegate> textViewDelegate;

@property(nonatomic, retain) UILabel *placeHolderLabel;
@property(nonatomic, retain) NSString *placeholder;
@property(nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
@protocol ALPlaceTextDelegate <NSObject>

@optional
- (void)textViewDidCancelEditing:(ALTextField *)textField; //点击键盘上的“取消”按钮。
- (void)textViewDidFinsihEditing:(ALTextField *)textField; //点击键盘框上的"确认"按钮。

@end