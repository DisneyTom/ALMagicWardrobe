//
//  ALMagicBagRecordViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicBagRecordViewController.h"
#import "ALMagicBagRecoderTableViewCell.h"
#import "ALMagicBagRecomentViewController.h"

#import "ALMagicBagRecomentViewController.h"

@interface ALMagicBagRecordViewController ()
<UITableViewDataSource,
UITableViewDelegate>
@end

@implementation ALMagicBagRecordViewController
{
    NSArray *_listRecorders;
    ALTableView *magicBagTableView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"魔法包记录"];
    
    [self _initData];
   // [AFNconnectionImport connectionWifi];
    [self _initView];
}
-(void)_initData{
}
-(void)_initView{
    magicBagTableView=[[ALTableView alloc]
                                    initWithFrame:CGRectMake(0,
                                                             0,
                                                             kScreenWidth,
                                                             self.contentView.height)];
    [magicBagTableView setDataSource:self];
    [magicBagTableView setDelegate:self];
    [magicBagTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [magicBagTableView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:magicBagTableView];
    self.contentView.backgroundColor = AL_RGB(240, 236, 233);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self _getMagicHistoryListAndBlock:^{
        [magicBagTableView reloadData];
    }];
}

#pragma mark UITableView DataSource and Delegate
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listRecorders.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *magicBagIdentify=@"magicBagIdentify";
    ALMagicBagRecoderTableViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:magicBagIdentify];
    if (theCell==nil) {
        theCell=[[ALMagicBagRecoderTableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:magicBagIdentify];
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [theCell setDic:_listRecorders[indexPath.row]];
    [theCell setTheBlock:^(id sender){
        ALMagicBagRecomentViewController *theCtrl=[[ALMagicBagRecomentViewController alloc] init];
        NSDictionary *dict = _listRecorders[indexPath.row];
        [theCtrl setArr:_listRecorders[indexPath.row][@"fashions"]];
        theCtrl.expressId = dict[@"magicExpress"][@"id"];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    return theCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return recoderHeight;
}

#pragma mark loadData
#pragma mark -
#pragma mark 查询魔法包历史记录
-(void)_getMagicHistoryListAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    showRequest;
    [DataRequest requestApiName:@"magicBag_getMagicHistoryList"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       hideRequest;
                       if ([sucContent[@"body"][@"result"] isKindOfClass:[NSArray class]]) {
                           _listRecorders=sucContent[@"body"][@"result"];
                       }
                       if (theBlock) {
                           theBlock();
                       }
    } failedBlock:^(id failContent) {
        hideRequest;
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
        hideRequest;
    }];
}
@end
