//
//  OcnAccessoryView.h
//  tour Manager
//
//  Created by admin on 14-5-21.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ALAccessoryViewDelegate;

@interface ALAccessoryView : UIToolbar
- (id)initWithDelegate:(id<ALAccessoryViewDelegate>)delegate;
- (void)setTitle:(NSString *)title;
@end

@protocol ALAccessoryViewDelegate <NSObject>
@optional
- (void)accessoryViewDidPressedCancelButton:(ALAccessoryView *)view;
- (void)accessoryViewDidPressedDoneButton:(ALAccessoryView *)view;

@end
