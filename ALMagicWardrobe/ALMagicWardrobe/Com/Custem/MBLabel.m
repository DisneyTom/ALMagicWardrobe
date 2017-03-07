//
//  MBLabel.m
//  BOCMBCI
//
//  Created by Tracy E on 13-4-8.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import "MBLabel.h"
#import "CMPopTipView.h"
#import "UIViewAdditions.h"
#import "MBConstant.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>


#define MBLabelTipWillShowNotification @"MBLabelTipWillShowNotification"

@interface MBLabel ()<CMPopTipViewDelegate,UIScrollViewDelegate, UITableViewDelegate>{
    CMPopTipView *_tipView;
    UITapGestureRecognizer *_tapGesturer;
    NSTimer *_paoMDTimer;//跑马灯timer
    NSMutableAttributedString *resultAttributedString;
}

@property (nonatomic, strong) UILabel *paoMaDengLabel;

@end

@implementation MBLabel

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MBLabelTipWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MBUserDidLogoutNotification
                                                  object:nil];
    [self removeLabel];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    resultAttributedString = [[NSMutableAttributedString alloc]init];
    [self setShowFullTextIfNeeded];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self setShowFullTextIfNeeded];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setShowFullTextIfNeeded];
}

- (void)removeLabel
{
    self.userInteractionEnabled = NO;
    [self removeGestureRecognizer:_tapGesturer];
    
    if (_isPaoMaDeng) {
        if (_paoMaDengLabel) {
            self.textColor = _paoMaDengLabel.textColor;
            [_paoMaDengLabel removeFromSuperview];
            _paoMaDengLabel = nil;
        }
        
        if (_paoMDTimer) {
            [_paoMDTimer invalidate];
            _paoMaDengLabel = nil;
        }
    }
}

- (void)setShowFullTextIfNeeded{
    [self removeLabel];
    
    BOOL longer = NO;
    float fullWidth = [self.text sizeWithFont:self.font].width;
    NSInteger numberOfLines = self.numberOfLines;
    if (numberOfLines!= 1) {
        CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, self.frame.size.height*300)];
        if (size.height > self.frame.size.height) {
            longer = YES;
        }
    }
    else{
        if (fullWidth > self.frame.size.width) {
            longer = YES;
        }
    }
    if (longer) {
        
        if (_isPaoMaDeng) {//跑马灯
            _paoMaDengLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, fullWidth, self.frame.size.height)];
            _paoMaDengLabel.text = self.text;
            _paoMaDengLabel.font = self.font;
            _paoMaDengLabel.textColor = self.textColor;
            _paoMaDengLabel.backgroundColor = [UIColor clearColor];
            _paoMaDengLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_paoMaDengLabel];
            
            self.textColor = [UIColor clearColor];
            
            _paoMDTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:0.5] interval:0.1 target:self selector:@selector(beginPaoMaDengAnimation) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_paoMDTimer forMode:NSRunLoopCommonModes];
            [_paoMDTimer fire];
            
        }else{//气泡提示
            self.userInteractionEnabled = YES;
            _tapGesturer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFullText)];
            [self addGestureRecognizer:_tapGesturer];
        }
    }
}

- (void)setIsPaoMaDeng:(BOOL)isPaoMaDeng{
    
    _isPaoMaDeng = isPaoMaDeng;
    
    [self setShowFullTextIfNeeded];
}

- (void)beginPaoMaDengAnimation
{
    if (abs(_paoMaDengLabel.frame.origin.x) < _paoMaDengLabel.frame.size.width) {
        _paoMaDengLabel.frame = CGRectOffset(_paoMaDengLabel.frame, -1, 0);
    }else{
        _paoMaDengLabel.frame = CGRectMake(self.frame.size.width, 0, _paoMaDengLabel.frame.size.width, _paoMaDengLabel.frame.size.height);
    }
}

- (void)hideTipIfNeeded{
    if (_tipView) {
        [_tipView dismissAnimated:YES];
        _tipView = nil;
    }
}

- (void)showFullText{
    if (!_tipView) {
 
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MBLabelTipWillShowNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(hideTipIfNeeded)
                                                     name:MBLabelTipWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:MBLabelTipWillShowNotification object:nil];
        
       
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(hideTipIfNeeded)
                                                     name:MBUserDidLogoutNotification
                                                   object:nil];

        _tipView = [[CMPopTipView alloc] initWithMessage:self.text];
        _tipView.dismissTapAnywhere = YES;
        _tipView.delegate = self;
        _tipView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8];
        _tipView.borderColor = [UIColor clearColor];
        _tipView.textColor = [UIColor whiteColor];
        [_tipView presentPointingAtView:self inView:self.window animated:YES];
    } else {
        [_tipView dismissAnimated:YES];
        _tipView = nil;
    }
}


#pragma mark CMPopTipView Delegate Method
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView{
    _tipView = nil;
}

//-(void)noSameFontShow:(NSString *)sepBiao andFirFont:(UIFont *)firFont andSepFont:(UIFont *)sepFont{
//    float firstWidth=[[self.text substringToIndex:(self.text.length-sepBiao.length)] sizeWithFont:firFont].width;
//    float sepWidth=[sepBiao sizeWithFont:sepFont].width;
//    
//    UIView *lblView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, firstWidth+sepWidth, self.frame.size.height)];
//    [lblView setBackgroundColor:[UIColor clearColor]];
//    
//    UILabel *oneLbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, firstWidth, self.frame.size.height)];
//    oneLbl.text=[self.text substringToIndex:(self.text.length-sepBiao.length)];
//    oneLbl.font=firFont;
//    oneLbl.textColor=self.textColor;
//    oneLbl.backgroundColor=[UIColor clearColor];
//    
//    NSLog(@"one==%f",[self.text sizeWithFont:firFont].height);
//    NSLog(@"two==%f",[sepBiao sizeWithFont:sepFont].height);
//    
//    UILabel *twoLbl=[[UILabel alloc] initWithFrame:CGRectMake(firstWidth, ([self.text sizeWithFont:firFont].height/2.0f-[sepBiao sizeWithFont:sepFont].height/2.0f)/2, sepWidth, self.frame.size.height)];
//    twoLbl.text=sepBiao;
//    twoLbl.font=sepFont;
//    twoLbl.textColor=self.textColor;
//    twoLbl.backgroundColor=[UIColor clearColor];
//    
//    [lblView addSubview:oneLbl];
//    [lblView addSubview:twoLbl];
//    
//    [self addSubview:lblView];
//
//    self.textColor=[UIColor clearColor];
//    
//    //创建AttributeString
//    
//    NSMutableAttributedString *string =[[NSMutableAttributedString alloc]initWithString:self.text];
//    
//    //设置字体及大小
//    
//    CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)self.font.fontName,self.font.pointSize,NULL);
//    
//    [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[string length])];
//}

-(void)setText:(NSString *)text WithFont:(UIFont *)font AndColor:(UIColor *)color{
    if (text.length == 0) {
        return;
    }
    self.text = text;
    int len = [text length];
    NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc]initWithString:text];
    [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)color.CGColor range:NSMakeRange(0, len)];
    CTFontRef ctFont2 = CTFontCreateWithName((CFStringRef)(font.fontName), font.pointSize,NULL);
    [mutaString addAttribute:(NSString *)(kCTFontAttributeName) value:(__bridge id)ctFont2 range:NSMakeRange(0, len)];
    CFRelease(ctFont2);
    resultAttributedString = mutaString;
}
-(void)setKeyWordTextArray:(NSArray *)keyWordArray WithFont:(UIFont *)font AndColor:(UIColor *)keyWordColor{
    NSMutableArray *rangeArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [keyWordArray count]; i++) {
        NSString *keyString = [keyWordArray objectAtIndex:i];
        NSRange range = [self.text rangeOfString:keyString];
        NSValue *value = [NSValue valueWithRange:range];
        if (range.length > 0) {
            [rangeArray addObject:value];
        }
    }
    for (NSValue *value in rangeArray) {
        NSRange keyRange = [value rangeValue];
        [resultAttributedString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)keyWordColor.CGColor range:keyRange];
        CTFontRef ctFont1 = CTFontCreateWithName(( CFStringRef)font.fontName, font.pointSize,NULL);
        [resultAttributedString addAttribute:(NSString *)(kCTFontAttributeName) value:(__bridge  id)ctFont1 range:keyRange];
        CFRelease(ctFont1);
        
    }
    [self drawView];

}

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
    NSLog(@"%s",__func__);
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
    NSLog(@"%s",__func__);
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
