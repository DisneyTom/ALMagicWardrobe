//
//  MGUI_Popularity.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/12.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUI_Popularity.h"
#import "MGUI_SquareTableViewCell.h"
#import "DataRequest.h"

@interface MGUI_Popularity()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation MGUI_Popularity
{
    
    ALTableView *_tableView;
    NSMutableArray *_listClothesArr;
    NSInteger _currentPage;
    NSInteger _pageSize;
    BOOL _canLoad; //为YES时，能加载更多
}
@synthesize theBlock,block;
- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _currentPage = 1;
    _pageSize = 10;
    _tableView=[[ALTableView alloc]
                initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView addHeaderWithTarget:self action:@selector(headViewLoad)];
    [_tableView addFooterWithTarget:self action:@selector(foodViewLoad)];
    _tableView.backgroundColor = [UIColor clearColor];
    _listClothesArr = [[NSMutableArray alloc]init];
    [self addSubview:_tableView];
    [self _loadFashionSquareDataAndBlock:^{
        [_tableView reloadData];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
    return  self;
}
-(void)headViewLoad{
    _currentPage=1;
   [self _loadFashionSquareDataAndBlock:^{
       [_tableView headerEndRefreshing];
       [_tableView reloadData];
   }];
}
-(void)foodViewLoad{
    if (_canLoad) {
        _currentPage++;
        [self _loadFashionSquareDataAndBlock:^{
            [_tableView footerEndRefreshing];
            [_tableView reloadData];
        }];
    }else{
        [_tableView footerEndRefreshing];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _tableView.frame = self.bounds;
    
}
#pragma mark - delegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listClothesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *clothesIdentify=@"popu";
    MGUI_SquareTableViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:clothesIdentify];
    if (theCell==nil)
    {
        theCell=[[MGUI_SquareTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clothesIdentify];
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    theCell.backgroundColor = AL_RGB(240,236,233);
    theCell.contentView.backgroundColor = AL_RGB(240,236,233);
    [theCell setModel:_listClothesArr[indexPath.row]];

    return theCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 345;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGData_KeyFashions* mode = _listClothesArr[indexPath.row];
    if (theBlock)
    {
        theBlock(mode.keyFashionsId);
    }
}

#pragma mark -- 置顶
-(void)toTop
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger curPage=scrollView.contentOffset.y/scrollView.height;
    if (curPage>=2)
    {
        if (block)
        {
            block(true);
        }
    }else{
        if (block)
        {
            block(false);
        }
    }
}
-(void)_loadFashionSquareDataAndBlock:(void(^)())theBlocksss{
    NSDictionary *sendDic=@{
                            @"pageNo":@(_currentPage),
                            @"pageSize":@"10"
                            };
    [DataRequest requestApiName:@"fashionSquare_fashionSquareHotData"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       if (_currentPage==1) {
                           [_listClothesArr removeAllObjects];
                       }
                       @try {
                           NSArray *clothsArr=sucContent[@"body"][@"result"][@"fashions"];
                           if (!clothsArr.count>0) {
                               _canLoad=NO;
                           }else{
                               _canLoad=YES;
                           }
                           if (clothsArr) {
                               [clothsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                   MGData_KeyFashions *theModel=[MGData_KeyFashions questionWithDict:obj];
                                   [_listClothesArr addObject:theModel];
                               }];
                           }
                           if (theBlocksss) {
                               theBlocksss();
                           }
                       }
                       @catch (NSException *exception) {
                       }
                       @finally {
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
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
}
@end

