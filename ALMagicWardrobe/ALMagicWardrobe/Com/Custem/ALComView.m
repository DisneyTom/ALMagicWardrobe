//
//  ALComView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALComView.h"

@implementation ALComView{
    float _startY;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
-(void)setCustemViewWithType:(OcnCustemViewEnum)theType
             andTopLineColor:(UIColor *)topColor
          andBottomLineColor:(UIColor *)bottomColor{
    switch (theType) {
        case BothLine_type:
        {
            UILabel *topLine=[[UILabel alloc]
                              initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
            [topLine setBackgroundColor:topColor];
            [self addSubview:topLine];
            
            UILabel *bottomLine=[[UILabel alloc]
                                 initWithFrame:CGRectMake(0, self.height-0.5, self.width, 0.5)];
            [bottomLine setBackgroundColor:bottomColor];
            [self addSubview:bottomLine];
        }
            break;
        case TopLine_type:
        {
            UILabel *topLine=[[UILabel alloc]
                              initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
            [topLine setBackgroundColor:topColor];
            [self addSubview:topLine];
        }
            break;
        case BottomLine_type:
        {
            UILabel *bottomLine=[[UILabel alloc]
                                 initWithFrame:CGRectMake(0, self.height-0.5, self.width, 0.5)];
            [bottomLine setBackgroundColor:bottomColor];
            [self addSubview:bottomLine];
        }
            break;
        default:
            break;
    }
}

-(void)drawLine:(NSUInteger)startY
{
    if (startY>0) {
        _startY=startY;
        [self setNeedsDisplay];
    }else{
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextBeginPath(context);
                CGContextSetLineWidth(context,0.5);//线宽度
                CGContextSetStrokeColorWithColor(context, AL_RGB(136,136,136).CGColor);
                CGFloat lengths[] = {4,2};//先画4个点再画2个点
                CGContextSetLineDash(context,0, lengths,2);//注意2(count)的值等于lengths数组的长度
                CGContextMoveToPoint(context,0,_startY);
                CGContextAddLineToPoint(context,kScreenWidth,_startY);
                CGContextStrokePath(context);
                CGContextClosePath(context);
        _startY=0;
    }
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (_startY>0) {
        [self drawLine:0];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_theViewTouchuBlock) {
        _theViewTouchuBlock(self);
    }
}


@end
