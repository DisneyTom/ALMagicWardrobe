//
//  ALClothesMoreViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-19.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALClothesMoreViewController.h"
#import "ALClothesDetailViewController.h"
#import "ALUtilities.h"
#import "ALSearchViewController.h"

#import "ALClothesTableViewCell.h"
#import "MGUICtrl_Search.h"

@interface ALClothesMoreViewController ()
<ALTextFiledDelegate,
UITableViewDataSource,
UITableViewDelegate>
@end

@implementation ALClothesMoreViewController{
    NSArray *_listIcons;
    NSMutableArray *_listClothesArr;
    NSString *_typeStr;
    int _pageNo;
    
    ALComView *iconView;
    ALTableView *_moreClothesTableView;
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
-(void)toSearchCtrl
{
    MGUICtrl_Search *theSearchCtrl = [[MGUICtrl_Search alloc] init];
    [self.navigationController pushViewController:theSearchCtrl animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNo = 1;
    self.title = @"所有";
    
    [self _initData];
    [self _initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
    
    __block ALClothesMoreViewController *theCtrl=self;
    [self setViewWithType:rightBtn1_type
                  andView:^(id view) {
                      ALButton *btn=view;
                      [btn setHidden:NO];
                      [btn setImage:[ALImage imageNamed:@"icon006"] forState:UIControlStateNormal];
                  } andBackEvent:^(id sender) {
                      [theCtrl toSearchCtrl];
                  }];

//    [self setViewWithType:navigationView_type
//                  andView:^(id view) {
//                      ALComView *theView=view;
//                      
//                      UIImageView *bgView=[[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-(kScreenWidth-140/4*2))/2.0f, (kNavigationBarHeight-29)/2+10, kScreenWidth-140/4*2, 29)];
//                      [bgView setImage:[ALImage imageNamed:@"bg01"]];
//                      [bgView setUserInteractionEnabled:YES];
//                      [theView addSubview:bgView];
//                      
//                      ALTextField *txt=[[ALTextField alloc] initWithFrame:CGRectMake(20, 0, bgView.width-40, bgView.height)];
//                      [txt setBackgroundColor:[UIColor clearColor]];
//                      [txt setPlaceholder:@"搜索"];
//                      [txt setPlaceColor:AL_RGB(153, 153, 153)];
//                      txt.font = [UIFont systemFontOfSize:12];
//                      [txt setTextColor:[UIColor whiteColor]];
//                      txt.textViewDelegate = theCtrl;
//                      [txt setTextAlignment:NSTextAlignmentCenter];
//                      [bgView addSubview:txt];
//                      
//                      ALButton *searchBtn=[ALButton buttonWithType:UIButtonTypeCustom];
//                      [searchBtn setFrame:CGRectMake(bgView.width-27-5, 1, 27, 27)];
//                      [searchBtn setImage:[ALImage imageNamed:@"icon006"] forState:UIControlStateNormal];
//                      [searchBtn setTheBtnClickBlock:^(id sender){
//                          [txt resignFirstResponder];
//                          ALSearchViewController *theSearchCtrl=[[ALSearchViewController alloc] init];
//                          [theSearchCtrl setKey:txt.text];
//                          [theCtrl.navigationController pushViewController:theSearchCtrl animated:YES];
//                      }];
//                      [bgView addSubview:searchBtn];
//                  } andBackEvent:^(id sender) {
//                  }];
    [self _loadFashionSquareAllDataAndBlock:^{
        [_moreClothesTableView reloadData];
    }];
}
-(void)_initData{
    _listIcons=@[
@{@"imgUrl_default":@"even_more_icon01",
  @"imgUrl_hight":@"even_more_icon01_on",
  @"tit":@"连衣裙"},
@{@"imgUrl_default":@"even_more_icon02",
  @"imgUrl_hight":@"even_more_icon02_on",
  @"tit":@"衬衫"},
@{@"imgUrl_default":@"even_more_icon03",
  @"imgUrl_hight":@"even_more_icon03_on",
  @"tit":@"针织衫"},
@{@"imgUrl_default":@"even_more_icon04",
  @"imgUrl_hight":@"even_more_icon04_on",
  @"tit":@"卫衣"},
@{@"imgUrl_default":@"even_more_icon05",
  @"imgUrl_hight":@"even_more_icon05_on",
  @"tit":@"半裙"},
@{@"imgUrl_default":@"even_more_icon06",
  @"imgUrl_hight":@"even_more_icon06_on",
  @"tit":@"T恤"},
@{@"imgUrl_default":@"even_more_icon07",
  @"imgUrl_hight":@"even_more_icon07_on",
  @"tit":@"外套"},
@{@"imgUrl_default":@"even_more_icon08",
  @"imgUrl_hight":@"even_more_icon08_on",
  @"tit":@"大衣"},
@{@"imgUrl_default":@"even_more_icon09",
  @"imgUrl_hight":@"even_more_icon09_on",
  @"tit":@"毛衣"},
@{@"imgUrl_default":@"even_more_icon10",
  @"imgUrl_hight":@"even_more_icon10_on",
  @"tit":@"马甲/背心"},
@{@"imgUrl_default":@"even_more_icon11",
  @"imgUrl_hight":@"even_more_icon11_on",
  @"tit":@"裤子"},
@{@"imgUrl_default":@"even_more_icon12",
  @"imgUrl_hight":@"even_more_icon12_on",
  @"tit":@"所有"}];
    
        _listClothesArr=[NSMutableArray array];

  }
-(void)_initView{
    iconView=[[ALComView alloc]
                         initWithFrame:CGRectMake(0, 10, kScreenWidth, (66+20)*3)];
    [self.contentView addSubview:iconView];
    NSMutableArray *btnMulArr=[NSMutableArray array];
    [_listIcons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALButton *theBtn=[ALButton buttonWithType:UIButtonTypeCustom];
        [theBtn setTag:10000+idx];
        [theBtn setTheBtnClickBlock:^(id sender){
            ALButton *theBtn=sender;
            [btnMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALButton *childBtn=obj;
                if (childBtn.tag==theBtn.tag) {
                    [childBtn setSelected:YES];
                    _typeStr=childBtn.titleLabel.text;
                    _pageNo =1;
                    if (_listClothesArr&&_listClothesArr.count>0) {
                        [_listClothesArr removeAllObjects];
                    }
                    [self _loadFashionSquareAllDataAndBlock:^{
                        [_moreClothesTableView reloadData];
                    }];
                }else{
                    [childBtn setSelected:NO];
                }
            }];
        }];
        [iconView addSubview:theBtn];
        [btnMulArr addObject:theBtn];
        
        NSDictionary *dic=obj;
        
        [theBtn setTitle:dic[@"tit"] forState:UIControlStateNormal];
        [theBtn setImage:[ALImage imageNamed:dic[@"imgUrl_default"]] forState:UIControlStateNormal];
        [theBtn setImage:[ALImage imageNamed:dic[@"imgUrl_hight"]] forState:UIControlStateSelected];
        
        float speWidth=(kScreenWidth-66*4)/5;
        if (idx/4==0) {
            [theBtn setFrame:CGRectMake(66*(idx-4*0)+speWidth*(idx-4*0+1), 0, 66, 66)];
        }else if (idx/4==1){
            [theBtn setFrame:CGRectMake((66)*(idx-4*1)+speWidth*(idx-4*1+1), (66+20)*1, 66, 66)];
        }else if (idx/4==2){
            [theBtn setFrame:CGRectMake((66)*(idx-4*2)+speWidth*(idx-4*2+1), (66+20)*2, 66, 66)];
        }else{
        
        }
        [theBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [theBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [theBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

//        [theBtn setAlignment];
        
        [theBtn.titleLabel setWidth:[ALComAction getSizeByStr:[theBtn titleForState:UIControlStateNormal]
                                                    andFont:theBtn.titleLabel.font].width];
        float width=[ALComAction getSizeByStr:[theBtn titleForState:UIControlStateNormal]
                                andFont:theBtn.titleLabel.font].width;
        
        [theBtn setTitleEdgeInsets:UIEdgeInsetsMake(theBtn.height/3.0f*2+40,
                                                  (theBtn.width-width)/2.0f-theBtn.imageView.width,
                                                  0,
                                                  (theBtn.width-width)/2.0f-theBtn.imageView.width)];
        if(idx==0){
            [theBtn setSelected:YES];
            _typeStr=theBtn.titleLabel.text;
        }
    }];
    
    _moreClothesTableView=[[ALTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.contentView.height)
                                                       style:UITableViewStyleGrouped];
    [_moreClothesTableView setDataSource:self];
    [_moreClothesTableView setDelegate:self];
    [_moreClothesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    __block ALClothesMoreViewController *theBlockCtrl=self;
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
    [self _loadFashionSquareAllDataAndBlock:^{
        [_moreClothesTableView headerEndRefreshing];
        [_moreClothesTableView reloadData];
    }];
}
-(void)foodLoadMore{
    _pageNo+=1;
    [self _loadFashionSquareAllDataAndBlock:^{
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
        else
        {
            [theCell setRightModel:nil];
        }
        
        [theCell setTheBlock:^(NSInteger index){
            ALClothesDetailViewController *theClothesDetailCtrl=[[ALClothesDetailViewController alloc] init];
            if (index==0) {
                ALClothsModel *theModel=_listClothesArr[indexPath.row*2+0];
                [theClothesDetailCtrl setFashionId:theModel.clothsId];
                [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
            }else if (index==1){
                NSInteger indexTmp = indexPath.row*2+1;
                if (indexTmp < _listClothesArr.count)
                {
                    ALClothsModel *theModel=_listClothesArr[indexTmp];
                    [theClothesDetailCtrl setFashionId:theModel.clothsId];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (66+20)*3;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return iconView;
}

#pragma mark loadData
#pragma mark -
-(void)_loadFashionSquareAllDataAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"type":_typeStr,
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
                ALClothsModel *theModel=[ALClothsModel questionWithDict:obj];
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
    [_moreClothesTableView headerEndRefreshing];
    [_moreClothesTableView footerEndRefreshing];
}
@end
