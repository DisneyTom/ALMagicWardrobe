//
//  ALTableView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALTableView.h"

@implementation ALTableView
-(id)initWithFrame:(CGRect)frame andType:(int)num{
    self=[super initWithFrame:frame];
    if (self) {
        ALComView *contentView=[[ALComView alloc] initWithFrame:CGRectMake(244/4, 0, frame.size.width-244/4, frame.size.height)];
        [contentView setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:contentView];
    }
    return self;
}
@end
