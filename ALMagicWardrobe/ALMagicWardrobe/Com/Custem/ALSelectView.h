//
//  ALSelectView.h
//  tour Manager
//
//  Created by admin on 14-5-26.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAccessoryView.h"
typedef enum {
    OcnSelectTypeNormal = 1000,
    OcnSelectTypeDate = 1001,
}OcnSelectType;
typedef void (^selEndDateBlock)(id sender);
@interface ALSelectView : UIView<ALAccessoryViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
}

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) OcnSelectType selectType;
@property (nonatomic,retain)UIFont *selectedFont;
@property (nonatomic,copy) NSString *title;
//type normal
@property (nonatomic, retain) NSArray *options;     //select items.
@property (nonatomic, copy) NSString *value;        //result.

//type date
@property (nonatomic, retain) NSDate *dateValue;    //result.
@property (nonatomic, retain) NSDate *minDate;      //enabled min date range.
@property (nonatomic, retain) NSDate *maxDate;      //enabled max date range.

@property (nonatomic) UIDatePickerMode datePickerMode;

@property (nonatomic, assign) BOOL isScrollUp;

-(void)setTitleEdgeInsets:(UIEdgeInsets)insets;     //设置偏移量
-(void)setAlignment:(UIControlContentHorizontalAlignment)alignment; //设置对齐方式

- (void)setSelectedDate:(NSDate *)selectedDate;     //set default display date.
/**
 *  设置title的对齐方式 0：left,1 :center 2:right
 *
 *  @param alignmentType
 */
- (void)setTItleAlignment:(int)alignmentType;

- (void)addTarget:(id)target forVauleChangedaction:(SEL)action;

- (void)showPickerView;

- (id)initWithFrame:(CGRect)frame font:(UIFont*)font;
-(void)changeFont:(UIFont *)font;


-(id)initWithFrame:(CGRect)frame img:(UIImage *)img;            //设置图片

@property (nonatomic,copy) selEndDateBlock endDateBack;

/**
 *  设置标题颜色
 *
 *  @param color 标题颜色
 */
- (void)titleColor:(UIColor *)color;
@end

