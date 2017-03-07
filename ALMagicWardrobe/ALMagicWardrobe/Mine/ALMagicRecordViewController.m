//
//  ALMagicRecordViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-14.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicRecordViewController.h"
#import "NSDateUtilities.h"
#import "ALLine.h"
@interface ALMagicRecordViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    int _pageNo;
    ALTableView *_magicRecordTableView;
}
@end

@implementation ALMagicRecordViewController{
    NSMutableArray *_magicRecordMulArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNo = 1;
    [self setTitle:@"魔法值记录"];
    
    [self _initData];
    
    [self _initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
}

-(void)_initData{
    
    _magicRecordMulArr=[[NSMutableArray alloc] initWithCapacity:2];

}
-(void)_loadMore{
    _pageNo+=1;
    [self _load_userCenter_getMagicRecordsDataDataAndBlock:^{
        
        [_magicRecordTableView footerEndRefreshing];
        
        [_magicRecordTableView reloadData];
        
        
    }];
}
-(void)_load_userCenter_getMagicRecordsDataDataAndBlock:(void(^)())theBlock{
    
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"pageNo":[NSString stringWithFormat:@"%d",_pageNo],
                            @"pageSize":@"10"
                            };
    [DataRequest requestApiName:@"userCenter_getMagicRecords"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       
                       @try {
                           [_magicRecordMulArr  addObjectsFromArray:sucContent[@"body"][@"result"][@"dataList"]];
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
-(void)_initView{
    
    _magicRecordTableView=[[ALTableView alloc]
                                       initWithFrame:CGRectMake(0,
                                                                0.f,
                                                                kScreenWidth,
                                                                self.view.size.height - 64)];
    [_magicRecordTableView setDataSource:self];
    [_magicRecordTableView setDelegate:self];
    [_magicRecordTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
    __block ALMagicRecordViewController *blockSelf = self;
    [_magicRecordTableView addFooterWithCallback:^{
        [blockSelf _loadMore];
    }];
    [self _load_userCenter_getMagicRecordsDataDataAndBlock:^{
        
        [_magicRecordTableView reloadData];
    }];
    [self.contentView addSubview:_magicRecordTableView];
    self.contentView.scrollEnabled = NO;
    
}
#pragma mark - uitableview 的代理
//////头部
//-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    return View;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 230;
//    
//}
//


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _magicRecordMulArr.count+ 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)
    {
        static NSString *theCellIdentify=@"theCellIdentify1";
        UITableViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:theCellIdentify];
        if (theCell==nil) {
            theCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:theCellIdentify];
            ALComView *View = [[ALComView alloc]
                               initWithFrame:CGRectMake(0, 0, kScreenWidth, 230)];
            View.backgroundColor = [UIColor whiteColor];
            ALImageView *imageView = [[ALImageView alloc]
                                      initWithFrame:CGRectMake((kScreenWidth-99)/2, 35/2, 198/2, 198/2)];
            imageView.image = [ALImage imageNamed:@"magic_point_icon"];
            [View addSubview:imageView];
            
            __block float orginy=0;
            
            NSArray *contentArr=@[@"像淑女一样善待衣物",
                                  @"像君子一样与我交往",
                                  @"像天使一样把魔法的快乐分享给小伙伴......",
                                  @"别看她们魔法值蹭蹭涨，其实就这么简单"];
            
            [contentArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALLabel *lbl=[[ALLabel alloc]
                              initWithFrame:CGRectMake(0,
                                                       125+20*idx,
                                                       kScreenWidth,
                                                       20)];
                [lbl setText:contentArr[idx]];
                [lbl setTextAlignment:NSTextAlignmentCenter];
                lbl.font =[UIFont systemFontOfSize:13];
                [lbl setTextColor:colorByStr(@"#616161")];
                [View addSubview:lbl];
                orginy=lbl.bottom;
            }];
            
            ALLine *line=[[ALLine alloc] initWithFrame:CGRectMake(0, View.height-1, kScreenWidth, 1)];
            [View addSubview:line];
            [theCell addSubview:View];
        }
        
        
        return theCell;
    }
    else
    {
        static NSString *theCellIdentify=@"theCellIdentify";
        UITableViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:theCellIdentify];
        if (theCell==nil) {
            theCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:theCellIdentify];
            ALLabel *lineLbl=[[ALLabel alloc]
                              initWithFrame:CGRectMake(10, 5, kScreenWidth-80, 20)];
            [lineLbl setTag:101];
            [lineLbl setTextColor:colorByStr(@"#757575")];
            [theCell addSubview:lineLbl];
            lineLbl.font =[UIFont systemFontOfSize:13];
            {
                ALLabel *lineLbl=[[ALLabel alloc]
                                  initWithFrame:CGRectMake(10, 25, kScreenWidth-80, 20)];
                [lineLbl setTag:102];
                [lineLbl setBackgroundColor:RGB_BG_Clear];
                [lineLbl setTextColor:colorByStr(@"#9A9A9A")];
                lineLbl.font =[UIFont systemFontOfSize:13];
                
                [theCell addSubview:lineLbl];
            }
            {
                ALLabel *lineLbl=[[ALLabel alloc]
                                  initWithFrame:CGRectMake(kScreenWidth-100, 5, 80, 20)];
                [lineLbl setTag:103];
                [lineLbl setBackgroundColor:RGB_BG_Clear];
                [lineLbl setTextColor:colorByStr(@"#2F2F2F")];
                lineLbl.textAlignment = NSTextAlignmentRight;
                lineLbl.font =[UIFont systemFontOfSize:13];
                
                [theCell addSubview:lineLbl];
            }
            {
                ALLabel *lineLbl=[[ALLabel alloc]
                                  initWithFrame:CGRectMake(kScreenWidth-100, 25, 80, 20)];
                [lineLbl setTag:104];
                [lineLbl setBackgroundColor:RGB_BG_Clear];
                [lineLbl setTextColor:colorByStr(@"#9A9A9A")];
                lineLbl.font =[UIFont systemFontOfSize:13];
                
                lineLbl.textAlignment = NSTextAlignmentRight;
                [theCell addSubview:lineLbl];
            }
            ALLabel *eveLine=[[ALLabel alloc] initWithFrame:CGRectMake(0, 94/2-1, theCell.width, .5f)];
            [eveLine setBackgroundColor:AL_RGB(169,161,152)];
            [theCell addSubview:eveLine];
            //        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        ALLabel *theLineLblOne=(ALLabel *)[theCell viewWithTag:101];
        ALLabel *theLineLblTwo=(ALLabel *)[theCell viewWithTag:103];
        ALLabel *theLineLblThree=(ALLabel *)[theCell viewWithTag:102];
        ALLabel *theLineLblFour=(ALLabel *)[theCell viewWithTag:104];
        NSInteger row = indexPath.row;
        row = row-1;
        theLineLblOne.text = MBNonEmptyString(_magicRecordMulArr[row][@"content"]);
        NSString *tmp = MBNonEmptyString(_magicRecordMulArr[row][@"magicvalue"]);
        NSString *str = @"";
        if (tmp.length > 0) {
            int num =[tmp intValue];
            if (num < 0)
            {
                str = @"";
            }
            if (num > 0)
            {
                str = @"+";
            }
        }
        theLineLblTwo.text = [NSString stringWithFormat:@"%@%@点",str,tmp];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalString:filterStr(_magicRecordMulArr[row][@"createTime"])];
        
        theLineLblThree.text = [confromTimesp dateString2];
        
        theLineLblFour.text = MBNonEmptyString(@"魔法值");
        
        return theCell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)
    {
        return 230;
    }
    else
    {
        return 94/2;
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)endRefresh
{
    [_magicRecordTableView headerEndRefreshing];
    [_magicRecordTableView footerEndRefreshing];
}



@end
