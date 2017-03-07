//
//  ALImageView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-19.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALImageView.h"

@implementation ALImageView
-(id)initWithFrame:(CGRect)frame{
   self= [super initWithFrame:frame];
    if (self) {
//        self.contentMode=UIViewContentModeScaleAspectFill;
        [self.layer setMasksToBounds:YES];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    if (_theImageVimageTouchuBlock) {
        _theImageVimageTouchuBlock(self);
    }
}
@end
