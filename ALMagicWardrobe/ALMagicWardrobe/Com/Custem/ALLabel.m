//
//  ALLabel.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALLabel.h"
#import <CoreText/CoreText.h>


@implementation ALLabel {
    BOOL _isRight;//NO是普通类型的;YES是右对齐间距10像素
    NSInteger _right;
    
    BOOL _isHideDeleteLine;//是否显示删除线
    UIColor *_lineColor;
    CGRect _lineFrame;
    UIView *_lineView;
    
    NSMutableAttributedString *resultAttributedString;

}

- (id)initWithFrame:(CGRect)frame
           andColor:(UIColor *)color
         andFontNum:(CGFloat)num{
    self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:color];
        [self setFont:[UIFont systemFontOfSize:num]];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
               Font:(CGFloat)font
            BGColor:(UIColor *)color
          FontColor:(UIColor *)fontColor {
    self = [super initWithFrame:frame];
    if (self) {
        [self setFont:[UIFont systemFontOfSize:font]];
        [self setTextColor:fontColor];
        [self setBackgroundColor:color];
        //        _isHideDeleteLine = YES;
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame BoldFont:(CGFloat)font BGColor:(UIColor *)color FontColor:(UIColor *)fontColor {
    self = [super initWithFrame:frame];
    if (self) {
        [self setFont:[UIFont boldSystemFontOfSize:font]];
        [self setTextColor:fontColor];
        [self setBackgroundColor:color];
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds
     limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            break;
        default:
            break;
    }
    return textRect;
}

- (void)setIsRight:(BOOL)isRight Right:(NSInteger)right {
    _isRight = isRight;
    _right = right;
}

- (void)setIsShowDeleteLine:(BOOL)isHideDeleteLine LineFrame:(CGRect)lineFrame LineColor:(UIColor *)lineColor {
    _isHideDeleteLine = isHideDeleteLine;
    _lineFrame = lineFrame;
    _lineColor = lineColor;
}

- (void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    CGRect transRect = CGRectMake(0, 0, requestedRect.size.width - _right, requestedRect.size.height);
    
    if(nil == _lineView){
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
    }
    [_lineView setHidden:NO];
    [_lineView setFrame:_lineFrame];
    
    [_lineView setBackgroundColor:_lineColor];
    
    [super drawTextInRect:_isRight ? transRect:actualRect];
}

//- (void)drawRect:(CGRect)rect
//{
//    if (!_isHideDeleteLine)
//    {
//        CGSize contentSize = [self.text sizeWithFont:self.font constrainedToSize:self.frame.size];
//        CGContextRef c = UIGraphicsGetCurrentContext();
//        CGFloat color[4] = {0.667, 0.667, 0.667, 1.0};
//        [_lineColor getRed:&color[0] green:&color[1] blue:&color[2] alpha:&color[3]];
//        CGContextSetStrokeColor(c, color);
//        CGContextSetLineWidth(c, 2);
//        CGContextBeginPath(c);
//        CGFloat halfWayUp = (self.bounds.size.height - self.bounds.origin.y) / 2.0;
//        CGContextMoveToPoint(c, self.bounds.origin.x, halfWayUp );
//        CGContextAddLineToPoint(c, self.bounds.origin.x + contentSize.width, halfWayUp);
//        CGContextStrokePath(c);
//    }
//
//    [super drawRect:rect];
//}
-(void)setKeyWordTextString:(NSString *)keyWordArray WithFont:(UIFont *)font AndColor:(UIColor *)keyWordColor{
    NSMutableArray *rangeArray = [[NSMutableArray alloc]init];
    NSRange range = [self.text rangeOfString:keyWordArray];
    NSValue *value = [NSValue valueWithRange:range];
    if (range.length > 0) {
        [rangeArray addObject:value];
    }
    for (NSValue *value in rangeArray) {
        NSRange keyRange = [value rangeValue];
        [resultAttributedString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)keyWordColor.CGColor range:keyRange];
        CTFontRef ctFont1 = CTFontCreateWithName(( CFStringRef)font.fontName, font.pointSize,NULL);
        [resultAttributedString addAttribute:(NSString *)(kCTFontAttributeName) value:(__bridge id)ctFont1 range:keyRange];
        CFRelease(ctFont1);
        
    }
}
-(void)drawView{
    // Drawing code
    if (self.text !=nil) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0.0, 0.0);//move
        CGContextScaleCTM(context, 1.0, -1.0);
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge  CFAttributedStringRef)resultAttributedString);
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGPathAddRect(pathRef,NULL , CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));//const CGAffineTransform *m
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), pathRef,NULL );//CFDictionaryRef frameAttributes
        CGContextTranslateCTM(context, 0, -self.bounds.size.height);
        CGContextSetTextPosition(context, 0, 0);
        CTFrameDraw(frame, context);
        CGContextRestoreGState(context);
        
        CGPathRelease(pathRef);
        CFRelease(framesetter);
        UIGraphicsPushContext(context);
        
    }
    
}
- (void)drawRect:(CGRect)rect
{
    if (resultAttributedString&&resultAttributedString.length>0) {
        // Drawing code
        if (self.text !=nil) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 0.0, 0.0);//move
            CGContextScaleCTM(context, 1.0, -1.0);
            CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge  CFAttributedStringRef)resultAttributedString);
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGPathAddRect(pathRef,NULL , CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));//const CGAffineTransform *m
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), pathRef,NULL );//CFDictionaryRef frameAttributes
            CGContextTranslateCTM(context, 0, -self.bounds.size.height);
            CGContextSetTextPosition(context, 0, 0);
            CTFrameDraw(frame, context);
            CGContextRestoreGState(context);
            CGPathRelease(pathRef);
            CFRelease(framesetter);
            UIGraphicsPushContext(context);
            
        }
    }
    else{
        [super drawRect:rect];
    }
}

@end

