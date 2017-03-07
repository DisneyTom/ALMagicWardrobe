//
//  ALLine.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-22.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALLine.h"

@implementation ALLine
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, .5f)];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    [self drawLine:0];
}


@end
