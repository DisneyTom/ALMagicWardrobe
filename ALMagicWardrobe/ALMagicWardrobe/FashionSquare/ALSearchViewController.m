//
//  ALSearchViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-22.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALSearchViewController.h"
#import "ALUtilities.h"
#import "ALClothesDetailViewController.h"
#import "ALClothesTableViewCell.h"

@interface ALSearchViewController ()
<UITableViewDataSource,UITableViewDelegate>
@end

@implementation ALSearchViewController{
    NSMutableArray *_listClothesArr;
    ALTableView *_moreClothesTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor = AL_RGB(240,236,233);
    [self setTitle:@"搜索结果"];
    
    [self _initData];
    
    [self _initView];
    
    [self _loadFashionSearchAndBlock:^{
       [_moreClothesTableView reloadData];
    }];
}

-(void)_initData{
    _listClothesArr=[NSMutableArray array];
}
-(void)_initView{
    _moreClothesTableView=[[ALTableView alloc]
                           initWithFrame:CGRectMake(0, 0, kScreenWidth, self.contentView.height)];
    [_moreClothesTableView setDataSource:self];
    [_moreClothesTableView setDelegate:self];
    [_moreClothesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contentView addSubview:_moreClothesTableView];
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
                NSInteger index = indexPath.row*2+1;
                if (index < _listClothesArr.count)
                {
                    ALClothsModel *theModel=_listClothesArr[index];
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
-(void)_loadFashionSearchAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"search":filterStr(self.key)
                            };
    [DataRequest requestApiName:@"fashionSquare_fashionSearch"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
        @try {
            @try {
                NSArray *arr=sucContent[@"body"][@"result"][@"dataList"];
                if (arr) {
                    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        ALClothsModel *theModel=[ALClothsModel questionWithDict:obj];
                        [_listClothesArr addObject:theModel];
                    }];
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
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
@end
