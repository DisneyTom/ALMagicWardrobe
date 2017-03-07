//
//  MGUI_ForYou.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/12.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUI_ForYou.h"
#import "ALLoginUserManager.h"
#import "DataRequest.h"
#import "MGData_KeyFashions.h"
#import "MGUI_SquareTableViewCell.h"
#import "ALMagicWardrobeFirstEnterView.h"

@interface MGUI_ForYou()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MGUI_ForYou
{
    ALComView *theRecommentView;
    int _pageNo;
    NSMutableArray* _listClothesArr;
    NSInteger _pageSize;
    ALTableView* _tableView;
    BOOL _canLoad; //为YES时，能加载更多
    ALComView*  theFirst;
    UIScrollView* scrollView_Fo;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    _listClothesArr = [[NSMutableArray alloc]init];
    _pageNo = 1;
    _tableView=[[ALTableView alloc]
                initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView addHeaderWithTarget:self action:@selector(headViewLoad)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.hidden = true;
    
    scrollView_Fo = [[UIScrollView alloc]init];
    theRecommentView = [[ALComView alloc]init];
    theRecommentView = [self _createRecommendView];
    theRecommentView.frame = self.bounds;
    [scrollView_Fo addSubview:theRecommentView];
    scrollView_Fo.frame = self.bounds;
    scrollView_Fo.hidden = true;
    scrollView_Fo.contentSize = CGSizeMake(self.width, self.height+ 90);
    theFirst = [self loadFisrtViewAndBlock:^{}];
    
      [scrollView_Fo addSubview:theRecommentView];
    [self addSubview:_tableView];
    [self addSubview:scrollView_Fo];
    [scrollView_Fo addSubview:theFirst];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
    return self;
}
-(void)reload
{
    if ([[ALLoginUserManager sharedInstance] loginCheck])
    {
        [[ALLoginUserManager sharedInstance] getUserInfo:filterStr([[ALLoginUserManager sharedInstance] getUserId])
                                                 andBack:^(ALUserDetailModel *theUserDetailInfo) {
                                                     NSDictionary *sendDic=@{
                                                                             @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                                                                             };
                                                     [DataRequest requestApiName:@"userCenter_getUserCenterData"
                                                                       andParams:sendDic
                                                                       andMethod:Post_type
                                                                    successBlcok:^(id sucContent) {
                                                                        theFirst.hidden = true;
                                                                        if (sucContent[@"body"][@"result"][@"user"][@"testResult"]&&[sucContent[@"body"][@"result"][@"user"][@"testResult"] length]>0)
                                                                        { //已经测试
                                                                              _tableView.hidden = false;
                                                                            
                                                                            theRecommentView.hidden = true;
                                                                            scrollView_Fo.hidden = true;
                                                                            [self _loadFashionRecommendDataAndBlock:^{
                                                                              [_tableView reloadData];
                                                                            }];
                                                                              scrollView_Fo.contentSize = CGSizeMake(self.width, self.height + 90);
                                                                        }
                                                                        else
                                                                        {
                                                                            scrollView_Fo.hidden = false;
                                                                            _tableView.hidden = true;
                                                                            theRecommentView.hidden = false;
                                                                            scrollView_Fo.contentSize = CGSizeMake(self.width, theRecommentView.bottom + 90);
                                                                          
                                                                        }
                                                                    } failedBlock:^(id failContent) {
                                                                        showFail(failContent);
                                                                    } reloginBlock:^(id reloginContent) {
                                                                    }];
                                                 } andReLoad:YES];
    }
    else
    {
        theRecommentView.hidden = true;
         _tableView.hidden = true;
        theFirst.hidden = false;
        scrollView_Fo.hidden = false;
       scrollView_Fo.contentSize = CGSizeMake(self.width, scrollView_Fo.bottom + 90);
    }
  

}


-(ALComView *)loadFisrtViewAndBlock:(void(^)())theFinish{
    
    __block ALMagicWardrobeFirstEnterView *theView=[[ALMagicWardrobeFirstEnterView alloc]
                                                    initWithFrame:CGRectMake(0,
                                                                             - 30,
                                                                             kScreenWidth,
                                                                             self.height)    andBackBlock:^(id sender) {
                                                        if (self.firstBlock)
                                                        {
                                                            self.firstBlock();
                                                        }
                                                    }];
    
    return theView;
}


-(void)headViewLoad{
    _pageNo=1;
    [self _loadFashionRecommendDataAndBlock:^{
        [_tableView headerEndRefreshing];
        [_tableView reloadData];
    }];
}
//-(void)foodViewLoad{
//    if (_canLoad) {
//        _pageNo++;
//        [self _loadFashionRecommendDataAndBlock:^{
//            [_tableView footerEndRefreshing];
//            [_tableView reloadData];
//        }];
//    }else{
//        [_tableView footerEndRefreshing];
//    }
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _tableView.frame = self.bounds;
}
-(ALComView *)_createRecommendView{
    float _orginY = 0;
    NSArray *imgArr=@[
                      [ALImage imageNamed:@"Test_Day_.jpg"],
                      [ALImage imageNamed:@"Test_England_.jpg"],
                      [ALImage imageNamed:@"Test_Exercise_.jpg"],
                      [ALImage imageNamed:@"Test_Goddess_.jpg"],
                      [ALImage imageNamed:@"Test_OL_.jpg"],
                      [ALImage imageNamed:@"Test_Personality_.jpg"]
                      ];
    int randomNum = arc4random()%4;
    ALComView *theView=[[ALComView alloc]
                        initWithFrame:CGRectMake(15, _orginY+10,
                                                 kScreenWidth-30,
                                                 self.height-_orginY-15)];
    ALImageView *imgView=[[ALImageView alloc]
                          initWithFrame:CGRectMake((kScreenWidth - theView.width)/2 ,
                                                   1, theView.width,370)];
    [imgView setImage:imgArr[randomNum]];
    [theView addSubview:imgView];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *guestTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unLoginTest)];
    [imgView addGestureRecognizer:guestTap1];
    
    
    
    ALImageView *smallImgView=[[ALImageView alloc]
                               initWithFrame:CGRectMake(imgView.width-92/2-10, imgView.height-57/2-10, 92/2, 57/2)];
    [smallImgView setImage:[ALImage imageNamed:@"Examination_Arrow_"]];
    [imgView addSubview:smallImgView];
    smallImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *guestTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unLoginTest)];
    [smallImgView addGestureRecognizer:guestTap];
    
    ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(imgView.left, imgView.bottom, imgView.width, 35)];
    [btn setBackgroundImage:[ALImage imageNamed:@"picture_bottom"] forState:UIControlStateNormal];
    [btn setTitle:@"这是你的风格吗？参与着装测试，时尚也要精选" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btn setTheBtnClickBlock:^(id sender){
        [self unLoginTest];
    }];
    [theView addSubview:btn];
    [theView setHeight:btn.bottom];

    return theView;
}
- (void)unLoginTest
{
    if (self.theBlock)
    {
        self.theBlock();
    }

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
    if (_listClothesArr.count > 0)
    {
        [theCell setModel:_listClothesArr[indexPath.row]];
    }
    
    
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
    if (_listClothesArr.count == 0)
    {
        return;
    }
    MGData_KeyFashions* mode = _listClothesArr[indexPath.row];
    if (self.theViewBlock)
    {
        self.theViewBlock(mode.keyFashionsId);
    }
}
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
        if (self.block)
        {
            self.block(true);
        }
    }else{
        if (self.block)
        {
            self.block(false);
        }
    }
}
#pragma mark loadData
#pragma mark -
-(void)_loadFashionRecommendDataAndBlock:(void(^)())theBlock{
    if (_pageNo==1) {
        [_listClothesArr removeAllObjects];
    }
    if ([filterStr([[ALLoginUserManager sharedInstance] getUserId] ) isEqualToString:@""])
    {
        return;
    }
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"fashionSquare_fashionRecommendData"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       NSArray *tempArr=sucContent[@"body"][@"result"];
                       if (!tempArr.count>0) {
                           _canLoad=NO;
                       }else{
                           _canLoad=YES;
                       }
                       [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                           MGData_KeyFashions *theModel=[MGData_KeyFashions questionWithDict:obj];
                           [_listClothesArr addObject:theModel];
                       }];
                      
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
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
}
@end
