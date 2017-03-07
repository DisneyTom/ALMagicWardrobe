//
//  ALOneProductView.m
//  ALMagicWardrobe
//
//  Created by frank on 15/3/19.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALOneProductView.h"
#import "ALButtonViews.h"
#import "ALExampleManager.h"
#import "ALExamingHeader.h"

@interface ALOneProductView()<ALButtonViewsDelegate>
{
    NSUInteger alLineOrgy;
    
}
@end
@implementation ALOneProductView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawLine:alLineOrgy];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)drawLine:(NSUInteger)startY
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextSetLineWidth(context,0.5);//线宽度
    CGContextSetStrokeColorWithColor(context, AL_RGB(136,136,136).CGColor);
    
    CGFloat lengths[] = {4,2};//先画4个点再画2个点
    CGContextSetLineDash(context,0, lengths,2);//注意2(count)的值等于lengths数组的长度
    
    CGContextMoveToPoint(context,5,startY);
    CGContextAddLineToPoint(context,kScreenWidth-5,startY);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

-(void) setupViews
{
    [self setBackgroundColor:ALUIColorFromHex(0XF0EEEA)];

    UIView *contentView = self;
    NSUInteger startX = 10;
    ALLabel *lableTitle=[[ALLabel alloc]
                     initWithFrame:CGRectMake(0, 30, kScreenWidth, 20)];
    [lableTitle setText:@"用户测试题及测试结果"];
    [lableTitle setTextAlignment:NSTextAlignmentCenter];
    [lableTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [lableTitle setTextColor:ALUIColorFromHex(0X5F5D59)];
    [contentView addSubview:lableTitle];
    
    
    ALLabel *labelDirHead=[[ALLabel alloc]
                     initWithFrame:CGRectMake(startX, lableTitle.bottom+20, kScreenWidth-startX*2, 20)];
    [labelDirHead setText:@"一，我的模形"];
    [labelDirHead setTextAlignment:NSTextAlignmentLeft];
    [labelDirHead setFont:[UIFont boldSystemFontOfSize:18]];
    [labelDirHead setTextColor:ALUIColorFromHex(0X946E3A)];
    [contentView addSubview:labelDirHead];
    
    ALLabel *labelDirDetail=[[ALLabel alloc]
                           initWithFrame:CGRectMake(startX, lableTitle.bottom+20, kScreenWidth-startX*2, 120)];
    [labelDirDetail setText:@"赶快填写你的体型数据吧，我们将为你精选适合你身材的服装，你可以在任何时候进行修改，所以不要有压力哦！"];
    labelDirDetail.lineBreakMode = NSLineBreakByWordWrapping;
    labelDirDetail.numberOfLines = 3;
    alLineOrgy = labelDirDetail.bottom-10;

    [labelDirDetail setTextAlignment:NSTextAlignmentLeft];
    [labelDirDetail setFont:[UIFont boldSystemFontOfSize:17]];
    [labelDirDetail setTextColor:ALUIColorFromHex(0X979591)];
    [contentView addSubview:labelDirDetail];

    
    CGFloat startY  = alLineOrgy+10;
    CGRect frame = CGRectMake(0, startY, kScreenWidth, 100);
    [self setupShowHeightViewWithFrame:frame];

    startY += AL_VIEW_DEFAULT_HEIGHT;
    frame = CGRectMake(0, startY, kScreenWidth, 100);
    [self setupShowWeightViewWithFrame:frame];

    
    startY += AL_VIEW_DEFAULT_HEIGHT;
    frame = CGRectMake(0, startY, kScreenWidth, 100);
    [self setupShowBrasizeViewWithFrame:frame];
    
    
    startY += 90;
    frame = CGRectMake(0, startY, kScreenWidth, 60);
    [self setupShowWaistViewWithFrame:frame];

    startY += 60;
    frame = CGRectMake(0, startY, kScreenWidth, 80);
    [self setupShowButtockViewWithFrame:frame];
    
//    
//    //身高
//    ALLabel *labelSubject1 =[[ALLabel alloc] initWithFrame:CGRectMake(startX, startY+(viewHeight-30)/2, 100, 30)];
//    [labelSubject1 setText:@"1、你的身高"];
//    [labelSubject1 setTextAlignment:NSTextAlignmentLeft];
//    [labelSubject1 setFont:[UIFont boldSystemFontOfSize:16]];
//    [labelSubject1 setTextColor:AL_COLOR_SUBJECT];
//    [contentView addSubview:labelSubject1];
//
//    UIImage *imageInputBack  = [UIImage imageNamed:@"input_box"];
//    UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(startX + 115, startY, 157, viewHeight)];
//    [imageView1 setImage:imageInputBack];
//    [contentView addSubview:imageView1];
//    
//    ALTextField *textField1 = [[ALTextField alloc] initWithFrame:CGRectMake(startX + 127, startY+2, 140, viewHeight-4)];
//    [textField1 setTag:AL_TAG_PRODUCT_START +1];
////    [textField1 setDelegate:self];
//    [textField1 setTextViewDelegate:self];
//    [textField1 setPlaceholder:@"请输入身高(厘米)"];
//    [textField1 setFont:[UIFont systemFontOfSize:16]];
//    [textField1 setBackgroundColor:[UIColor whiteColor]];
//    [textField1 setTextAlignment:NSTextAlignmentCenter];
//    [contentView addSubview:textField1];
//    
//    
//    //体重
//    startY+=(viewHeight +10);
//    ALLabel *labelSubject2 =[[ALLabel alloc] initWithFrame:CGRectMake(startX, startY+(viewHeight-30)/2, 100, 30)];
//    [labelSubject2 setText:@"2、你的体重"];
//    [labelSubject2 setTextAlignment:NSTextAlignmentLeft];
//    [labelSubject2 setFont:[UIFont boldSystemFontOfSize:16]];
//    [labelSubject2 setTextColor:AL_COLOR_SUBJECT];
//    [contentView addSubview:labelSubject2];
//    
//    UIImageView *imageView2=[[UIImageView alloc] initWithFrame:CGRectMake(startX + 115, startY, 157, viewHeight)];
//    [imageView2 setImage:imageInputBack];
//    [contentView addSubview:imageView2];
//    
//    ALTextField *textField2 = [[ALTextField alloc] initWithFrame:CGRectMake(startX + 127, startY+2, 140, viewHeight-4)];
//    [textField2 setTag:AL_TAG_PRODUCT_START +2];
//    [textField1 setTextViewDelegate:self];
//    [textField2 setPlaceholder:@"请输入体重(kg)"];
//    [textField2 setFont:[UIFont systemFontOfSize:16]];
//    [textField2 setBackgroundColor:[UIColor whiteColor]];
//    [textField2 setTextAlignment:NSTextAlignmentCenter];
//    [contentView addSubview:textField2];
//
//    
//    
//    //尺寸
//    startY+=(viewHeight +10);
//    ALLabel *labelSubject3 =[[ALLabel alloc] initWithFrame:CGRectMake(startX, startY+(viewHeight-30)/2, 150, 30)];
//    [labelSubject3 setText:@"3、你的胸衣尺寸"];
//    [labelSubject3 setTextAlignment:NSTextAlignmentLeft];
//    [labelSubject3 setFont:[UIFont boldSystemFontOfSize:16]];
//    [labelSubject3 setTextColor:AL_COLOR_SUBJECT];
//    [contentView addSubview:labelSubject3];
//    
//    startY+=(viewHeight +10);
//    ALLabel *labelContent3A =[[ALLabel alloc] initWithFrame:CGRectMake(startX+30, startY+(viewHeight-30)/2, 100, 30)];
//    [labelContent3A setText:@"下胸围"];
//    [labelContent3A setTextAlignment:NSTextAlignmentLeft];
//    [labelContent3A setFont:[UIFont boldSystemFontOfSize:16]];
//    [labelContent3A setTextColor:AL_COLOR_CONTENT];
//    [contentView addSubview:labelContent3A];
//    
//    UIImageView *imageView3A=[[UIImageView alloc] initWithFrame:CGRectMake(startX + 115, startY, 157, viewHeight)];
//    [imageView3A setImage:imageInputBack];
//    [contentView addSubview:imageView3A];
//
//    ALTextField *textField3A = [[ALTextField alloc] initWithFrame:CGRectMake(startX + 127, startY+2, 140, viewHeight-4)];
//    [textField3A setTag:AL_TAG_PRODUCT_START +3];
//    [textField1 setTextViewDelegate:self];
//    [textField3A setPlaceholder:@"请输胸围尺寸(厘米)"];
//    [textField3A setFont:[UIFont systemFontOfSize:16]];
//    [textField3A setBackgroundColor:[UIColor whiteColor]];
//    [textField3A setTextAlignment:NSTextAlignmentCenter];
//    [contentView addSubview:textField3A];
//    
//    
//    startY+=(viewHeight +10);
//    ALLabel *labelContent3B =[[ALLabel alloc] initWithFrame:CGRectMake(startX+30, startY+(viewHeight-30)/2, 100, 30)];
//    [labelContent3B setText:@"罩杯"];
//    [labelContent3B setTextAlignment:NSTextAlignmentLeft];
//    [labelContent3B setFont:[UIFont boldSystemFontOfSize:16]];
//    [labelContent3B setTextColor:AL_COLOR_CONTENT];
//    [contentView addSubview:labelContent3B];
//    
//    UIImageView *imageView3B=[[UIImageView alloc] initWithFrame:CGRectMake(startX + 115, startY, 157, viewHeight)];
//    [imageView3B setImage:imageInputBack];
//    [contentView addSubview:imageView3B];
//    //
//    ALTextField *textField3B = [[ALTextField alloc] initWithFrame:CGRectMake(startX + 127, startY+2, 140, viewHeight-4)];
//    [textField3B setTag:AL_TAG_PRODUCT_START +4];
//    [textField1 setTextViewDelegate:self];
//    [textField3B setPlaceholder:@"AA"];
//    [textField3B setFont:[UIFont systemFontOfSize:16]];
//    [textField3B setBackgroundColor:[UIColor whiteColor]];
//    [textField3B setTextAlignment:NSTextAlignmentCenter];
//    [contentView addSubview:textField3B];
// 
//    
//    
//    腰部
//    startY +=10;
    
   
    
    
}

-(UIView*) getViewWithArray:(NSArray*)arrayList titleColor:(UIColor*)titleColor value:(id)value showSize:(CGSize)showSize tag:(id)tag  fontSize:(CGFloat)fontSize;
{
    ALButtonViews *view = [[ALButtonViews alloc] initWithFrame:CGRectMake(0, 420, kScreenWidth, 200)];
    view.alArrayList = arrayList;
    view.delegate = self;
    view.alDataValue = tag;
    view.alSelected = value;
    [view refreshShowViews:showSize titleColor:titleColor fontSize:fontSize];
    return view;
}

#pragma mark -
-(void) ALButtonViewsHandle:(id)data thread:(id)thread value:(id)value;
{
    NSLog(@" %@,%@", data, value);
    NSUInteger tag  = [data integerValue];
    
    if (tag == AL_TAG_PRODUCT_START+AL_TYPE_DATA_WAIST) {
        [[ALExampleManager sharedInstance] saveWaistValue:value];
    }
    if (tag == AL_TAG_PRODUCT_START+AL_TYPE_DATA_BUTTOCK) {
        [[ALExampleManager sharedInstance] saveButtockValue:value];
    }
}


//#pragma mar - TEXTFIELD
//- (void)textViewDidCancelEditing:(ALTextField *)textField //点击键盘上的“取消”按钮。
//{
//    NSLog(@"llll");
//}
//- (void)textViewDidFinsihEditing:(ALTextField *)textField //点击键盘框上的"确认"按钮。
//{
//    NSUInteger tag = textField.tag;
//    
//    NSLog(@"Te %@", textField.text);
//}

//====================
#pragma mark -
-(UIView*) getMainbackgroundView
{
    return self;
}
-(void) setupShowHeightViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getHeightDictionaryValue];
    UIView *heightView = [self  getSelectedViewWithSize:frame.size showProperty:dictValue];
    [heightView setFrame:frame];
    [contentView addSubview:heightView];
}

-(void) setupShowWeightViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getWeightDictionaryValue];
    UIView *showView = [self  getSelectedViewWithSize:frame.size showProperty:dictValue];
    [showView setFrame:frame];
    [contentView addSubview:showView];
}

-(void) setupShowBrasizeViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    
    NSDictionary *dictHeadValue = [self getBrasizeHeadDictionaryValue];
    CGSize headSize = CGSizeMake(frame.size.width, frame.size.height/3);
    UIView *showView = [self  getSelectedViewWithSize:headSize showProperty:dictHeadValue];
    [showView setFrame:CGRectMake(frame.origin.x, frame.origin.y, headSize.width, headSize.height)];
    [contentView addSubview:showView];


    CGSize underBustSize = CGSizeMake(frame.size.width, frame.size.height/3);
    NSDictionary *dictUnderbustValue = [self getUnderbustDictionaryValue];
    UIView *showUnderbustView = [self  getSelectedViewWithSize:underBustSize showProperty:dictUnderbustValue];
    [showUnderbustView setFrame:CGRectMake(frame.origin.x, frame.origin.y+underBustSize.height, underBustSize.width, underBustSize.height)];
    [contentView addSubview:showUnderbustView];

    
    CGSize barSize = CGSizeMake(frame.size.width, frame.size.height/3);
    NSDictionary *dictBarsizeValue = [self getBarsizeDictionaryValue];
    UIView *showBarsizeView = [self  getSelectedViewWithSize:barSize showProperty:dictBarsizeValue];
    [showBarsizeView setFrame:CGRectMake(frame.origin.x, frame.origin.y+underBustSize.height*2, barSize.width, barSize.height)];
    [contentView addSubview:showBarsizeView];
    
}

//Waist
-(void) setupShowWaistViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getWaistHeadDictionaryValue];
    UIView *showView = [self  getButtonListViewWithSize:frame.size showProperty:dictValue];
    [showView setFrame:frame];
    [contentView addSubview:showView];
}

//Buttock
-(void) setupShowButtockViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getButtockHeadDictionaryValue];
    UIView *showView = [self  getButtonListViewWithSize:frame.size showProperty:dictValue];
    [showView setFrame:frame];
    [contentView addSubview:showView];
}

#pragma mark -
//==========================================================================================================================

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
    NSUInteger labelViewWidth = 130;
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
-(UIView*)getSelectedViewWithSize:(CGSize)showSize  showProperty:(NSDictionary*)showProperty
{
    UIView*viewShow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    
    NSString *title = [showProperty objectForKey:AL_KEY_PROPERTY_TITLE];
    NSNumber *titleFontSize = [showProperty objectForKey:AL_KEY_PROPERTY_TITLESIZE];
    UIColor *color = [showProperty objectForKey:AL_KEY_PROPERTY_COLOER];
    NSNumber *startX = [showProperty objectForKey:AL_KEY_PROPERTY_STARTX];
    NSNumber *btnStartX = [showProperty objectForKey:AL_KEY_PROPERTY_BUTTONSTARTX];

    
    NSString *buttonTitle = [showProperty objectForKey:AL_KEY_PROPERTY_BUTTONTITLE];
    NSNumber *tag = [showProperty objectForKey:AL_KEY_PROPERTY_TAG];
    UIColor *btnTitleColor = [showProperty objectForKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    NSString *selectName  = [showProperty objectForKey:AL_KEY_PROPERTY_BUTTONTOGGLE];
    SEL toggleSelect = NSSelectorFromString(selectName);
    
    viewShow.tag = [tag integerValue];
    
    NSUInteger viewHeight = AL_VIEW_DEFAULT_HEIGHT; //每一个界面的高
    NSUInteger labelViewWidth = 130;
    NSUInteger labelViewHeight = 30;

    
    CGFloat cgStartX = 10;
    if (startX) {
        cgStartX = [startX integerValue];
    }
    
    CGSize labelSize = CGSizeMake(labelViewWidth, labelViewHeight);
    ALLabel *label = [self getLabelViewWithSize:showSize titleColor:color fontSize:titleFontSize title:title];
    label.tag = AL_TAG_PRODUCT_LABEL;
    [label setFrame:CGRectMake(cgStartX, (viewHeight- labelViewHeight)/2, labelSize.width, labelSize.height)];
    [viewShow addSubview:label];
    
    if (!selectName) {
        return viewShow;
    }
    
    NSUInteger buttonViewWidth = 157;
    NSUInteger buttonViewHeight = 30;
    CGSize btnSize = CGSizeMake(buttonViewWidth, buttonViewHeight);

    CGFloat cgButStartX = cgStartX+labelViewWidth+10;
    if (btnStartX) {
        cgButStartX = [btnStartX intValue];
    }
    UIButton *btn = [self getButtonViewWithSize:btnSize title:buttonTitle toggleSelect:toggleSelect titleColor:btnTitleColor];
    btn.tag = AL_TAG_PRODUCT_BUTTON;
    [btn setFrame:CGRectMake(cgButStartX, (viewHeight- buttonViewHeight)/2, btnSize.width, btnSize.height)];
    [viewShow addSubview:btn];

    return viewShow;
}


//取得label
-(ALLabel*)getLabelViewWithSize:(CGSize)showSize titleColor:(UIColor*)titleColor fontSize:(NSNumber*)fontSize title:(NSString*)title
{
    ALLabel *labelContent =[[ALLabel alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    [labelContent setTextAlignment:NSTextAlignmentLeft];
    [labelContent setFont:[UIFont boldSystemFontOfSize:[fontSize integerValue]]];
    [labelContent setTextColor:titleColor];
    [labelContent setText:title];
    return labelContent;
}

//取得按钮
-(UIButton*) getButtonViewWithSize:(CGSize)showSize   title:(NSString*)title toggleSelect:(SEL)toggleSelect  titleColor:(UIColor*)titleColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    UIImage *imageInputBack  = [UIImage imageNamed:@"input_box"];
    [btn setBackgroundImage:imageInputBack forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:self action:toggleSelect  forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//取得pickver
-(ALSelectView*)getPickerViewWithSize:(CGSize)showSize
{
    ALSelectView *selView=[[ALSelectView alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    return selView;
}

-(NSDictionary*)getHeightDictionaryValue //身高
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:@"1、你的身高" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(16) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getHeightHadValue] forKey:AL_KEY_PROPERTY_BUTTONTITLE];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_HEIGHT) forKey:AL_KEY_PROPERTY_TAG];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@"toggleButtonHeight:" forKey:AL_KEY_PROPERTY_BUTTONTOGGLE];
    [dictValue setValue:@(AL_DEFAULT_BUTTONT_STARTX) forKey:AL_KEY_PROPERTY_BUTTONSTARTX];
    
    return dictValue;
}

-(NSDictionary*)getWeightDictionaryValue //体重
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:@"2、你的体重" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(16) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getWeightHadValue] forKey:AL_KEY_PROPERTY_BUTTONTITLE];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_WEIGHT) forKey:AL_KEY_PROPERTY_TAG];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@"toggleButtonWeight:" forKey:AL_KEY_PROPERTY_BUTTONTOGGLE];
    [dictValue setValue:@(AL_DEFAULT_BUTTONT_STARTX) forKey:AL_KEY_PROPERTY_BUTTONSTARTX];

    return dictValue;
}

-(NSDictionary*)getBrasizeHeadDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:@"3、你胸衣的尺寸" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(16) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    return dictValue;
}

-(NSDictionary*)getUnderbustDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_CONTENT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:@"下胸围" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(15) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(40) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getUnderbustHadValue] forKey:AL_KEY_PROPERTY_BUTTONTITLE];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_UNDERBUST) forKey:AL_KEY_PROPERTY_TAG];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@"toggleButtonUnderbust:" forKey:AL_KEY_PROPERTY_BUTTONTOGGLE];
    [dictValue setValue:@(AL_DEFAULT_BUTTONT_STARTX) forKey:AL_KEY_PROPERTY_BUTTONSTARTX];

    return dictValue;
}



-(NSDictionary*)getBarsizeDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_CONTENT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:@"罩杯" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(15) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(40) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getBarsizeHadValue] forKey:AL_KEY_PROPERTY_BUTTONTITLE];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_BRASIZE) forKey:AL_KEY_PROPERTY_TAG];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@"toggleButtonBarsize:" forKey:AL_KEY_PROPERTY_BUTTONTOGGLE];
    [dictValue setValue:@(AL_DEFAULT_BUTTONT_STARTX) forKey:AL_KEY_PROPERTY_BUTTONSTARTX];
    
    return dictValue;
}

-(NSDictionary*)getWaistHeadDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@(12) forKey:AL_KEY_PROPERTY_BUTTONFONTSIZE];

    [dictValue setValue:@"4、你的腰部" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(15) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getWaistHadValue] forKey:AL_KEY_PROPERTY_SELEVALUE];
    NSString *stringList = @"较细,一般,较粗";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    [dictValue setValue:arrayList forKey:AL_KEY_PROPERTY_ARRAYLIST];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_WAIST) forKey:AL_KEY_PROPERTY_TAG];
    
    return dictValue;
}

-(NSDictionary*)getButtockHeadDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@(12) forKey:AL_KEY_PROPERTY_BUTTONFONTSIZE];
    
    [dictValue setValue:@"5、你的臀部" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(15) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getWaistHadValue] forKey:AL_KEY_PROPERTY_SELEVALUE];
//    NSString *stringList = @"较细,一般,较粗";

    NSString *stringList = @"窄小的,翘翘的,丰满的";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    [dictValue setValue:arrayList forKey:AL_KEY_PROPERTY_ARRAYLIST];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_BUTTOCK) forKey:AL_KEY_PROPERTY_TAG];
    
    return dictValue;
}



#pragma mark - TOGGLE

-(void) toggleButtonHeight:(id)sender
{
    CGRect frame = CGRectMake(0, (kScreenHeight-100)/2, kScreenWidth, 100);
    ALSelectView *viewPicker  = [self getPickerViewWithSize:frame.size];
    viewPicker.selectType = OcnSelectTypeNormal;
    [viewPicker addTarget:self forVauleChangedaction:@selector(pickerHeightChange:)];
    NSArray *arrayList = [self builderArrayList:130 end:230];
    viewPicker.options = arrayList;
    [self addSubview:viewPicker];
    [viewPicker showPickerView];
}

-(void) toggleButtonWeight:(id)sender //体重
{
    CGRect frame = CGRectMake(0, (kScreenHeight-100)/2, kScreenWidth, 100);
    ALSelectView *viewPicker  = [self getPickerViewWithSize:frame.size];
    viewPicker.selectType = OcnSelectTypeNormal;
    [viewPicker addTarget:self forVauleChangedaction:@selector(pickerWeightChange:)];
    NSArray *arrayList = [self builderArrayList:20 end:200];
    viewPicker.options = arrayList;
    [self addSubview:viewPicker];
    [viewPicker showPickerView];
}

//胸围
-(void) toggleButtonUnderbust:(id)sender
{
    CGRect frame = CGRectMake(0, (kScreenHeight-100)/2, kScreenWidth, 100);
    ALSelectView *viewPicker  = [self getPickerViewWithSize:frame.size];
    viewPicker.selectType = OcnSelectTypeNormal;
    [viewPicker addTarget:self forVauleChangedaction:@selector(pickerUnderbustChange:)];
    NSString *stringList =@"70,75,80,85,90,95,100,105";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    viewPicker.options = arrayList;
    [self addSubview:viewPicker];
    [viewPicker showPickerView];
}


-(void) toggleButtonBarsize:(id)sender
{
    CGRect frame = CGRectMake(0, (kScreenHeight-100)/2, kScreenWidth, 100);
    ALSelectView *viewPicker  = [self getPickerViewWithSize:frame.size];
    viewPicker.selectType = OcnSelectTypeNormal;
    [viewPicker addTarget:self forVauleChangedaction:@selector(pickerBarsizeChange:)];
    NSString *stringList =@"AA,A,B,C,D,E,F";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    viewPicker.options = arrayList;
    [self addSubview:viewPicker];
    [viewPicker showPickerView];
}




-(NSArray*) builderArrayList:(NSUInteger)start end:(NSUInteger)end;
{
    NSUInteger heightStart = start;
    NSUInteger heightEnd = end;
    NSMutableArray *arrayList = [NSMutableArray array];
    for (NSUInteger i = heightStart; i<heightEnd; i++) {
        NSString *stringValue = [NSString stringWithFormat:@"%d", (int)i];
        [arrayList addObject:stringValue];
    }
    return arrayList;
}



//-(void) toggleButtonBraSize:(id)sender
//{
//    CGRect frame = CGRectMake(0, (kScreenHeight-100)/2, kScreenWidth, 100);
//    ALSelectView *viewPicker  = [self getPickerViewWithSize:frame.size];
//    viewPicker.selectType = OcnSelectTypeNormal;
//    [viewPicker addTarget:self forVauleChangedaction:@selector(pickerHeightChange:)];
//    NSArray *arrayList = @[@"70",@"75",@"80",@"85",@"90",@"95",@"100",@"105"];
//    viewPicker.options = arrayList;
//    [self addSubview:viewPicker];
//    [viewPicker showPickerView];
//}

-(NSString*) getHeightHadValue
{
    NSString *value = [[ALExampleManager sharedInstance] readHeightValue];
    if (!value) {
        return @"选择您的身高";
    }
    return [NSString stringWithFormat:@"%@厘米", value];
}

-(NSString*) getWeightHadValue
{
    NSString *value = [[ALExampleManager sharedInstance] readWeightValue];
    if (!value) {
        return @"选择您的体重";
    }
    return [NSString stringWithFormat:@"%@kg", value];
}

-(NSString*) getUnderbustHadValue
{
    NSString *value = [[ALExampleManager sharedInstance] readUnderbustValue];
    if (!value) {
        return @"选择下胸围";
    }
    return [NSString stringWithFormat:@"%@", value];
}

-(id) getWaistHadValue
{
    id value = [[ALExampleManager sharedInstance] readWaistValue];
    return value;
}



-(NSString*) getBarsizeHadValue
{
    NSString *value = [[ALExampleManager sharedInstance] readBarSizeValue];
    if (!value) {
        return @"选择罩杯";
    }
    return [NSString stringWithFormat:@"%@", value];
}


#pragma mark - PICKER

//==picker
-(void) pickerHeightChange:(id)sender
{
    ALSelectView *selectView = sender;
    NSLog(@"%@", selectView.value);
    NSString *value = selectView.value;
    [[ALExampleManager sharedInstance] saveHeightValue:value];
    UIButton *btnHeight = [self getHeightButton];
    [btnHeight setTitle:[self getHeightHadValue] forState:UIControlStateNormal];
//    [self reloadData];
}

-(void) pickerWeightChange:(id)sender
{
    ALSelectView *selectView = sender;
    NSLog(@"%@", selectView.value);
    NSString *value = selectView.value;
    [[ALExampleManager sharedInstance] saveWeightValue:value];
    
    UIButton *btnWeight = [self getWeightButton];
    [btnWeight setTitle:[self getWeightHadValue] forState:UIControlStateNormal];
//    [self reloadData];
}

-(void) pickerUnderbustChange:(id)sender
{
    ALSelectView *selectView = sender;
    NSLog(@"%@", selectView.value);
    NSString *value = selectView.value;
    [[ALExampleManager sharedInstance] saveUnderbustValue:value];
    
    UIButton *btnWeight = [self getUnderBustButton];
    [btnWeight setTitle:[self getUnderbustHadValue] forState:UIControlStateNormal];
}

-(void) pickerBarsizeChange:(id)sender
{
    ALSelectView *selectView = sender;
    NSLog(@"%@", selectView.value);
    NSString *value = selectView.value;
    [[ALExampleManager sharedInstance] saveBarSizeValue:value];
    
    UIButton *btnWeight = [self getBarsizeButton];
    [btnWeight setTitle:[self getBarsizeHadValue] forState:UIControlStateNormal];
}



#pragma mark - GETBUTTON
-(UIButton*)getHeightButton
{
    UIView *bkView = [self getMainbackgroundView];
    UIView *viewShow = [bkView viewWithTag:(AL_TYPE_DATA_HEIGHT+AL_TAG_PRODUCT_START) ];
    UIButton *btn = (UIButton*)[viewShow viewWithTag:AL_TAG_PRODUCT_BUTTON];
    return btn;
}

-(UIButton*)getWeightButton
{
    UIView *bkView = [self getMainbackgroundView];
    UIView *viewShow = [bkView viewWithTag:(AL_TYPE_DATA_WEIGHT+AL_TAG_PRODUCT_START) ];
    UIButton *btn = (UIButton*)[viewShow viewWithTag:AL_TAG_PRODUCT_BUTTON];
    return btn;
}

-(UIButton*)getUnderBustButton
{
    UIView *bkView = [self getMainbackgroundView];
    UIView *viewShow = [bkView viewWithTag:(AL_TYPE_DATA_UNDERBUST+AL_TAG_PRODUCT_START) ];
    UIButton *btn = (UIButton*)[viewShow viewWithTag:AL_TAG_PRODUCT_BUTTON];
    return btn;
}

-(UIButton*)getBarsizeButton
{
    UIView *bkView = [self getMainbackgroundView];
    UIView *viewShow = [bkView viewWithTag:(AL_TYPE_DATA_BRASIZE+AL_TAG_PRODUCT_START) ];
    UIButton *btn = (UIButton*)[viewShow viewWithTag:AL_TAG_PRODUCT_BUTTON];
    return btn;
}



@end
