//
//  ALSystemMessageViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALSystemMessageViewController.h"
#import "ALSystemMessageDetailViewController.h"
#import "ALSysMessageModel.h"
#import "NSDateUtilities.h"
#import "ALMagicValViewController.h"
#import "ALGetCodeViewController.h"
#import "ALPeriodicalsViewController.h"
#import "ALMagicBagBuyViewController.h"
#import "ALLastNewViewController.h"
#import "ALMagicBagViewController.h"
#import "ALTabBarViewController.h"

@interface ALSystemMessageViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    ALTableView *_sysTableView;
    int _pageNo;
}

@end

@implementation ALSystemMessageViewController{
    NSMutableArray *_sysmessageArr;
    NSMutableArray *_sysmessageArrGood;
    NSMutableArray *_lineHeightArr;
    NSMutableArray* array_Height;
}
-(void)_initData{
    _sysmessageArr=[[NSMutableArray alloc] initWithCapacity:2];
    _sysmessageArrGood=[[NSMutableArray alloc] initWithCapacity:2];
     array_Height = [[NSMutableArray alloc]init];
    _lineHeightArr=[[NSMutableArray alloc] initWithCapacity:2];
    [_sysmessageArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_lineHeightArr addObject:[NSNumber numberWithFloat:55.0f]];


    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"messageStatu"];
    if ([self.navigationController.viewControllers count]==1)
    {
         [_backBtn setHidden:NO];
         __block ALSystemMessageViewController * theCtrl=self;
        [_backBtn setTheBtnClickBlock:^(id sender){
            CATransition *transition = [CATransition animation];
            transition.duration = 0.5;
            transition.type = kCATransitionMoveIn;
            transition.subtype = kCATransitionFromLeft;
            [theCtrl.navigationController.view.layer addAnimation:transition forKey:nil];
            [theCtrl.navigationController pushViewController:[[ALTabBarViewController alloc]init] animated:true];
        }];
        [self.contentView setHeight:kScreenHeight-kNavigationBarHeight];
    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
    {
        _sysTableView.layoutMargins = UIEdgeInsetsZero;
    }
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
    {
        _sysTableView.separatorInset = UIEdgeInsetsZero;
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"系统消息"];
    _pageNo = 1;
    [self _initData];
    _sysTableView=[[ALTableView alloc]init];
   _sysTableView.frame =CGRectMake(0,0,kScreenWidth,kContentViewHeight+69);
    _sysTableView.tableFooterView = [[UIView alloc]init];
    [_sysTableView setDataSource:self];
    [_sysTableView setDelegate:self];
    [_sysTableView setBackgroundColor:RGB_BG_Clear];
   // [_sysTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.contentView addSubview:_sysTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
    [self _loadSysMessageAndBlock:^{
        [_sysmessageArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      //      [_lineHeightArr addObject:[NSNumber numberWithFloat:60.0f]];
            NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
            dict[@"height"] = @"0";
            dict[@"row"] = [NSString stringWithFormat:@"%ld",(long)idx];
            [array_Height addObject:dict];
        }];
        [_sysTableView reloadData];
    }];
    __block ALSystemMessageViewController *blockSelf  = self;
    [_sysTableView addFooterWithCallback:^{
        [blockSelf loadMoreView];
    }];
    
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    if ([self.navigationController.viewControllers count]==1)
//    {
//        [self.contentView setHeight:kScreenHeight-kNavigationBarHeight];
//        //        [self makeTabBarHidden:YES];
//    }
}

-(void)loadMoreView{
    
    _pageNo+=1;
    [self _loadSysMessageAndBlock:^{
        
        [_sysTableView footerEndRefreshing];
        [_sysmessageArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
            dict[@"height"] = @"0";
            dict[@"row"] = [NSString stringWithFormat:@"%ld", (long)array_Height.count];
            [array_Height addObject:dict];
          //  [_lineHeightArr addObject:[NSNumber numberWithFloat:55.0f]];
        }];
        [_sysTableView reloadData];
        
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sysmessageArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify=@"cellIdentify";
    UITableViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (theCell==nil    ) {
        theCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentify];
        theCell.backgroundColor =  HEX(@"#efebe8");
        ALLabel *mesLbl=[[ALLabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 50, 30) andColor:colorByStr(@"#666460") andFontNum:15];
        [mesLbl setTag:100];
        [mesLbl setFont:[UIFont boldSystemFontOfSize:12.0f]];
        mesLbl.numberOfLines = 0;
        [theCell addSubview:mesLbl];
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        mesLbl=[[ALLabel alloc] initWithFrame:CGRectMake(kScreenWidth-85, 35, 80, 20) andColor:colorByStr(@"#999793") andFontNum:11];
        [mesLbl setTag:101];
        [mesLbl setFont:[UIFont systemFontOfSize:10.0f]];
        mesLbl.adjustsFontSizeToFitWidth = YES;
        [theCell addSubview:mesLbl];
        ALImageView *leftImgView = [[ALImageView alloc]initWithFrame:(CGRect){kScreenWidth-26,16,24,24}];
        [leftImgView setImage:[UIImage imageNamed:@"icon_next.png"]];
        [theCell addSubview:leftImgView];
    }
    ALLabel *theLbl=(ALLabel *)[theCell viewWithTag:100];
    ALLabel *timetheLbl=(ALLabel *)[theCell viewWithTag:101];
    ALSysMessageModel *theModel=_sysmessageArr[indexPath.row];
    [theLbl setText:theModel.message];
    [theLbl sizeToFit];
    NSMutableDictionary* dict = array_Height[indexPath.row];
    if ([dict[@"row"]intValue]==indexPath.row)
    {
        if (theLbl.height > 30)
        {
            dict[@"height"] = [NSString stringWithFormat:@"%f",theLbl.height + 30];
            timetheLbl.frame = CGRectMake(kScreenWidth-85, theLbl.bottom - 5, 80, 20);
        }
        else
        {
            theLbl.frame = CGRectMake(10, (60- 30)/3, kScreenWidth - 50, 30);
        }
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalString:theModel.createdate];
    NSString *dataStr=[[confromTimesp dateString2] substringFromIndex:2];
    timetheLbl.text = dataStr;
    return theCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    float tmp = [_lineHeightArr[indexPath.row] floatValue];
    NSMutableDictionary* dict = array_Height[indexPath.row];
    float h =  [dict[@"height"]floatValue];
    if (h < 30)
    {
        h = 60;
    }
  
    return h;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ALSysMessageModel * sysModel = _sysmessageArr[indexPath.row];
    NSLog(@"%@",sysModel.opentype);
    NSLog(@"%@",_sysmessageArrGood[indexPath.row]);
    
    //1
    if ([sysModel.opentype isEqualToString:@"魔法值"]) {
        ALMagicValViewController *sysTemDetail = [[ALMagicValViewController alloc]init];
        sysTemDetail.messageDataInfoModel = _sysmessageArr[indexPath.row];
        [self.navigationController pushViewController:sysTemDetail animated:YES];
    }
    //2
    if ([sysModel.opentype isEqualToString:@"异常服装确认"]) {
        ALSystemMessageDetailViewController *sysTemDetail = [[ALSystemMessageDetailViewController alloc]init];
        sysTemDetail.messageDataInfoModel = _sysmessageArr[indexPath.row];
        sysTemDetail.expressId = _sysmessageArrGood[indexPath.row][@"param"];
        [self.navigationController pushViewController:sysTemDetail animated:YES];
    }
    //3
    if ([sysModel.opentype isEqualToString:@"邀请码"]) {
        ALGetCodeViewController *sysTemDetail = [[ALGetCodeViewController alloc]init];
        sysTemDetail.messageDataInfoModel = _sysmessageArr[indexPath.row];
        sysTemDetail.codeMessage = _sysmessageArrGood[indexPath.row][@"param"];
        NSLog(@"%@",_sysmessageArrGood[indexPath.row]);
        [self.navigationController pushViewController:sysTemDetail animated:YES];
    }
    //4
    if ([sysModel.opentype isEqualToString:@"时尚期刊"]) {
        ALPeriodicalsViewController *theCtrl=[[ALPeriodicalsViewController alloc] init];
        [theCtrl setPeriodicalsId:_sysmessageArrGood[indexPath.row][@"param"]];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }
    //5
    if ([sysModel.opentype isEqualToString:@"魔法包"]) {
        ALMagicBagViewController*_theMagicBagCtrl=[[ALMagicBagViewController alloc] init];
        [self.navigationController pushViewController:_theMagicBagCtrl animated:YES];
    }
    //6
    if ([sysModel.opentype isEqualToString:@"最新"]) {
        ALLastNewViewController *theCtrl=[[ALLastNewViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }
    //7
    if ([sysModel.opentype isEqualToString:@"购买魔法包"]) {
        ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }
    
}
-(void)_loadSysMessageAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":[[ALLoginUserManager sharedInstance] getUserId],
                            @"pageNo":[NSString stringWithFormat:@"%d",_pageNo],
                            @"pageSize":@"10"
                            };
    [DataRequest requestApiName:@"userCenter_getSysRecords"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
        @try {
            NSArray *tempArr=sucContent[@"body"][@"result"][@"dataList"];
            [_sysmessageArrGood addObjectsFromArray:tempArr];
            [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALSysMessageModel *theModel=[ALSysMessageModel questionWithDict:obj];
                [_sysmessageArr addObject:theModel];
            }];
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        if (theBlock) {
            theBlock();
        }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)endRefresh
{
    [_sysTableView headerEndRefreshing];
    [_sysTableView footerEndRefreshing];
}

@end
