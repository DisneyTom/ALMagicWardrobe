//
//  ALSelectView.m
//  tour Manager
//
//  Created by admin on 14-5-26.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "ALSelectView.h"
#import "ALAccessoryView.h"

@interface ALSelectView ()
{
@private
    UIButton *      _button;
    UIView *        _selectView;
    BOOL            _isVisible;
    NSString *      _tempSelectedValue;
    id       _target;
    SEL             _selector;
    NSDate *        _selectedDate;
    
    BOOL _isScrollUp;

}

@end

@implementation ALSelectView


@synthesize isScrollUp = _isScrollUp;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf:[UIFont systemFontOfSize:15]];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame font:(UIFont *)font{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf:font];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame img:(UIImage *)img{
    if (self = [super initWithFrame:frame]) {
        _isVisible = NO;
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.exclusiveTouch = YES;
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 20)];
        [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        _button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [_button setBackgroundImage:img forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(selectButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:15]];
//        _button setTitleColor:[] forState:<#(UIControlState)#>
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(pickerViewWillShow:)
                                                     name:TSelectViewWillShowNotification
                                                   object:nil];
    }
    return self;
}

- (void)setSelectedFont:(UIFont *)selectedFont
{
    _selectedFont = selectedFont;
    _button.titleLabel.font = selectedFont;
}
/**
 *  设置title的对齐方式 0：left,1 :center 2:right
 *
 *  @param alignmentType
 */
- (void)setTItleAlignment:(int)alignmentType
{
    if (alignmentType == 0)
    {
        [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    else if  (alignmentType == 1)
    {
        [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    }
    else
    {
        [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
        
}

- (void)initSelf:(UIFont*)font{
    //默认是滚动的
    _isScrollUp = YES;
    _isVisible = NO;
    _selectedFont = font;
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.exclusiveTouch = YES;
    _button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.titleLabel.font = font;
    //    [_button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 20)];
    [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_button addTarget:self action:@selector(selectButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pickerViewWillShow:)
                                                 name:TSelectViewWillShowNotification
                                               object:nil];
    
    
}

//- (void)setTxtAlgignment:(NSTextAlignment)
//{
//    _button
//    
//}


-(void)setTitleEdgeInsets:(UIEdgeInsets)insets{
    [_button setTitleEdgeInsets:insets];
}

-(void)setAlignment:(UIControlContentHorizontalAlignment)alignment{
    [_button setContentHorizontalAlignment:alignment];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (_selectView) {
        [_selectView removeFromSuperview];
        //        MB_RELEASE_SAFELY(_selectView);
    }
    //    MB_RELEASE_SAFELY(_options);
}

BOOL ALSelIsStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL ALSelIsArrayWithItems(id object) {
    return [object isKindOfClass:[NSArray class]] && [(NSArray*)object count] > 0;
}
- (void)reloadData{
    if (_selectType == OcnSelectTypeNormal) {
        if (!ALSelIsStringWithAnyText(_value) && ALSelIsArrayWithItems(_options)) {
//            _value = [_options[0] copy];
        }
    } else {
        NSDate *defaultDate = nil;
        if (_selectedDate) {
            defaultDate = _selectedDate;
        } else {
            defaultDate = [NSDate date];
        }
        _dateValue = defaultDate;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        formatter.dateFormat = kDateFormat;
        if (!ALSelIsStringWithAnyText(_value)) {
            _value = [[formatter stringFromDate:defaultDate] copy];
        }
    }
    
    _tempSelectedValue = _value;
        [_button setTitle:_value forState:UIControlStateNormal];
}

- (void)setOptions:(NSArray *)options{
    _options = options;
    
    [self reloadData];
}

- (void)setValue:(NSString *)value{
    _value = [value copy];
    
    [self reloadData];
}

- (void)setSelectedDate:(NSDate *)selectedDate{
    _selectedDate = selectedDate;
    
    [self reloadData];
}

- (void)setSelectType:(OcnSelectType)selectType{
    _selectType = selectType;
    
    [self reloadData];
}

- (void)selectButtonPressed{
    if (_value.length == 0)
    {
        return;
    }
    [self showPickerView];
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}
-(void)changeFont:(UIFont *)font{
    _button.titleLabel.font=font;
}
/**
 *  设置标题颜色
 *
 *  @param color 标题颜色
 */
- (void)titleColor:(UIColor *)color
{
    [_button setTitleColor:color forState:UIControlStateNormal];
}

- (void)showPickerView{
    if (!_isVisible) {
        
        [self becomeFirstResponder];
        if (_isScrollUp == YES)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:TSelectViewWillShowNotification object:self];
        }

        _isVisible = YES;
        
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kToolBarHeight + kPickerViewHeight)];
        ALAccessoryView *accessoryView = [[ALAccessoryView alloc] initWithDelegate:self];
        _selectView.backgroundColor = [UIColor whiteColor];
        [_selectView addSubview:accessoryView];
        if (_selectType == OcnSelectTypeNormal) {
            UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kToolBarHeight, kScreenWidth, kPickerViewHeight)];
            picker.delegate = self;
            picker.dataSource = self;
            [picker setShowsSelectionIndicator:YES];
            
            if ([[[_options objectAtIndex:0] class]isSubclassOfClass:[NSDictionary class]])
            {
                [_options enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj[@"name"]isEqualToString:_value])
                    {
                        [picker selectRow:idx inComponent:0 animated:NO];
                        _tempSelectedValue = _value;
                        *stop = true;
                    }
                }];
            }
            else
            {
                if ([_options containsObject:_value]) {
                    [picker selectRow:[_options indexOfObject:_value] inComponent:0 animated:NO];
                } else {
                if ([[_options[0] class]isSubclassOfClass:[NSDictionary class]])
                {
                    _tempSelectedValue = _options[0][@"name"];
                }
                else
                {
                    _tempSelectedValue = [_options[0] copy];
                }
            }
            }
            [_selectView addSubview:picker];
        } else if (_selectType == OcnSelectTypeDate) {
            UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kToolBarHeight, kScreenWidth, kPickerViewHeight)];
            [picker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
            if (self.datePickerMode) {
                picker.datePickerMode = self.datePickerMode;
            }
            else{
                picker.datePickerMode = UIDatePickerModeDate;
            }
            //            if (_selectedDate) {
                         [picker setDate:[NSDate date] animated:NO];
            //            }
            if (_value) {
                _dateValue = picker.date;
                //修改by  ltl
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                formatter.dateFormat = kDateFormat;
                _tempSelectedValue = [[formatter stringFromDate:_dateValue] copy];
            }
            
            picker.minimumDate = _minDate;
            picker.maximumDate = _maxDate;
            [_selectView addSubview:picker];
        }        
        [self.window addSubview:_selectView];
        
        [UIView animateWithDuration:0.26 animations:^{
            _selectView.transform = CGAffineTransformMakeTranslation(0, -(kToolBarHeight + kPickerViewHeight));
        } completion:^(BOOL finished) {

            [[NSNotificationCenter defaultCenter] postNotificationName:MBSelectViewDidShowNotification object:self];
            

            finished = YES;
        }];
    }
}

- (BOOL)resignFirstResponder{
    if ([self isFirstResponder]) {
        
        
        if (_isScrollUp)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:TSelectViewWillHideNotification object:self];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            _selectView.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MBSelectViewDidHideNotification object:self];
            [_selectView removeFromSuperview];
            _isVisible = NO;
            finished = YES;
        }];
        
        
    }
    return [super resignFirstResponder];
}

- (void)hidePickerView{
    if (_isVisible) {
        [self resignFirstResponder];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification{
    [self hidePickerView];
}

- (void)pickerViewWillShow:(NSNotification *)notification{
    [self hidePickerView];
}

- (void)addTarget:(id)target forVauleChangedaction:(SEL)action{
    _target = target;
    _selector = action;
}

- (void)setEnabled:(BOOL)enabled{
    _button.userInteractionEnabled = enabled;
    if (enabled) {
        [_button setBackgroundImage:[[UIImage imageNamed:@"province_city_bg.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:0] forState:UIControlStateNormal];
    } else {
        [_button setBackgroundImage:[[UIImage imageNamed:@"select_pressed.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:0] forState:UIControlStateNormal];
    }
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled{
    _button.userInteractionEnabled = userInteractionEnabled;
    if (userInteractionEnabled) {
        [_button setBackgroundImage:[[UIImage imageNamed:@"province_city_bg.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:0] forState:UIControlStateNormal];
    } else {
        [_button setBackgroundImage:[[UIImage imageNamed:@"select_pressed.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:0] forState:UIControlStateNormal];
    }
}

#pragma mark UIMonthYearPickerDelegate
- (void)pickerView:(UIPickerView *)pickerView didChangeDate:(NSDate*)newDate{
    _dateValue = newDate;
}


#pragma mark MBAccessoryViewDelegate
- (void)accessoryViewDidPressedCancelButton:(ALAccessoryView *)view{
    if (_selectType == OcnSelectTypeDate ||_selectType == OcnSelectTypeNormal) {
        //值还原
        _tempSelectedValue = _value;
        
        _selectedDate = _dateValue;
    }
    [self hidePickerView];
}

- (void)accessoryViewDidPressedDoneButton:(ALAccessoryView *)view{
    if (_selectType == OcnSelectTypeDate ||_selectType == OcnSelectTypeNormal) {
        //值确认
        _value = [_tempSelectedValue copy];
        
        _dateValue = _selectedDate;
        
        [_button setTitle:_value forState:UIControlStateNormal];
        _button.titleLabel.font = _selectedFont;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (_endDateBack) {
        _endDateBack(self);
    }
       [_target performSelector:_selector withObject:self];
    
#pragma clang diagnostic pop
    
    [self hidePickerView];
}


- (void)datePickerValueChanged:(UIDatePicker *)picker{
    _selectedDate = picker.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = kDateFormat;
    _tempSelectedValue = [[formatter stringFromDate:picker.date] copy];
}


#pragma mark UIPickerViewDelegate & UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
 
    return [_options count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([[[_options objectAtIndex:row] class]isSubclassOfClass:[NSDictionary class]])
    {
        return _options[row][@"name"];
    }

    return [_options objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([[[_options objectAtIndex:row] class]isSubclassOfClass:[NSDictionary class]])
    {
        _tempSelectedValue =  _options[row][@"name"];
    }
    else
    {
        _tempSelectedValue = [_options objectAtIndex:row];
    }
}


@end
