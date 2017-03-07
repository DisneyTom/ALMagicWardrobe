//
//  ALTwoProductView.m
//  ALMagicWardrobe
//
//  Created by frank on 15/3/19.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALTwoProductView.h"
#import "ALExamingHeader.h"
#import "ALButtonViews.h"
#import "ALExampleManager.h"

@interface ALTwoProductView()<ALButtonViewsDelegate>
{
    
}
@end


@implementation ALTwoProductView

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
        [self setBackgroundColor:ALUIColorFromHex(0XF0EEEA)];
        [self setupViews];
    }
    return self;
}


-(void) setupViews
{
    
    CGFloat startY = 10;
    CGRect  frame = CGRectMake(0, startY, kScreenWidth, 60);
    [self setupShowShoulderViewWithFrame:frame];
    
    startY += 80;
    frame = CGRectMake(0, startY, kScreenWidth, 60);
    [self setupShowNeckViewWithFrame:frame];
    
    startY += 80;
    frame = CGRectMake(0, startY, kScreenWidth, 60);
    [self setupShowUpperArmViewWithFrame:frame];
    
    startY += 80;
    frame = CGRectMake(0, startY, kScreenWidth, 60);
    [self setupShowCalfViewWithFrame:frame];
    
    startY += 80;
    frame = CGRectMake(0, startY, kScreenWidth, 60);
    [self setupShowThighViewWithFrame:frame];

    startY += 80;
    frame = CGRectMake(0, startY, kScreenWidth, 60);
    [self setupShowClothingSizesViewWithFrame:frame];
}

#pragma mark -
//Shoulder
-(void) setupShowShoulderViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getShoulderHeadDictionaryValue];
    UIView *showView = [self  getButtonListViewWithSize:frame.size showProperty:dictValue];
    [showView setFrame:frame];
    [contentView addSubview:showView];
}

-(void) setupShowNeckViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getNeckHeadDictionaryValue];
    UIView *showView = [self  getButtonListViewWithSize:frame.size showProperty:dictValue];
    [showView setFrame:frame];
    [contentView addSubview:showView];
}

-(void) setupShowUpperArmViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getUpperArmHeadDictionaryValue];
    UIView *showView = [self  getButtonListViewWithSize:frame.size showProperty:dictValue];
    [showView setFrame:frame];
    [contentView addSubview:showView];
}
-(void) setupShowCalfViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getCalfHeadDictionaryValue];
    UIView *showView = [self  getButtonListViewWithSize:frame.size showProperty:dictValue];
    [showView setFrame:frame];
    [contentView addSubview:showView];
}
-(void) setupShowThighViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getThighHeadDictionaryValue];
    UIView *showView = [self  getButtonListViewWithSize:frame.size showProperty:dictValue];
    [showView setFrame:frame];
    [contentView addSubview:showView];
}
//ClothingSizes
-(void) setupShowClothingSizesViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getClothingSizesHeadDictionaryValue];
    UIView *showView = [self  getButtonListViewWithSize:frame.size showProperty:dictValue];
    [showView setFrame:frame];
    [contentView addSubview:showView];
}

#pragma mark - GETVALUE
-(NSDictionary*)getShoulderHeadDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@(AL_DEFAULT_BUTTONFONTSIZE) forKey:AL_KEY_PROPERTY_BUTTONFONTSIZE];
    
    [dictValue setValue:@"6、你的肩部" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(AL_DEFAULT_TITLEFONTSIZE) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getShoulderHadValue] forKey:AL_KEY_PROPERTY_SELEVALUE];
    NSString *stringList = @"较窄,适中,较宽";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    [dictValue setValue:arrayList forKey:AL_KEY_PROPERTY_ARRAYLIST];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_SHOULDER) forKey:AL_KEY_PROPERTY_TAG];
    
    return dictValue;
}
//Neck
-(NSDictionary*)getNeckHeadDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@(AL_DEFAULT_BUTTONFONTSIZE) forKey:AL_KEY_PROPERTY_BUTTONFONTSIZE];
    
    [dictValue setValue:@"7、你的颈部" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(AL_DEFAULT_TITLEFONTSIZE) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getNeckHadValue] forKey:AL_KEY_PROPERTY_SELEVALUE];
    NSString *stringList = @"适中,修长,略粗";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    [dictValue setValue:arrayList forKey:AL_KEY_PROPERTY_ARRAYLIST];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_NECK) forKey:AL_KEY_PROPERTY_TAG];
    
    return dictValue;
}

-(NSDictionary*)getUpperArmHeadDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@(AL_DEFAULT_BUTTONFONTSIZE) forKey:AL_KEY_PROPERTY_BUTTONFONTSIZE];
    
    [dictValue setValue:@"8、你的上臂" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(AL_DEFAULT_TITLEFONTSIZE) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getUpperArmHadValue] forKey:AL_KEY_PROPERTY_SELEVALUE];
    NSString *stringList = @"适中,修长,略粗";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    [dictValue setValue:arrayList forKey:AL_KEY_PROPERTY_ARRAYLIST];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_UPPERARM) forKey:AL_KEY_PROPERTY_TAG];
    
    return dictValue;
}
-(NSDictionary*)getCalfHeadDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@(AL_DEFAULT_BUTTONFONTSIZE) forKey:AL_KEY_PROPERTY_BUTTONFONTSIZE];
    
    [dictValue setValue:@"9、你的小腿" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(AL_DEFAULT_TITLEFONTSIZE) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getCalfHadValue] forKey:AL_KEY_PROPERTY_SELEVALUE];
    NSString *stringList = @"适中,修长,略粗";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    [dictValue setValue:arrayList forKey:AL_KEY_PROPERTY_ARRAYLIST];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_CALF) forKey:AL_KEY_PROPERTY_TAG];
    
    return dictValue;
}
-(NSDictionary*)getThighHeadDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@(AL_DEFAULT_BUTTONFONTSIZE) forKey:AL_KEY_PROPERTY_BUTTONFONTSIZE];
    
    [dictValue setValue:@"10、你的大腿" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(AL_DEFAULT_TITLEFONTSIZE) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getThighHadValue] forKey:AL_KEY_PROPERTY_SELEVALUE];
    NSString *stringList = @"适中,修长,略粗";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    [dictValue setValue:arrayList forKey:AL_KEY_PROPERTY_ARRAYLIST];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_THIGH) forKey:AL_KEY_PROPERTY_TAG];
    
    return dictValue;
}

//ClothingSizes
-(NSDictionary*)getClothingSizesHeadDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@(AL_DEFAULT_BUTTONFONTSIZE) forKey:AL_KEY_PROPERTY_BUTTONFONTSIZE];
    
    [dictValue setValue:@"11、你常穿的衣服尺码" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(AL_DEFAULT_TITLEFONTSIZE) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getClothingSizesHadValue] forKey:AL_KEY_PROPERTY_SELEVALUE];
    NSString *stringList = @"XS,S,M,L,XL";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    [dictValue setValue:arrayList forKey:AL_KEY_PROPERTY_ARRAYLIST];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_CLOTHINGSIZES) forKey:AL_KEY_PROPERTY_TAG];
    
    return dictValue;
}

#pragma mark - GETVIEW
-(UIView*) getMainbackgroundView
{
    return self;
}

-(UIView*)getButtonListViewWithSize:(CGSize)showSize  showProperty:(NSDictionary*)showProperty
{
    UIView*viewShow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    NSString *title = [showProperty objectForKey:AL_KEY_PROPERTY_TITLE];
    NSNumber *titleFontSize = [showProperty objectForKey:AL_KEY_PROPERTY_TITLESIZE];
    UIColor *titleColor = [showProperty objectForKey:AL_KEY_PROPERTY_COLOER];
    NSNumber *startX = [showProperty objectForKey:AL_KEY_PROPERTY_STARTX];
    NSArray *arrayList = [showProperty objectForKey:AL_KEY_PROPERTY_ARRAYLIST];
    UIColor *btnTitleColor = [showProperty objectForKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    NSNumber *tag = [showProperty objectForKey:AL_KEY_PROPERTY_TAG];
    id selectedValue = [showProperty objectForKey:AL_KEY_PROPERTY_SELEVALUE];
    NSNumber *btnFontSize = [showProperty objectForKey:AL_KEY_PROPERTY_BUTTONFONTSIZE];
    
    viewShow.tag = [tag integerValue];
    
    NSUInteger viewHeight = AL_VIEW_DEFAULT_BTNLIST_HEIGHT; //每一个界面的高
    NSUInteger labelViewWidth = 180;
    NSUInteger labelViewHeight = 30;
    
    
    CGFloat cgStartX = 10;
    if (startX) {
        cgStartX = [startX integerValue];
    }
    
    CGSize labelSize = CGSizeMake(labelViewWidth, labelViewHeight);
    ALLabel *label = [self getLabelViewWithSize:showSize titleColor:titleColor fontSize:titleFontSize title:title];
    label.tag = AL_TAG_PRODUCT_LABEL;
    [label setFrame:CGRectMake(cgStartX, (viewHeight- labelViewHeight)/2, labelSize.width, labelSize.height)];
    [viewShow addSubview:label];
    
    
    NSUInteger btnViewWidth = showSize.width;
    NSUInteger btnViewHeight = 50;
    
    CGSize buttonSize = CGSizeMake(btnViewWidth, btnViewHeight);
    UIView *viewButtons = [self getViewWithArray:arrayList titleColor:btnTitleColor value:selectedValue showSize:buttonSize tag:tag fontSize:[btnFontSize floatValue]];
    [viewButtons setFrame:CGRectMake(0, labelViewHeight+5, buttonSize.width, buttonSize.height)];
    [viewShow addSubview:viewButtons];
    return viewShow;
    
    
}

-(ALLabel*)getLabelViewWithSize:(CGSize)showSize titleColor:(UIColor*)titleColor fontSize:(NSNumber*)fontSize title:(NSString*)title
{
    ALLabel *labelContent =[[ALLabel alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    [labelContent setTextAlignment:NSTextAlignmentLeft];
    [labelContent setFont:[UIFont boldSystemFontOfSize:[fontSize integerValue]]];
    [labelContent setTextColor:titleColor];
    [labelContent setText:title];
    return labelContent;
}

-(UIView*) getViewWithArray:(NSArray*)arrayList titleColor:(UIColor*)titleColor value:(id)value showSize:(CGSize)showSize tag:(id)tag  fontSize:(CGFloat)fontSize;
{
    ALButtonViews *view = [[ALButtonViews alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    view.alArrayList = arrayList;
    view.delegate = self;
    view.alDataValue = tag;
    view.alSelected = value;
    [view refreshShowViews:showSize titleColor:titleColor fontSize:fontSize];
    return view;
}

#pragma mark -
-(id) getShoulderHadValue
{
    id value = [[ALExampleManager sharedInstance] readShoulderValue];
    return value;
}

-(id) getNeckHadValue
{
    id value = [[ALExampleManager sharedInstance] readNeckValue];
    return value;
}

-(id) getUpperArmHadValue
{
    id value = [[ALExampleManager sharedInstance] readUpperArmValue];
    return value;
}

//Calf
-(id) getCalfHadValue
{
    id value = [[ALExampleManager sharedInstance] readCalfValue];
    return value;
}

//Thigh
-(id) getThighHadValue
{
    id value = [[ALExampleManager sharedInstance] readThighValue];
    return value;
}

-(id) getClothingSizesHadValue
{
    id value = [[ALExampleManager sharedInstance] readClothingSizesValue];
    return value;
}



#pragma mark -
-(void) ALButtonViewsHandle:(id)data thread:(id)thread value:(id)value;
{
    NSLog(@" %@,%@", data, value);
    NSUInteger tag  = [data integerValue];
    
    if (tag == AL_TAG_PRODUCT_START+AL_TYPE_DATA_SHOULDER) {
        [[ALExampleManager sharedInstance] saveShoulderValue:value];
    }
    if (tag == AL_TAG_PRODUCT_START+AL_TYPE_DATA_NECK) {
        [[ALExampleManager sharedInstance] saveNeckValue:value];
    }
}
@end
