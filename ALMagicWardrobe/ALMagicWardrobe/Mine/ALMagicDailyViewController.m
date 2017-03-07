//
//  ALMagicDailyViewController.m
//  ALMagicWardrobe
//
//  Created by wang on 4/8/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import "ALMagicDailyViewController.h"
#import "CalendarView.h"
#import "NSDateUtilities.h"
#import "ALUserDetailModel.h"
#import "ALLoginViewController.h"
@interface ALMagicDailyViewController ()<CalendarDelegate>
{
    CalendarView *_sampleView;
    ALUserDetailModel *_theUserDetailInfo;
    ALLabel*_nameLabl;
    ALLabel*_countLabl;
    UIView *spectViewe;
    ALLabel*_dateLabl;
    UIView *spectVieweTwo;
    ALLabel*showConten;
    NSString *_date;
    ALLabel *_workShowLabel;
    NSArray *_listDate;
}
@end

@implementation ALMagicDailyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"魔法日志"];
    
    [self.contentView setBackgroundColor:colorByStr(@"#F0EEEA")];
    
    [self _initData];
    
    [self _initView];
    
    [self _loadDataMagicBagGetDailyRecordAndBlock:^{
        [_sampleView setListDate:_listDate];
        [_sampleView setNeedsDisplay];
        [self reloadLocationView];
    }];
}

#pragma mark 魔法日志
-(void)_loadDataMagicBagGetDailyRecordAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"magicBag_magicDailyRecord"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       _listDate=sucContent[@"body"][@"result"][@"dates"];
                       _countLabl.text = [NSString stringWithFormat:@"%@天你至少变换了%@次新造型!",MBNonEmptyStringNo_(sucContent[@"body"][@"result"][@"days"]),MBNonEmptyStringNo_(sucContent[@"body"][@"result"][@"count"])];
                       if (theBlock) {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   } andShowLoad:YES];
}
#pragma mark 获取当前日期的魔法值记录
-(void)_loadDataMagicBagmagicBag_getDailyRecordAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"date":_date
                            };
    [DataRequest requestApiName:@"magicBag_getDailyRecord"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       if (![sucContent[@"body"][@"result"] count]>0) {
                            _workShowLabel.text =@"当前日期没有日志记录";
                       }else{
                           [_workShowLabel setHeight:14*[sucContent[@"body"][@"result"] count] + 30];
                           NSMutableString *mulStr=[[NSMutableString alloc] initWithCapacity:2];
                           NSArray *arr=sucContent[@"body"][@"result"];
                           [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                               if (idx==0) {
                                   [mulStr appendString:[NSString stringWithFormat:@"%@",obj]];
                               }else{
                               [mulStr appendString:[NSString stringWithFormat:@"\n%@",obj]];
                               }
                           }];
                           _workShowLabel.text = mulStr;
                           [self.contentView setContentSize:CGSizeMake(self.contentView.width, _workShowLabel.bottom+10)];
                       }
                       if (theBlock) {
                           theBlock();
                           
                       }
                   } failedBlock:^(id failContent) {
                     showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}

- (void)_initData {
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    __block ALMagicDailyViewController *selfBlock =self;
    
    if ([[ALLoginUserManager sharedInstance] loginCheck]) {
        [[ALLoginUserManager sharedInstance] getUserInfo:[[ALLoginUserManager sharedInstance] getUserId] andBack:^(ALUserDetailModel *theUserDetailInfo) {
            _theUserDetailInfo = theUserDetailInfo;
            _nameLabl.text = theUserDetailInfo.theUserModel.nickname;
        } andReLoad:NO];
    }
    else{
        [selfBlock goToLoginView];
    }
}
//用户登录
-(void)goToLoginView{
    ALLoginViewController *loginView = [[ALLoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}
-(void)tappedOnDate:(NSDate *)selectedDate
{
    NSString *dateString = [NSString stringWithFormat:@"%ld年%ld月%ld日",(long)selectedDate.year,(long)selectedDate.month,(long)selectedDate.day];
    [_sampleView.titleText setText:dateString];
    _dateLabl.text = dateString;
    _date = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)selectedDate.year,(long)selectedDate.month,(long)selectedDate.day];
    [self _loadDataMagicBagmagicBag_getDailyRecordAndBlock:^{
        
    }];
}
-(void)change
{
    showConten.frame = CGRectMake(10 , _sampleView.bottom,kScreenWidth-50, 30);
    _dateLabl.frame = CGRectMake(10 , showConten.top,kScreenWidth-30, 30);
    spectVieweTwo.frame = CGRectMake(5, _dateLabl.bottom, kScreenWidth-10, .5f);
    _workShowLabel.frame = CGRectMake(10 , spectVieweTwo.bottom + 15,kScreenWidth-30, 14);
}
- (void)_initView {
    
    _nameLabl=[[ALLabel alloc]
             initWithFrame:CGRectMake(10 , 10,kScreenWidth-50, 30)
             andColor:colorByStr(@"#9A7D50")
             andFontNum:15];
    [self.contentView addSubview:_nameLabl];
    
    _countLabl=[[ALLabel alloc]
               initWithFrame:CGRectMake(10 , 40,kScreenWidth-50, 30)
               andColor:colorByStr(@"#62605C")
               andFontNum:14];

    [self.contentView addSubview:_countLabl];
    
    spectViewe= [[UIView alloc]
                         initWithFrame:CGRectMake(5, 71, kScreenWidth-10, .5f)];
    [self.contentView addSubview:spectViewe];
    spectViewe.backgroundColor = AL_RGB(194,179,163);

    _sampleView= [[CalendarView alloc]
                  initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, 330)];
    _sampleView.delegate = self;
    [_sampleView setBackgroundColor:[UIColor clearColor]];
    _sampleView.calendarDate = [NSDate date];
    [self.contentView addSubview:_sampleView];
    
    showConten=[[ALLabel alloc]
                initWithFrame:CGRectMake(10 , _sampleView.bottom,kScreenWidth-50, 30)
                andColor:colorByStr(@"#686662")
                andFontNum:14];
    showConten.text = @"当日记录";
    [self.contentView addSubview:showConten];
    
    _dateLabl=[[ALLabel alloc]
                initWithFrame:CGRectMake(10 , showConten.top,kScreenWidth-30, 30)
                andColor:colorByStr(@"#9C9A96")
                andFontNum:14];
    _dateLabl.textAlignment = NSTextAlignmentRight;
    _dateLabl.text = [_sampleView.calendarDate  dateTimeString];
    [self.contentView addSubview:_dateLabl];
    
    
    spectVieweTwo= [[UIView alloc]
                            initWithFrame:CGRectMake(5, _dateLabl.bottom, kScreenWidth-10, .5f)];
    [self.contentView addSubview:spectVieweTwo];
    spectVieweTwo.backgroundColor = AL_RGB(194,179,163);
    
    
    _workShowLabel=[[ALLabel alloc]
               initWithFrame:CGRectMake(10 , spectVieweTwo.bottom + 15,kScreenWidth-30, 14)
               andColor:colorByStr(@"#686662")
               andFontNum:14];
    [_workShowLabel setNumberOfLines:0];
    _workShowLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_workShowLabel];
}
-(void)reloadLocationView{
    [_nameLabl setFrame:CGRectMake(10 , 10,kScreenWidth-50, _nameLabl.height)];
    [_countLabl setFrame:CGRectMake(10 , _nameLabl.bottom,kScreenWidth-50, _countLabl.height)];
    [spectViewe setFrame:CGRectMake(5, _countLabl.bottom, kScreenWidth-10, 1)];
    [_sampleView setFrame:CGRectMake(0, spectViewe.bottom, self.view.bounds.size.width, _sampleView.height)];
    [showConten setFrame:CGRectMake(10 , _sampleView.bottom,kScreenWidth-50, showConten.height)];
    [_dateLabl setFrame:CGRectMake(10 , showConten.top,kScreenWidth-30, _dateLabl.height)];
    [spectVieweTwo setFrame:CGRectMake(5, _dateLabl.bottom, kScreenWidth-10, 1)];
    [_workShowLabel setFrame:CGRectMake(10 , spectVieweTwo.bottom,kScreenWidth-30, _workShowLabel.height)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
