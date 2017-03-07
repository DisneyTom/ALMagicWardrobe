//
//  ALThreeProductView.m
//  ALMagicWardrobe
//
//  Created by frank on 15/3/18.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALThreeProductView.h"
#import "ALExamingHeader.h"
#import "ALButtonViews.h"
#import "ALExampleManager.h"


@interface ALThreeProductView ()<ALButtonViewsDelegate>

@end


@implementation ALThreeProductView

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
    CGRect  frame = CGRectMake(0, startY, kScreenWidth, AL_VIEW_DEFAULT_IMAGE_HEIGHT+80);
    [self setupShowBodytypeViewWithFrame:frame];//Bodytype

    startY += (AL_VIEW_DEFAULT_IMAGE_HEIGHT+55);
    frame = CGRectMake(0, startY, kScreenWidth, 200);
    [self setupShowCompleteViewWithFrame:frame];
   
}

#pragma mark -
//Bodytype
-(void) setupShowBodytypeViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
    NSDictionary *dictValue = [self getBodytypeHeadDictionaryValue];
    UIView *showView = [self  getButtonImageListViewWithSize:frame.size showProperty:dictValue];
    [showView setFrame:frame];
    [contentView addSubview:showView];
}

//Complete
-(void) setupShowCompleteViewWithFrame:(CGRect)frame
{
    UIView *contentView = [self getMainbackgroundView];
  
    CGFloat startX = 10;
    CGFloat startY = frame.origin.y;
    CGSize showSize = CGSizeMake(frame.size.width, 100);
    NSString *title = @"13、完整准确地填写以下数据，我们将为你精选更加合身的服装哦，一起量起来吧！拨轮选择，可跳过，不影响测试进程";
    UIColor *titleColor = AL_COLOR_SUBJECT;
    ALLabel *labelContent =[[ALLabel alloc] initWithFrame:CGRectMake(startX, startY, showSize.width-startX*2, 120)];
    [labelContent setTextAlignment:NSTextAlignmentLeft];
    labelContent.lineBreakMode = NSLineBreakByWordWrapping;
    labelContent.numberOfLines = 4;
    labelContent.textAlignment = NSTextAlignmentCenter;
    [labelContent setFont:[UIFont boldSystemFontOfSize:15]];
    [labelContent setTextColor:titleColor];
    [labelContent setText:title];
//    [labelContent sizeToFit];
    
    
    startY += 90;
    CGRect frame1 = CGRectMake(0, startY, showSize.width, 50);
    NSDictionary *dictValue1 = [self getShowInfoDictionaryValueWithType:AL_TYPE_DATA_BUSTVALUE];
    UIView *heightView1 = [self  getSelectedViewWithSize:frame1.size showProperty:dictValue1];
    [heightView1 setFrame:frame1];
    
    startY += 45;
    CGRect frame2 = CGRectMake(0, startY, showSize.width, 50);
    NSDictionary *dictValue2 = [self getShowInfoDictionaryValueWithType:AL_TYPE_DATA_WAISTLINEVALUE];
    UIView *heightView2 = [self  getSelectedViewWithSize:frame2.size showProperty:dictValue2];
    [heightView2 setFrame:frame2];

    startY += 45;
    CGRect frame3 = CGRectMake(0, startY, showSize.width, 50);
    NSDictionary *dictValue3 =  [self getShowInfoDictionaryValueWithType:AL_TYPE_DATA_HIPSVALUE];
    UIView *heightView3 = [self  getSelectedViewWithSize:frame3.size showProperty:dictValue3];
    [heightView3 setFrame:frame3];

    startY += 45;
    CGRect frame4 = CGRectMake(0, startY, showSize.width, 50);
    NSDictionary *dictValue4 =  [self getShowInfoDictionaryValueWithType:AL_TYPE_DATA_SHOULDERVALUE];
    UIView *heightView4 = [self  getSelectedViewWithSize:frame4.size showProperty:dictValue4];
    [heightView4 setFrame:frame4];

    
    [contentView addSubview:labelContent];
    [contentView addSubview:heightView1];
    [contentView addSubview:heightView2];
    [contentView addSubview:heightView3];
    [contentView addSubview:heightView4];
    
}

#pragma mark - GETVALUE
//Bodytype
-(NSDictionary*)getBodytypeHeadDictionaryValue
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@(AL_DEFAULT_BUTTONFONTSIZE) forKey:AL_KEY_PROPERTY_BUTTONFONTSIZE];
    
    [dictValue setValue:@"12、你的体型是（图示）" forKey:AL_KEY_PROPERTY_TITLE];
    [dictValue setValue:@(AL_DEFAULT_TITLEFONTSIZE) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(AL_DEFAULT_TITLE_STARTX) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:[self getHadValueWithType:AL_TYPE_DATA_BODYTYPE] forKey:AL_KEY_PROPERTY_SELEVALUE];
    NSString *stringList = @"figure_x,figure_a,figure_h,figure_y,figure_o";
    NSArray *arrayList = [stringList componentsSeparatedByString:@","];
    [dictValue setValue:arrayList forKey:AL_KEY_PROPERTY_ARRAYLIST];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+AL_TYPE_DATA_BODYTYPE) forKey:AL_KEY_PROPERTY_TAG];
    return dictValue;
}

#pragma mark - GETVIEW
-(UIView*) getMainbackgroundView
{
    return self;
}

-(UIView*)getButtonImageListViewWithSize:(CGSize)showSize  showProperty:(NSDictionary*)showProperty
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
    UIView *viewButtons = [self getImageViewWithArray:arrayList titleColor:btnTitleColor value:selectedValue showSize:buttonSize tag:tag fontSize:[btnFontSize floatValue]];
//    viewShow.backgroundColor = [UIColor yellowColor];
    [viewButtons setFrame:CGRectMake(0, labelViewHeight+15, buttonSize.width, buttonSize.height)];
    
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

-(UIView*) getImageViewWithArray:(NSArray*)arrayList titleColor:(UIColor*)titleColor value:(id)value showSize:(CGSize)showSize tag:(id)tag  fontSize:(CGFloat)fontSize;
{
    ALButtonViews *view = [[ALButtonViews alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    view.alArrayList = arrayList;
    view.delegate = self;
    view.alDataValue = tag;
    view.alSelected = value;
    [view refreshShowImagaViews:showSize];
    return view;
}

#pragma mark -
-(id) getHadValueWithType:(AL_TYPE_DATA)dataType
{
    id value = [[ALExampleManager sharedInstance] readValueWithType:dataType];
    switch (dataType) {
        case AL_TYPE_DATA_BUSTVALUE:
        {
            NSString *result = @"请选择胸围";
            if (value) {
                result = [NSString stringWithFormat:@"%@厘米", value];
            }
            return result;
            
        }
            break;
        case AL_TYPE_DATA_WAISTLINEVALUE:
        {
            NSString *result = @"请选择腰围";
            if (value) {
                result = [NSString stringWithFormat:@"%@厘米", value];
            }
            return result;
        }
            break;
        case AL_TYPE_DATA_HIPSVALUE:
        {
            NSString *result = @"请选择臀围";
            if (value) {
                result = [NSString stringWithFormat:@"%@厘米", value];
            }
            return result;
        }
            break;
            
        case AL_TYPE_DATA_SHOULDERVALUE:
        {
            NSString *result = @"请选择肩宽";
            if (value) {
                result = [NSString stringWithFormat:@"%@厘米", value];
            }
            return result;
        }
            break;
            
        default:
            break;
    }
    return value;
}

#pragma mark -
-(void) ALButtonViewsHandle:(id)data thread:(id)thread value:(id)value;
{
    NSLog(@" %@,%@", data, value);
    NSUInteger tag  = [data integerValue];
    
    if (tag == AL_TAG_PRODUCT_START+AL_TYPE_DATA_BODYTYPE) {
        [[ALExampleManager sharedInstance] saveValueWithType:AL_TYPE_DATA_BODYTYPE value:value];
    }
}

#pragma mark - 
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

#pragma mark - 

-(NSDictionary*)getShowInfoDictionaryValueWithType:(AL_TYPE_DATA)dataType
{
    NSMutableDictionary *dictValue = [NSMutableDictionary dictionary];
    [dictValue setValue:AL_COLOR_SUBJECT forKey:AL_KEY_PROPERTY_COLOER];
    [dictValue setValue:@(16) forKey:AL_KEY_PROPERTY_TITLESIZE];
    [dictValue setValue:@(40) forKey:AL_KEY_PROPERTY_STARTX];
    [dictValue setValue:@(AL_TAG_PRODUCT_START+dataType) forKey:AL_KEY_PROPERTY_TAG];
    [dictValue setValue:AL_COLOR_BUTTONTITLE forKey:AL_KEY_PROPERTY_BUTTONTITLECOLOER];
    [dictValue setValue:@(AL_DEFAULT_BUTTONT_STARTX) forKey:AL_KEY_PROPERTY_BUTTONSTARTX];
    [dictValue setValue: [self getHadValueWithType:dataType] forKey:AL_KEY_PROPERTY_BUTTONTITLE];

    switch (dataType) {
        case AL_TYPE_DATA_BUSTVALUE:
        {
            [dictValue setValue:@"胸围" forKey:AL_KEY_PROPERTY_TITLE];
            [dictValue setValue:@"toggleButtonPicker1:" forKey:AL_KEY_PROPERTY_BUTTONTOGGLE];
        }
            break;
        case AL_TYPE_DATA_WAISTLINEVALUE:
        {
            [dictValue setValue:@"腰围" forKey:AL_KEY_PROPERTY_TITLE];
            [dictValue setValue:@"toggleButtonPicker2:" forKey:AL_KEY_PROPERTY_BUTTONTOGGLE];
        }
            break;
        case AL_TYPE_DATA_HIPSVALUE:
        {
            [dictValue setValue:@"臀围" forKey:AL_KEY_PROPERTY_TITLE];
            [dictValue setValue:@"toggleButtonPicker3:" forKey:AL_KEY_PROPERTY_BUTTONTOGGLE];
            
        }
            break;

        case AL_TYPE_DATA_SHOULDERVALUE:
        {
            [dictValue setValue:@"肩宽" forKey:AL_KEY_PROPERTY_TITLE];
            [dictValue setValue:@"toggleButtonPicker4:" forKey:AL_KEY_PROPERTY_BUTTONTOGGLE];

        }
            break;
            
        default:
            break;
    }

    
    return dictValue;
}

-(void) toggleButtonPicker1:(id)sender
{
    CGRect frame = CGRectMake(0, (kScreenHeight-100)/2, kScreenWidth, 100);
    ALSelectView *viewPicker  = [self getPickerViewWithSize:frame.size];
    viewPicker.selectType = OcnSelectTypeNormal;
    [viewPicker addTarget:self forVauleChangedaction:@selector(pickerValueChange1:)];
    NSArray *arrayList = [self builderArrayList:70 end:105];
    viewPicker.options = arrayList;
    [self addSubview:viewPicker];
    [viewPicker showPickerView];
}

-(void) toggleButtonPicker2:(id)sender
{
    CGRect frame = CGRectMake(0, (kScreenHeight-100)/2, kScreenWidth, 100);
    ALSelectView *viewPicker  = [self getPickerViewWithSize:frame.size];
    viewPicker.selectType = OcnSelectTypeNormal;
    [viewPicker addTarget:self forVauleChangedaction:@selector(pickerValueChange2:)];
    NSArray *arrayList = [self builderArrayList:50 end:85];
    viewPicker.options = arrayList;
    [self addSubview:viewPicker];
    [viewPicker showPickerView];
}

-(void) toggleButtonPicker3:(id)sender
{
    CGRect frame = CGRectMake(0, (kScreenHeight-100)/2, kScreenWidth, 100);
    ALSelectView *viewPicker  = [self getPickerViewWithSize:frame.size];
    viewPicker.selectType = OcnSelectTypeNormal;
    [viewPicker addTarget:self forVauleChangedaction:@selector(pickerValueChange3:)];
    NSArray *arrayList = [self builderArrayList:70 end:105];
    viewPicker.options = arrayList;
    [self addSubview:viewPicker];
    [viewPicker showPickerView];
}

-(void) toggleButtonPicker4:(id)sender
{
    CGRect frame = CGRectMake(0, (kScreenHeight-100)/2, kScreenWidth, 100);
    ALSelectView *viewPicker  = [self getPickerViewWithSize:frame.size];
    viewPicker.selectType = OcnSelectTypeNormal;
    [viewPicker addTarget:self forVauleChangedaction:@selector(pickerValueChange4:)];
    NSArray *arrayList = [self builderArrayList:25 end:60];
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

-(void) pickerValueChange1:(id)sender
{
    ALSelectView *selectView = sender;
    NSLog(@"%@", selectView.value);
    NSString *value = selectView.value;
    [[ALExampleManager sharedInstance] saveValueWithType:AL_TYPE_DATA_BUSTVALUE value:value];
    
    UIButton *btnHeight = [self getButtonWithType:AL_TYPE_DATA_BUSTVALUE];
    [btnHeight setTitle:[self getHadValueWithType:AL_TYPE_DATA_BUSTVALUE] forState:UIControlStateNormal];

}
-(void) pickerValueChange2:(id)sender
{
    ALSelectView *selectView = sender;
    NSLog(@"%@", selectView.value);
    NSString *value = selectView.value;
    [[ALExampleManager sharedInstance] saveValueWithType:AL_TYPE_DATA_WAISTLINEVALUE value:value];
    
    UIButton *btnHeight = [self getButtonWithType:AL_TYPE_DATA_WAISTLINEVALUE];
    [btnHeight setTitle:[self getHadValueWithType:AL_TYPE_DATA_WAISTLINEVALUE] forState:UIControlStateNormal];

}
-(void) pickerValueChange3:(id)sender
{
    ALSelectView *selectView = sender;
    NSLog(@"%@", selectView.value);
    NSString *value = selectView.value;
    [[ALExampleManager sharedInstance] saveValueWithType:AL_TYPE_DATA_HIPSVALUE value:value];
    
    UIButton *btnHeight = [self getButtonWithType:AL_TYPE_DATA_HIPSVALUE];
    [btnHeight setTitle:[self getHadValueWithType:AL_TYPE_DATA_HIPSVALUE] forState:UIControlStateNormal];

}
-(void) pickerValueChange4:(id)sender
{
    ALSelectView *selectView = sender;
    NSLog(@"%@", selectView.value);
    NSString *value = selectView.value;
    [[ALExampleManager sharedInstance] saveValueWithType:AL_TYPE_DATA_SHOULDERVALUE value:value];
    
    UIButton *btnHeight = [self getButtonWithType:AL_TYPE_DATA_SHOULDERVALUE];
    [btnHeight setTitle:[self getHadValueWithType:AL_TYPE_DATA_SHOULDERVALUE] forState:UIControlStateNormal];

}


-(UIButton*)getButtonWithType:(AL_TYPE_DATA)type
{
    UIView *bkView = [self getMainbackgroundView];
    UIView *viewShow = [bkView viewWithTag:(type+AL_TAG_PRODUCT_START) ];
    UIButton *btn = (UIButton*)[viewShow viewWithTag:AL_TAG_PRODUCT_BUTTON];
    return btn;
}
@end
