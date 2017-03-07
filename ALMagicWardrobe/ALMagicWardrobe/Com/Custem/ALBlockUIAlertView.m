//
//  ALBlockUIAlertView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-12.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBlockUIAlertView.h"

@implementation ALBlockUIAlertView

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
       buttonTitles:(NSArray *)buttonTitles
        clickButton:(AlertBlock)_block
{
    self = [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:nil
              otherButtonTitles:nil, nil];
    for(NSString *str in buttonTitles){
        [self addButtonWithTitle:str];
    }
    self.cancelButtonIndex = [buttonTitles count] - 1;
    if (self) {
        self.theBlock = _block;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.theBlock(buttonIndex);
}

@end
