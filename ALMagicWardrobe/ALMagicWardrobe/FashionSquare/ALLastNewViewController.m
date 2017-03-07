//
//  ALLastNewViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-20.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALLastNewViewController.h"
#import "ALUtilities.h"
#import "ALClothesDetailViewController.h"
#import "ALSearchViewController.h"
#import "ALClothesTableViewCell.h"
#import "MGUICtrl_Search.h"

@interface ALLastNewViewController ()
<UIScrollViewDelegate,
ALTextFiledDelegate,
UITableViewDataSource,
UITableViewDelegate>
@end

@implementation ALLastNewViewController
{
    NSMutableArray *_listClothesArr;
    int _pageNo;
    
    ALTableView *_moreClothesTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上新";
    _pageNo =1;
    [self _initData];
    __block ALLastNewViewController *theCtrl=self;

    [self _initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
    [self setViewWithType:rightBtn1_type
                  andView:^(id view) {
                      ALButton *btn=view;
                      [btn setHidden:NO];
                      [btn setImage:[ALImage imageNamed:@"icon006"] forState:UIControlStateNormal];
                  } andBackEvent:^(id sender) {
                      [theCtrl toSearchCtrl];
                  }];

    
    [self _loadFashionSquareNewDataAndBlock:^{
        [_moreClothesTableView reloadData];
    }];
}

-(void)toSearchCtrl
{
    MGUICtrl_Search *theSearchCtrl = [[MGUICtrl_Search alloc] init];
    [self.navigationController pushViewController:theSearchCtrl animated:YES];
}
- (void)textViewDidCancelEditing:(ALTextField *)textField //点击键盘上的“取消”按钮。
{
    textField.text = @"";
}
- (void)textViewDidFinsihEditing:(ALTextField *)textField //点击键盘框上的"确认"按钮。
{
    [textField resignFirstResponder];
    ALSearchViewController *theSearchCtrl=[[ALSearchViewController alloc] init];
    [theSearchCtrl setKey:textField.text];
    [self.navigationController pushViewController:theSearchCtrl animated:YES];
}

-(void)_initData{
    _listClothesArr=[NSMutableArray array];
}
-(void)_initView{
    _moreClothesTableView=[[ALTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.contentView.height)];
    [_moreClothesTableView setDataSource:self];
    [_moreClothesTableView setDelegate:self];
    [_moreClothesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    __block ALLastNewViewController *theBlockCtrl=self;
    [_moreClothesTableView addHeaderWithCallback:^{
        [theBlockCtrl headLoadMore];
    }];
    [_moreClothesTableView addFooterWithCallback:^{
        [theBlockCtrl foodLoadMore];
    }];
    [self.contentView addSubview:_moreClothesTableView];
    UIColor *backColor = AL_RGB(240,236,233);
    _moreClothesTableView.backgroundColor = backColor;
    self.contentView.backgroundColor = backColor;
}
-(void)headLoadMore{
    _pageNo=1;
    [self _loadFashionSquareNewDataAndBlock:^{
        [_moreClothesTableView headerEndRefreshing];
        [_moreClothesTableView reloadData];
    }];
}
-(void)foodLoadMore{
    _pageNo+=1;
    [self _loadFashionSquareNewDataAndBlock:^{
        [_moreClothesTableView footerEndRefreshing];
        [_moreClothesTableView reloadData];
    }];
}
#pragma mark datasource and Delegate
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listClothesArr.count/2+_listClothesArr.count%2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *clothesIdentify=@"clothesMoreIdentify";
    ALClothesTableViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:clothesIdentify];
    if (theCell==nil) {
        theCell=[[ALClothesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clothesIdentify];
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSInteger index = indexPath.row;
    NSInteger count = _listClothesArr.count;
    NSInteger mod = count /2;
    if (count % 2 > 0)
    {
        mod ++;
    }
    
    if (index < mod)
    {
        [theCell setLeftModel:_listClothesArr[indexPath.row*2+0]];
        
        if ((indexPath.row+1)*2<=_listClothesArr.count) {
            [theCell setRightModel:_listClothesArr[indexPath.row*2+1]];
        }
        else{
             [theCell setRightModel:nil];
        }
        
        [theCell setTheBlock:^(NSInteger index){
            ALClothesDetailViewController *theClothesDetailCtrl=[[ALClothesDetailViewController alloc] init];
            
            if (index==0) {
                ALClothsModel *theModel=_listClothesArr[indexPath.row*2+0];
                [theClothesDetailCtrl setFashionId:theModel.clothsId];
                theClothesDetailCtrl.clothsModel = theModel;
                [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
            }else if (index==1){
                NSInteger tmp = indexPath.row*2+1;
                if (tmp < _listClothesArr.count)
                {
                    ALClothsModel *theModel=_listClothesArr[tmp];
                    [theClothesDetailCtrl setFashionId:theModel.clothsId];
                    theClothesDetailCtrl.clothsModel = theModel;
                    [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
                }

            }
  
        }];
        
        return theCell;
    }
    
    return theCell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 644/4+10+108/4;
}

#pragma mark loadData
#pragma mark -
//加载最新数据
-(void)_loadFashionSquareNewDataAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"pageNo":[NSString stringWithFormat:@"%d",_pageNo],
                            @"pageSize":@"10"
                            };
    [DataRequest requestApiName:@"fashionSquare_fashionSquareNewData"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       if (_pageNo==1) {
                           [_listClothesArr removeAllObjects];
                       }
        @try {
            
            NSArray *clothsArr=sucContent[@"body"][@"result"][@"dataList"];
            if (clothsArr) {
                [clothsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    ALClothsModel *theModel=[ALClothsModel questionWithDict:obj];
                    [_listClothesArr addObject:theModel];
                }];
            }

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
    [_moreClothesTableView headerEndRefreshing];
    [_moreClothesTableView footerEndRefreshing];
}

@end
