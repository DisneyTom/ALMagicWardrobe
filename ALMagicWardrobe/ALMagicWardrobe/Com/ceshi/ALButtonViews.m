//
//  ALButtonViews.m
//  ALMagicWardrobe
//
//  Created by yyq on 3/19/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import "ALButtonViews.h"
#import "ALExamingHeader.h"

@interface ALButtonViews ()
{
    UIView *alShowBackgroundView;
}
@end
@implementation ALButtonViews
@synthesize alArrayList;
@synthesize alSelected;
@synthesize delegate;
@synthesize alDataValue;
@synthesize alShowType;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)refreshShowViews:(CGSize)showSize titleColor:titleColor fontSize:(CGFloat)fontSize
{
    [self setupTitleViews:showSize titleColor:titleColor fontSize:fontSize];
}

-(void)refreshShowImagaViews:(CGSize)showSize //image
{
    UIView *showView =  [self setupImageViewsWithArray:alArrayList showSize:showSize];
    alShowBackgroundView = showView;
    [self addSubview:showView];
}
#pragma mark -

-(void) setupTitleViews:(CGSize)showSize titleColor:(UIColor*)titleColor fontSize:(CGFloat)fontSize
{
   UIView *showView =  [self setupViewsWithArray:alArrayList showSize:showSize titleColor:titleColor fontSize:fontSize];
    alShowBackgroundView = showView;
    [self addSubview:showView];
}

//image
-(UIView *) setupImageViewsWithArray:(NSArray*)arrayList showSize:(CGSize)showSize
{
    UIView*viewShow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    
    NSUInteger butNumber = [arrayList count];
    
    CGFloat distance = 1;
    CGFloat startFix = 10;
    NSUInteger showWidth =  showSize.width - startFix*2;
    CGFloat buttonLength = showWidth/butNumber;//  (showSize.width-distance*butNumber) / (butNumber*1.0);
    NSUInteger loop = 0;
    //    if (butNumber == 5) {
    //        distance = 20;
    //        buttonLength = 50;
    //    }
    
    //    CGFloat distance = 0;
    //    CGFloat buttonLength =  (showSize.width-distance*butNumber) / (butNumber*1.0);
    //    NSUInteger loop = 0;
    
    for (NSString *imageName in arrayList) {
//        UIView*viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
        
        
        NSUInteger startX = (buttonLength+distance)*loop+startFix;

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(startX,  0, buttonLength, AL_VIEW_DEFAULT_IMAGE_HEIGHT)];
        imageView.backgroundColor = [UIColor redColor];
        imageView.contentMode = UIViewContentModeScaleToFill;
        UIImage *image = [UIImage imageNamed:imageName];
        [imageView setImage:image];
        [viewShow addSubview:imageView];
        

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        btn.backgroundColor = [UIColor yellowColor];
        //        NSUInteger startX = (buttonLength+distance)*loop+distance;
        //        NSLog(@"start %d, len %d,%d", startX, (int)buttonLength,(int)showSize.width);
        //        [btn setFrame:CGRectMake(startX, (showSize.height-30)/2, buttonLength, 30)];
        [btn setFrame:CGRectMake(startX, AL_VIEW_DEFAULT_IMAGE_HEIGHT+1, buttonLength, 40)];
        
        [btn setImage: [UIImage imageNamed:@"icon025"] forState:UIControlStateNormal];
        [btn setImage: [UIImage imageNamed:@"icon024"] forState:UIControlStateHighlighted];
        [btn setTag:loop+AL_TAG_PRODUCT_START];
//        [btn setTitle:@"dfdfdf" forState:UIControlStateNormal];
//        btn.backgroundColor = [UIColor greenColor];
        //        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(toggleSelectedImgaeButton:)   forControlEvents:UIControlEventTouchDown];
        
        if (alSelected) {
            if ([alSelected integerValue] == loop) {
                [btn setImage: [UIImage imageNamed:@"icon024"] forState:UIControlStateNormal];
            }
        }
        loop++;
        
        [viewShow addSubview:btn];
    }
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(100, 20, 0, 0)];
    return viewShow;

}


-(UIView *) setupViewsWithArray:(NSArray*)arrayList showSize:(CGSize)showSize titleColor:(UIColor*)titleColor
    fontSize:(CGFloat)fontSize
{
    UIView*viewShow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    NSUInteger butNumber = [arrayList count];
    
    CGFloat distance = 1;
    CGFloat startFix = 10;
    NSUInteger showWidth =  showSize.width - startFix*2;
    CGFloat buttonLength = showWidth/butNumber;//  (showSize.width-distance*butNumber) / (butNumber*1.0);
    NSUInteger loop = 0;

    for (NSString *title in arrayList) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSUInteger startX = (buttonLength+distance)*loop+startFix;
        [btn setFrame:CGRectMake(startX, 0, buttonLength, showSize.height)];

        [btn setImage: [UIImage imageNamed:@"icon025"] forState:UIControlStateNormal];
        [btn setImage: [UIImage imageNamed:@"icon024"] forState:UIControlStateHighlighted];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize: fontSize]];
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [btn setTag:loop];
//        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(toggleSelectedButton:)   forControlEvents:UIControlEventTouchDown];

        if (alSelected) {
            if ([alSelected integerValue]== loop) {
                [btn setImage: [UIImage imageNamed:@"icon024"] forState:UIControlStateNormal];
            }
        }
        loop++;
    
        [viewShow addSubview:btn];
    }
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(100, 20, 0, 0)];
    return viewShow;
}

-(void) toggleSelectedImgaeButton:(id)sender
{
    UIButton *btn = sender;
    NSUInteger tag = btn.tag;
    for (UIButton *subBtn in alShowBackgroundView.subviews) {
        if (subBtn.tag == tag) {
            [subBtn setImage: [UIImage imageNamed:@"icon024"] forState:UIControlStateNormal];
        } else {
            [subBtn setImage: [UIImage imageNamed:@"icon025"] forState:UIControlStateNormal];
        }
        
    }
    alSelected = @(tag);
    if ([self.delegate respondsToSelector:@selector(ALButtonViewsHandle:thread:value:)]) {
        [self.delegate ALButtonViewsHandle:alDataValue thread:self value:alSelected];
    }
}

-(void) toggleSelectedButton:(id)sender
{
    UIButton *btn = sender;
    NSUInteger tag = btn.tag;
    for (UIButton *subBtn in alShowBackgroundView.subviews) {
        if (subBtn.tag == tag) {
            [subBtn setImage: [UIImage imageNamed:@"icon024"] forState:UIControlStateNormal];
        } else {
            [subBtn setImage: [UIImage imageNamed:@"icon025"] forState:UIControlStateNormal];
        }
        
    }
    alSelected = @(tag);
    if ([self.delegate respondsToSelector:@selector(ALButtonViewsHandle:thread:value:)]) {
        [self.delegate ALButtonViewsHandle:alDataValue thread:self value:alSelected];
    }
}





@end
