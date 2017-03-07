//
//  ALCollectViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALCollectViewController.h"
#import "ALTableView.h"
#import "ALPersonalDataCell.h"
#import "ALPeriodicalsModel.h"
#import "ALLoginViewController.h"
#import "ALPeriodicalsViewController.h"
#import "ALPeriodicalsModel.h"

@interface ALCollectViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    ALTableView *_userMainTable;
    NSMutableArray *_colectionDataArray;
    int _pageNo;
}
@end

@implementation ALCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNo = 1;
    [self setTitle:@"我的收藏"];
    
    [self _initData];
    
    [self _initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
    
    if (![[ALLoginUserManager sharedInstance] loginCheck]) {
        
        
        __block ALCollectViewController *blockSelf = self;
        [self setViewWithType:rightBtn1_type
                      andView:^(id view) {
                          ALButton *theBtn=view;
                          
                          [theBtn setImage:[ALImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
                          
                      } andBackEvent:^(id sender) {
                          ALLoginViewController *loginVC = [[ALLoginViewController alloc] init];
                          [blockSelf.navigationController pushViewController:loginVC animated:YES];
                          
                      }];
        
        
    }
    self.contentView.backgroundColor =  HEX(@"#efebe8");
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _pageNo =1;
    [self _loadUserCollectsAndBlock:^{
        [_userMainTable reloadData];
    }];

}
-(void)_initData{
    _colectionDataArray=[NSMutableArray array];
}
-(void)_initView
{
    _userMainTable=[[ALTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,self.contentView.height)];
    _userMainTable.delegate = self;
    _userMainTable.dataSource = self;
    _userMainTable.showsVerticalScrollIndicator = NO;
    _userMainTable.backgroundView = nil;
    _userMainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (IOS7_OR_LATER) {
        [_userMainTable setSeparatorInset:UIEdgeInsetsZero];
    }
    _userMainTable.backgroundColor = [UIColor clearColor];
    [self setExtraCellLineHidden:_userMainTable];
    [self.contentView addSubview:_userMainTable];
    __block ALCollectViewController *blockSelf  = self;
    [_userMainTable addFooterWithCallback:^{
        [blockSelf loadMoreView];
    }];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _colectionDataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *theCellIdentify=@"MBCollectionShopCell";
    MBCollectionShopCell *theCell= [tableView dequeueReusableCellWithIdentifier:theCellIdentify];
    if (theCell == nil) {
        theCell = [[MBCollectionShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:theCellIdentify];
        ALPeriodicalsModel *theModel=_colectionDataArray[indexPath.row];
        [theCell setImages:nil
                    orTits:@[@"删除"]
                   andBack:^(NSInteger index) {
            [self _userCenter_delCollectsAndBlock:^{
            } andPeriodicalsId:theModel.periodicalsId];
        }];
        theCell.accessoryType = UITableViewCellAccessoryNone;
        theCell.backgroundColor =  HEX(@"#efebe8");
        
    }
    
    [theCell setModel:_colectionDataArray[indexPath.row]];
    
    return theCell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALPeriodicalsViewController *theCtrl=[[ALPeriodicalsViewController alloc] init];
    theCtrl.comeFromMyColecton = YES;
    ALPeriodicalsModel *theModel=_colectionDataArray[indexPath.row];
    [theCtrl setPeriodicalsId:theModel.periodicalsId];
    [self.navigationController pushViewController:theCtrl animated:YES];
}
-(void)loadMoreView{
    
    _pageNo+=1;
    [self _loadUserCollectsAndBlock:^{
        
        [_userMainTable footerEndRefreshing];
        
        [_userMainTable reloadData];
        
        
    }];
}

#pragma mark loadData
#pragma mark -
-(void)_loadUserCollectsAndBlock:(void(^)())theBlock{
    if (_pageNo==1) {
        [_colectionDataArray removeAllObjects];
    }
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"periodcalIds":@"",
                            @"pageNo":[NSString stringWithFormat:@"%d",_pageNo],
                            @"pageSize":@"10"
                            };
    [DataRequest requestApiName:@"userCenter_getUserCollects" andParams:sendDic andMethod:Get_type successBlcok:^(id sucContent) {
        @try {
            NSArray *arr=sucContent[@"body"][@"result"][@"dataList"];
            [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALPeriodicalsModel *theModel=[ALPeriodicalsModel questionWithDict:obj];
                [_colectionDataArray addObject:theModel];
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

//删除收藏
-(void)_userCenter_delCollectsAndBlock:(void(^)())theBlock
                      andPeriodicalsId:(NSString *)periodicalsId{
    NSDictionary *sendDic=@{
                            @"periodcalId":filterStr(periodicalsId),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"userCenter_delCollects"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
        if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
            showWarn(@"删除收藏失败");
            
        }else{
            showWarn(@"删除收藏成功");
            _pageNo =1;
            [self _loadUserCollectsAndBlock:^{
                [_userMainTable reloadData];
            }];
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
    [_userMainTable headerEndRefreshing];
    [_userMainTable footerEndRefreshing];
}

@end
