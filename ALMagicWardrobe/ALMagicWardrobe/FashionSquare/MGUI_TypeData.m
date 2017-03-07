//
//  MGUI_TypeData.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/16.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUI_TypeData.h"
#import "MGUI_TypeViewCell.h"
#import "MGData_Type.h"
#import "ALClothesDetailViewController.h"

@interface MGUI_TypeData()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation MGUI_TypeData
{
    UIButton* btn;
    ALTableView* tableView_Type;
    NSMutableArray* _listClothesArr;
    int _pageNo;
}
@synthesize string_Style,string_Type;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    _pageNo = 1;
    _listClothesArr = [[NSMutableArray alloc]init];
    tableView_Type=[[ALTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height)
                                                       style:UITableViewStyleGrouped];
    [tableView_Type setDataSource:self];
    [tableView_Type setDelegate:self];
    [tableView_Type setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    __block MGUI_TypeData *theCtrl=self;
    [tableView_Type addHeaderWithCallback:^{
        [theCtrl headLoadMore];
    }];
    [tableView_Type addFooterWithCallback:^{
        [theCtrl foodLoadMore];
    }];
    [self addSubview:tableView_Type];
    UIColor *backColor = colorByStr(@"#F0ECE9");
    tableView_Type.backgroundColor = backColor;
  
    return self;
}
-(void)reload:(NSString *)style Type:(NSString *)type
{
    _pageNo = 1;
    string_Style = style;
    string_Type = type;
    [_listClothesArr removeAllObjects];
    [self _loadFashionSquareAllDataAndBlock:^{
        [tableView_Type reloadData];
    }];
}

-(void)headLoadMore{
    _pageNo=1;
    [self _loadFashionSquareAllDataAndBlock:^{
        [tableView_Type headerEndRefreshing];
        [tableView_Type reloadData];
    }];
}
-(void)foodLoadMore{
    _pageNo+=1;
    [self _loadFashionSquareAllDataAndBlock:^{
        [tableView_Type footerEndRefreshing];
        [tableView_Type reloadData];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listClothesArr.count/2+_listClothesArr.count%2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *clothesIdentify=@"clothesMoreIdentify";
    MGUI_TypeViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:clothesIdentify];
    if (theCell==nil) {
        theCell=[[MGUI_TypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clothesIdentify];
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
        else
        {
            [theCell setRightModel:nil];
        }
        
        [theCell setTheBlock:^(NSInteger index){
            if (index==0) {
                MGData_Type *theModel=_listClothesArr[indexPath.row*2+0];
                if (self.theblock)
                {
                    self.theblock(theModel.keyFashionsId);
                }
            }else if (index==1){
                NSInteger indexTmp = indexPath.row*2+1;
                if (indexTmp < _listClothesArr.count)
                {
                    MGData_Type *theModel=_listClothesArr[indexTmp];
                    if (self.theblock)
                    {
                        self.theblock(theModel.keyFashionsId);
                    }
                }
                
            }
            
        }];
        
        return theCell;
    }
    return theCell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
#pragma mark loadData
#pragma mark -
-(void)_loadFashionSquareAllDataAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"type":string_Type,
                            @"style":string_Style,
                            @"pageNo":[NSString stringWithFormat:@"%d",_pageNo],
                            @"pageSize":@"10"
                            };
    if (_pageNo==1) {
        [_listClothesArr removeAllObjects];
    }
    NSLog(@"%@",sendDic);
    [DataRequest requestApiName:@"fashionSquare_fashionSquareAllData" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
        
        @try {
            NSArray *clothsArr=sucContent[@"body"][@"result"][@"dataList"];
            
        [clothsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                MGData_Type *theModel=[MGData_Type questionWithDict:obj];
                [_listClothesArr addObject:theModel];
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
    [tableView_Type headerEndRefreshing];
    [tableView_Type footerEndRefreshing];
}
@end
