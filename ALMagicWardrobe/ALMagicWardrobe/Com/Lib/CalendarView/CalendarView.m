
#import "CalendarView.h"
#import "NSDateUtilities.h"

@interface CalendarView()
{
    NSCalendar *gregorian;
    NSInteger _selectedMonth;
    NSInteger _selectedYear;
    
//    UIDatePicker *_datePicker;
    NSMutableArray *_listBtnArr;
}
@end

@implementation CalendarView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(swipeleft:)];
        swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeleft];
        
        UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(swiperight:)];
        swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
        
//        _datePicker=[[UIDatePicker alloc] init];
//        _datePicker.datePickerMode=UIDatePickerModeDate;
//        [_datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
        
        _listBtnArr=[[NSMutableArray alloc] initWithCapacity:2];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    [self setCalendarParameters];
    _weekNames = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    _selectedDate  =components.day;
    components.day = 2;
    NSDate *firstDayOfMonth = [gregorian dateFromComponents:components];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    int weekday = [comps weekday];
    weekday  = weekday - 2;
    
    if(weekday < 0)
        weekday += 7;
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:self.calendarDate];
    
    NSInteger columns = 7;
    NSInteger width = (320-10)/7;
    NSInteger originX = 5;
    NSInteger originY = 25;
    NSInteger monthLength = days.length;
    
    ALComView *dataActionView=[[ALComView alloc]
                               initWithFrame:CGRectMake(0, 5,
                                                        kScreenWidth, 30)];
    [dataActionView setBackgroundColor:[UIColor clearColor]];
    [dataActionView setCustemViewWithType:BottomLine_type andTopLineColor:nil andBottomLineColor:Line_Color];
    [self addSubview:dataActionView];
    
    ALButton *leftBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 30*2, 30)];
    [leftBtn setImage:[ALImage imageNamed:@"leftTou"] forState:UIControlStateNormal];
    [leftBtn setTheBtnClickBlock:^(id sender){
        [self rightChangeDate];

    }];
    [dataActionView addSubview:leftBtn];
    
    ALLabel *titLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(leftBtn.right+10,
                                              0,
                                              dataActionView.width-(leftBtn.right+10)*2,
                                              dataActionView.height)];
    [titLbl setTextAlignment:NSTextAlignmentCenter];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM yyyy"];
    NSString *dateString = [NSString stringWithFormat:@"%ld年%ld月",(long)_calendarDate.year,(long)_calendarDate.month];
    
    [titLbl setText:dateString];
    [titLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
    [titLbl setTextColor:[UIColor brownColor]];
    [dataActionView addSubview:titLbl];
    
    ALButton *rightBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(kScreenWidth-30*2, 0, 30*2, 30)];
    [rightBtn setTheBtnClickBlock:^(id sender){
        [self leftChangeDate];
    }];
    [rightBtn setImage:[ALImage imageNamed:@"rightTou"] forState:UIControlStateNormal];
    [dataActionView addSubview:rightBtn];
    
    /*
    UIImageView *imageView = [[UIImageView alloc]
                              initWithFrame:CGRectMake(70, 5, kScreenWidth-150, 30)];
    imageView.image =[UIImage imageNamed:@"btn_wardrobe"];
    imageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageView];
    
    
    {
        ALButton *imageViewBtn =[ALButton buttonWithType:UIButtonTypeCustom];
        [imageViewBtn setFrame:CGRectMake(kScreenWidth-80, 5, 40, 30)];
//        ALButton *imageViewBtn = [[UIImageView alloc]
//                                  initWithFrame:CGRectMake(kScreenWidth-80, 5, 40, 30)];
        [imageViewBtn setImage:[UIImage imageNamed:@"log_data_right"] forState:UIControlStateNormal];
//        imageViewBtn.image =[UIImage imageNamed:@"log_data_right"];
        imageViewBtn.backgroundColor = [UIColor brownColor];
        [imageViewBtn setTheBtnClickBlock:^(id sender){
            _datePicker.hidden=!_datePicker.hidden;
            [self bringSubviewToFront:_datePicker];
        }];
        [self addSubview:imageViewBtn];
        
        [_datePicker setFrame:CGRectMake(kScreenWidth-200, imageViewBtn.bottom, 200, 200)];
        [self addSubview:_datePicker];
    }
    UILabel*dataLabel = [[UILabel alloc]
                         initWithFrame:CGRectMake(10,0,60, 40)];
    
    [dataLabel setText:@"日期:"];
    [dataLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
    [dataLabel setTextColor:[UIColor brownColor]];
    [self addSubview:dataLabel];
    
    _titleText = [[UILabel alloc]
                  initWithFrame:CGRectMake(0,0, self.bounds.size.width, 40)];
    _titleText.textAlignment = NSTextAlignmentCenter;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM yyyy"];
    NSString *dateString = [NSString stringWithFormat:@"%ld年%ld月%ld日",(long)_calendarDate.year,(long)_calendarDate.month,(long)_calendarDate.day];
    NSLog(@"111====%@",self.calendarDate);
    
    [_titleText setText:dateString];
    [_titleText setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
    [_titleText setTextColor:[UIColor brownColor]];
    [self addSubview:_titleText];
     */
    
    //显示日 到 六
    for (int i =0; i<_weekNames.count; i++) {
        UIButton *weekNameLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        weekNameLabel.titleLabel.text = [_weekNames objectAtIndex:i];
        [weekNameLabel setTitle:[_weekNames objectAtIndex:i] forState:UIControlStateNormal];
        [weekNameLabel setFrame:CGRectMake(originX+(width*(i%columns)), originY, width, width)];
        [weekNameLabel setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [weekNameLabel.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
        weekNameLabel.userInteractionEnabled = NO;
        [self addSubview:weekNameLabel];
    }

    //本月
    for (NSInteger i= 0; i<monthLength; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i+1;
        [button setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 30, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(20,0,0,0)];
        button.titleLabel.text = [NSString stringWithFormat:@"%d",i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        
        [button setTitleColor:AL_RGB(46, 46, 46) forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
        
        [button addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger offsetX = (width*((i+weekday)%columns));
        NSInteger offsetY = (width *((i+weekday)/columns));
        [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
        [button.layer setBorderColor:[[UIColor brownColor] CGColor]];
        [button.layer setBorderWidth:.5];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor brownColor];
        if(((i+weekday)/columns)==0)
        {
            [lineView setFrame:CGRectMake(0, 0, button.frame.size.width, 1)];
            [button addSubview:lineView];
        }

        if(((i+weekday)/columns)==((monthLength+weekday-1)/columns))
        {
            [lineView setFrame:CGRectMake(0, button.frame.size.width-0.5, button.frame.size.width, 0.5)];
            [button addSubview:lineView];
        }
        
        UIView *columnView = [[UIView alloc]init];
        [columnView setBackgroundColor:[UIColor brownColor]];
        if((i+weekday)%7==0)
        {
            [columnView setFrame:CGRectMake(0, 0, 0.5, button.frame.size.width)];
            [button addSubview:columnView];
        }
        else if((i+weekday)%7==6)
        {
            [columnView setFrame:CGRectMake(button.frame.size.width-0.5, 0, 0.5, button.frame.size.width)];
            [button addSubview:columnView];
        }
        if(i+1 ==_selectedDate && components.month == _selectedMonth && components.year == _selectedYear)
        {
            [button setBackgroundColor:[UIColor brownColor]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        if ([self hasBiaoJi:button]) {
            [button setBackgroundImage:[UIImage imageNamed:@"date_sign"] forState:UIControlStateNormal];
        }
        [self addSubview:button];
        [_listBtnArr addObject:button];
    }
    
    NSDateComponents *previousMonthComponents = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    previousMonthComponents.month -=1;
    NSDate *previousMonthDate = [gregorian dateFromComponents:previousMonthComponents];
    NSRange previousMonthDays = [c rangeOfUnit:NSDayCalendarUnit
                   inUnit:NSMonthCalendarUnit
                  forDate:previousMonthDate];
    NSInteger maxDate = previousMonthDays.length - weekday;
    
    for (int i=0; i<weekday; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.text = [NSString stringWithFormat:@"%d",maxDate+i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",maxDate+i+1] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(20,0,0,0)];
        [button setBackgroundColor:[UIColor whiteColor]];
        NSInteger offsetX = (width*(i%columns));
        NSInteger offsetY = (width *(i/columns));
        [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
        [button.layer setBorderWidth:.5];
        [button.layer setBorderColor:[[UIColor brownColor] CGColor]];
        UIView *columnView = [[UIView alloc]init];
        [columnView setBackgroundColor:[UIColor brownColor]];
        if(i==0)
        {
            [columnView setFrame:CGRectMake(0, 0, 0.5, button.frame.size.width)];
            [button addSubview:columnView];
        }

        UIView *lineView = [[UIView alloc]init];
        [lineView setBackgroundColor:[UIColor brownColor]];
        [lineView setFrame:CGRectMake(0, 0, button.frame.size.width, 0.5)];
        [button addSubview:lineView];
        [button setTitleColor:[UIColor colorWithRed:229.0/255.0 green:231.0/255.0 blue:233.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
        [button setEnabled:NO];
        [self addSubview:button];
    }
    
    NSInteger remainingDays = (monthLength + weekday) % columns;
    if(remainingDays >0){
        for (int i=remainingDays; i<columns; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.text = [NSString stringWithFormat:@"%d",(i+1)-remainingDays];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(20,0,0,0)];

            [button setTitle:[NSString stringWithFormat:@"%d",(i+1)-remainingDays] forState:UIControlStateNormal];
            NSInteger offsetX = (width*((i) %columns));
            NSInteger offsetY = (width *((monthLength+weekday)/columns));
            [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
            [button setBackgroundColor:[UIColor whiteColor]];
            [button.layer setBorderWidth:.5];
            [button.layer setBorderColor:[[UIColor brownColor] CGColor]];
            UIView *columnView = [[UIView alloc]init];
            [columnView setBackgroundColor:[UIColor brownColor]];
            if(i==columns - 1)
            {
                [columnView setFrame:CGRectMake(button.frame.size.width-0.5, 0, 0.5, button.frame.size.width)];
                [button addSubview:columnView];
            }
            UIView *lineView = [[UIView alloc]init];
            [lineView setBackgroundColor:[UIColor brownColor]];
            [lineView setFrame:CGRectMake(0, button.frame.size.width-0.5, button.frame.size.width, 0.5)];
            [button addSubview:lineView];
            [button setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
            [button setEnabled:NO];
            [self addSubview:button];
            [self setHeight:button.bottom];
        }
    }
    
}
-(IBAction)tappedDate:(UIButton *)sender
{
    [_listBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *theBtn=obj;
        if (theBtn.tag!=sender.tag) {
            [theBtn setBackgroundColor:[UIColor whiteColor]];
            [theBtn setTitleColor:AL_RGB(46, 46, 46) forState:UIControlStateNormal];
        }
    }];
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    if(!(_selectedDate == sender.tag && _selectedMonth == [components month] && _selectedYear == [components year]))
    {
        if(_selectedDate != -1)
        {
            UIButton *previousSelected =(UIButton *) [self viewWithTag:_selectedDate];
            [previousSelected setBackgroundColor:[UIColor whiteColor]];
            [previousSelected setTitleColor:AL_RGB(46, 46, 46) forState:UIControlStateNormal];
        }
        [sender setBackgroundColor:[UIColor brownColor]];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectedDate = sender.tag;
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        components.day = _selectedDate;
        _selectedMonth = components.month;
        _selectedYear = components.year;
        NSDate *clickedDate = [gregorian dateFromComponents:components];
        [self.delegate tappedOnDate:clickedDate];
    }
}
-(BOOL)hasBiaoJi:(UIButton *)sender{
    __block NSMutableArray *_listDateMul=[[NSMutableArray alloc] initWithCapacity:2];
    [self.listDate enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_listDateMul addObject:[[NSDate dateWithTimeIntervalString:[obj stringValue]] dateString]];
    }];
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    if(!(_selectedDate == sender.tag &&
         _selectedMonth == [components month] &&
         _selectedYear == [components year]))
    {
        
        _selectedDate = sender.tag;
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        components.day = _selectedDate;
        _selectedMonth = components.month;
        _selectedYear = components.year;
        NSDate *clickedDate = [gregorian dateFromComponents:components];
        if ([_listDateMul containsObject:[clickedDate dateString]]) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}
-(void)leftChangeDate{
    showRequest;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.month += 1;
    self.calendarDate = [gregorian dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.1f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { [self setNeedsDisplay]; }
                    completion:^(BOOL finished) {
                         [_delegate change];
                        hideRequest;
                    }];
}
-(void)rightChangeDate{
    showRequest;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.month -= 1;
    self.calendarDate = [gregorian dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.1f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { [self setNeedsDisplay]; }
                    completion:^(BOOL finished) {
                        hideRequest;
                         [_delegate change];
                    }];
}
-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self leftChangeDate];
}
-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self rightChangeDate];
}
-(void)setCalendarParameters
{
    if(gregorian == nil)
    {
        gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        _selectedDate  = components.day;
        _selectedMonth = components.month;
        _selectedYear = components.year;
    }
}

@end
