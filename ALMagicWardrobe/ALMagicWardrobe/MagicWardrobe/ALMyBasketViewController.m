//
//  ALMyBasketViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMyBasketViewController.h"
#import "ALMyBasketCollectionViewCell.h"
#import "ALClothesDetailViewController.h"
//#import "AFNconnectionImport.h"
#import "ALClothsModel.h"
@interface ALMyBasketViewController ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>
@end

@implementation ALMyBasketViewController{
    NSString *CellIdentifier;
    NSMutableArray *_listClothesArr;
    UICollectionView *_collectView;
    NSMutableArray *_selectedArr; //选择的数据
    int _pageNo;
    
    //是否处于编辑状态
    BOOL _isEdit; //如果是编辑状态，可以勾选，否则点击进入详情页
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNo = 1;
    _isEdit = NO;
    [self setTitle:@"衣篓"];
    
    __block ALMyBasketViewController *theBlockCtrl=self;
    
    [self setViewWithType:rightBtn1_type
                  andView:^(id view) {
                      ALButton *theBtn=view;
//                      [theBtn setFrame:CGRectMake(theBtn.left+theBtn.width/4, theBtn.top+theBtn.height/4, theBtn.width/2, theBtn.height/2)];
                      [theBtn setFrame:CGRectMake(285, 28, 22, 25)];
                      [theBtn setImage:[[ALImage imageNamed:@"icon_delete"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                  } andBackEvent:^(id sender) {
                      [theBlockCtrl _deleFashionAndBlock];
                  }];
    
    [self _initData];
   // [AFNconnectionImport AFNconnectionStarttest];
    
    [self _initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
    
//    [self _loadMyWardrobeAbanDataAndBlock:^{
//        [_collectView reloadData];
//    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _headLoadMore];
}

-(void)_initData{
    CellIdentifier = @"ALMyBasketCollectionViewCell";
    _listClothesArr=[NSMutableArray array];
    _selectedArr= [NSMutableArray array];
}
-(void)_initView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectView = [[UICollectionView alloc]
                    initWithFrame:CGRectMake(0,
                                             0,
                                             kScreenWidth,
                                             self.contentView.height)
                    collectionViewLayout:layout];
    [_collectView setBackgroundColor:[UIColor whiteColor]];
    [_collectView registerClass:[ALMyBasketCollectionViewCell class]
     forCellWithReuseIdentifier:CellIdentifier];
    [_collectView setAlwaysBounceVertical:YES];
    [_collectView setDelegate:self];
    [_collectView setDataSource:self];
    [self.contentView addSubview:_collectView];
    __block ALMyBasketViewController *blockSelf = self;
    [_collectView addHeaderWithCallback:^{
        [blockSelf _headLoadMore];
    }];
    [_collectView addFooterWithCallback:^{
       // [AFNconnectionImport AFNconnectionStarttest];
        [blockSelf _footLoadMore];
    }];
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _listClothesArr.count;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets top = {13,13,13,13};
    return top;
}
//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 13;
}
//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(140,205);
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALMyBasketCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                                           forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row < _listClothesArr.count)
    {
        [cell setModel:_listClothesArr[indexPath.row]];
        cell.isEdit = _isEdit;
        [cell setTheBlock:^(id sender){
            if (indexPath.row < _listClothesArr.count)
            {
                ALMagicWardrobeClothsModel *theModel=_listClothesArr[indexPath.row];
                [self _returnWardrobeAndBlock:^{
                    [self _loadMyWardrobeAbanDataAndBlock:^{
                        [_collectView reloadData];
                    }];
                } andWardrobeId:theModel.mwColothsId];
            }
            
        }];
    }
    else
    {
        [cell setModel:nil];
    }

    return cell;
}

//collectView点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    if (row < _listClothesArr.count)
    {
        ALMagicWardrobeClothsModel *theModel=_listClothesArr[row];
        if (_isEdit)
        {
            theModel.isSelected = !theModel.isSelected;
            [_collectView reloadData];
        }
        else
        {
            ALClothesDetailViewController *theClothesDetailCtrl=[[ALClothesDetailViewController alloc] init];
            theClothesDetailCtrl.isMyBash = YES;
            [theClothesDetailCtrl setFashionId:theModel.fashion_id];
            theClothesDetailCtrl.mwColothsId = theModel.mwColothsId;
            [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
        }
    }
    
    

}
-(void)_headLoadMore{
    _pageNo=1;
    [self _loadMyWardrobeAbanDataAndBlock:^{
     //   [AFNconnectionImport AFNconnectionStarttest];
        [_collectView headerEndRefreshing];
        [_collectView reloadData];
    }];
}
-(void)_footLoadMore{
    _pageNo+=1;
    [self _loadMyWardrobeAbanDataAndBlock:^{
        [_collectView footerEndRefreshing];
        [_collectView reloadData];
    }];
}
#pragma mark loadData
#pragma mark -
#pragma mark 获取我的废衣娄数据
-(void)_loadMyWardrobeAbanDataAndBlock:(void(^)())theBlock{
    if (_pageNo==1) {
        [_listClothesArr removeAllObjects];
    }
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"pageNo":[NSString stringWithFormat:@"%d",_pageNo],
                            @"pageSize":@"10"
                            };
    [DataRequest requestApiName:@"fashionSquare_myWardrobeAbanData" andParams:sendDic andMethod:Get_type successBlcok:^(id sucContent) {
        @try {
            NSArray *tempArr=sucContent[@"body"][@"result"][@"dataList"];
            [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALMagicWardrobeClothsModel *theModel=[ALMagicWardrobeClothsModel questionWithDict:obj];
            //    [AFNconnectionImport  connectionWifi];

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

#pragma mark 从废衣娄删除
-(void)_deleFashionAndBlock{
    
    _isEdit = YES;
    if (_isEdit == YES)
    {
        NSMutableString *mulStr=[[NSMutableString alloc] initWithCapacity:0];
        [_listClothesArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALMagicWardrobeClothsModel *theModel=obj;
            if (theModel.isSelected == YES)
            {
                [mulStr appendFormat:@"%@,",theModel.mwColothsId];
            }
            
        }];
        if (mulStr.length > 0)
        {
            [self deleteItemByIdStr:mulStr];
        }
        [_collectView reloadData];
    }
    

    
    
//    NSMutableString *mulStr=[[NSMutableString alloc] initWithCapacity:2];
//    
//    [_listClothesArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        ALMagicWardrobeClothsModel *theModel=obj;
//        [mulStr appendFormat:@"%@,",theModel.mwColothsId];
//    }];
//    NSDictionary *sendDic=@{
//                            @"wardrobeIds":mulStr
//                            };
//    [DataRequest requestApiName:@"fashionSquare_deleFashion"
//                      andParams:sendDic
//                      andMethod:Get_type
//                   successBlcok:^(id sucContent) {
//                       showWarn(@"清空成功");
//                       [_listClothesArr removeAllObjects];
//                       if (theBlock) {
//                           theBlock();
//                       }
//                       [_collectView reloadData];
//    } failedBlock:^(id failContent) {
//        showFail(failContent);
//    } reloginBlock:^(id reloginContent) {
//    }];
}

- (void)deleteItemByIdStr:(NSString *)deleteStr
{
    if (deleteStr.length <= 0)
    {
        return;
    }
    
    NSDictionary *sendDic=@{
                            @"wardrobeIds":deleteStr
                            };
    [DataRequest requestApiName:@"fashionSquare_deleFashion"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       showWarn(@"清空成功");
                       [self _headLoadMore];
                       _isEdit = NO;
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                       [_collectView reloadData];
                   } reloginBlock:^(id reloginContent) {
                       [_collectView reloadData];
                   }];

}
#pragma mark 从废衣娄还原
-(void)_returnWardrobeAndBlock:(void(^)())theBlock
                 andWardrobeId:(NSString *)wardrobeId{
    NSDictionary *sendDic=@{
                            @"wardrobeId":filterStr(wardrobeId)
                            };
    [DataRequest requestApiName:@"fashionSquare_returnWardrobe"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
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
    [_collectView headerEndRefreshing];
    [_collectView footerEndRefreshing];
}
@end
