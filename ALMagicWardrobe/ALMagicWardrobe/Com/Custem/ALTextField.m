//
//  OcnTextField.m
//  tour Manager
//
//  Created by admin on 14-5-14.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "ALTextField.h"

@implementation ALTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.inputAccessoryView = [[ALAccessoryView alloc] initWithDelegate:self];
        self.theTextFiledType=Nomal_type;
    }
    return self;
}
#pragma mark - UIAccessoryViewDelegate Methods
- (void)accessoryViewDidPressedCancelButton:(ALAccessoryView *)view{
    if (self.textViewDelegate &&
        [self.textViewDelegate respondsToSelector:@selector(textViewDidCancelEditing:)]) {
        
        [self.textViewDelegate performSelector:@selector(textViewDidCancelEditing:) withObject:self];
    }
    
    [self resignFirstResponder];
}

- (void)accessoryViewDidPressedDoneButton:(ALAccessoryView *)view{
    if (self.textViewDelegate &&
        [self.textViewDelegate respondsToSelector:@selector(textViewDidFinsihEditing:)]) {
        [self.textViewDelegate performSelector:@selector(textViewDidFinsihEditing:) withObject:self];
    }
    
    [self resignFirstResponder];
}
-(void)setPlaceColor:(UIColor *)theColor{
    //UITextField设置placeholder颜色
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: theColor}];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
