//
//  ALFashionSquareViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALFashionSquareViewController.h"
#import "FFScrollView.h"
#import "ALTestControlViewController.h"
#import "ALUtilities.h"
#import "ALClothesDetailViewController.h"
#import "ALClothesMoreViewController.h"
#import "ALLastNewViewController.h"
#import "ALSearchViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "DataRequest.h"
#import "MGData_KeyFashions.h"
#import "ALMagicBagBuyViewController.h"

#import "ALClothsModel.h"
#import "ALPeriodicalsModel.h"

#import "ALPeriodicalsViewController.h"

#import "ALTableView.h"
#import "ALFashionSquareHeadView.h"
#import "ALClothesTableViewCell.h"
#import "MGUICtrl_Search.h"
#import "MGUI_HotCell.H"
#import "MGUICtrl_ImMG.h"
#import "ALSetTestViewController.h"
#import "ALMagicWardrobeViewController.h"
#import "MGUI_SquareTableViewCell.h"
#import "MGUI_ForYou.h"
#import "MGUI_Popularity.h"
#import "MGUI_Type.h"
#import "MGUI_TypeData.h"
#import "MGUI_MainCell.h"
#import "MGUI_MiniMGBag.h"
#import "ALLoginViewController.h"
#import "ALMagicBagViewController.h"
#import "ALTabBarViewController.h"

@interface ALFashionSquareViewController ()
<FFScrollViewDelegate,
ALTextFiledDelegate,
MagicButtonDelegate,
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate,
UIWebViewDelegate
>
@end

@implementation ALFashionSquareViewController
{
    NSArray *_scrollImgArr;
    NSArray *_actionImgArr;
    NSArray *_actionTitArr;
    
    FFScrollView *topScrollView;
    
    NSMutableArray *_listClothesArr;
    NSMutableArray *_periodicalsArr;
    
    NSInteger _currentPage;
    NSInteger _pageSize;
    BOOL _canLoad; //为YES时，能加载更多
    
    ALTableView *_tableView;
    ALFashionSquareHeadView *theHeadView;
    ALButton *_showTopBtn;
    ALTextField *_txtField;
    ALButton*                   btn_ShowType;
    float                       headTableViewHeight;
    UIView*                     view_Line;
    int current;
    MGUI_Popularity*            view_Popularity;
    MGUI_ForYou*                view_ForYou;
    MGUI_Type*                  view_Type;
    NSMutableArray*             array_B;
    UIView*                     view_TopLine;
    MGUI_TypeData*              view_TypeData;
    NSDictionary*               dict_Im;
    NSMutableArray*             array_Time;
    MGUI_MiniMGBag*             view_Mini;
}
-(void)_loadData
{
    _listClothesArr = [NSMutableArray array];
    _periodicalsArr = [NSMutableArray array];
    _canLoad=YES;
}
-(void)toTopView{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if(current == 0)
    {
        [_tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
    }
    else if(current == 1)
    {
        [view_Popularity toTop];
    }
    else if(current == 2)
    {
        [view_ForYou toTop];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_showTopBtn removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"魔法衣橱"];
    array_Time = [[NSMutableArray alloc]init];
    current = 0;
    __block ALFashionSquareViewController *theCtrl=self;

    [self _initData];
    
    [self _initView];
    [self setViewWithType:rightBtn1_type
                  andView:^(id view) {
                      ALButton *btn=view;
                      [btn setHidden:NO];
                      [btn setImage:[ALImage imageNamed:@"icon006"] forState:UIControlStateNormal];
                  } andBackEvent:^(id sender) {
                      [theCtrl toSearchCtrl];
                  }];
    [self setViewWithType:backBtn_type
                  andView:^(id view) {
                      ALButton *btn=view;
                      [btn setHidden:YES];
                      
                  } andBackEvent:^(id sender) {
                                       }];
//    [self setViewWithType:navigationView_type
//                  andView:^(id view) {
//                  } andBackEvent:^(id sender) {
//                      
//                  }];
    
    [self _loadData];
    view_Mini = [[MGUI_MiniMGBag alloc]initWithFrame:CGRectMake(kScreenWidth*4,0, kScreenWidth, self.contentView.height)];
    [view_Mini setTheBlock:^{
        [theCtrl toLoginAndBlock:^(){
           
        } andObj:theCtrl];
        
    }];
    [view_Mini setTheBlockMove:^(){
    [self.contentView setContentOffset:CGPointMake(320*current, 0) animated:false];
    }];
    UISwipeGestureRecognizer* recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [view_Mini addGestureRecognizer:recognizerLeft];

    [self.contentView addSubview:view_Mini];
    [self.contentView setDelegate:self];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
 //  [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    _showTopBtn = [ALButton buttonWithType:UIButtonTypeCustom];
    _showTopBtn.frame = CGRectMake(kScreenWidth-50, kScreenHeight-100, 40, 40);
    [_showTopBtn setImage:[UIImage imageNamed:@"Top_Arrow.png"] forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow addSubview:_showTopBtn];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_showTopBtn];
    [_showTopBtn addTarget:self
                    action:@selector(toTopView)
          forControlEvents:UIControlEventTouchUpInside];
    
    _showTopBtn.backgroundColor = [UIColor clearColor];
    [_showTopBtn setHidden:YES];
    
    if (_periodicalsArr.count==0)
    {
        [self _loadFashionSquareDataAndBlock:^{
            NSMutableArray *imgMulArr=[NSMutableArray array];
            [_periodicalsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALPeriodicalsModel *theModel=obj;
                [imgMulArr addObject:theModel.mainImage];
            }];
            [theHeadView setTopScrollViews:imgMulArr
                             andActionImgs:@{@"titArr":_actionTitArr,@"imgArr":_actionImgArr}];
            [_tableView reloadData];
        }];
    }
    else
    {
        NSMutableArray *imgMulArr=[NSMutableArray array];
        [_periodicalsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALPeriodicalsModel *theModel=obj;
            [imgMulArr addObject:theModel.mainImage];
        }];
//        [theHeadView setTopScrollViews:imgMulArr
//                         andActionImgs:@{@"titArr":_actionTitArr,@"imgArr":_actionImgArr}];
    }
    [[ALLoginUserManager sharedInstance] checkHasTestAndBlock:^(BOOL hasTest) {
        if (hasTest) {
            headTableViewHeight=FSHeadViewHeight-29;
        }else{
            headTableViewHeight=FSHeadViewHeight-29;
        }
        [theHeadView hideTestBtn:hasTest];
        
        [_tableView reloadData];
    }];
    [_tableView reloadData];
    [view_ForYou reload];
    [view_Mini reload];
    
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

}
-(void)_initData{
    _currentPage=1;
    _actionImgArr=@[@"icon_newest",@"icon_all",@"icon_style",@"icon_magic"];
    _actionTitArr=@[@"上新",@"所有",@"我的风格",@"我是小魔"];
    
    headTableViewHeight=FSHeadViewHeight - 29;
}

- (void)textViewDidCancelEditing:(ALTextField *)textField //点击键盘上的“取消”按钮。
{
    textField.text = @"";
}
- (void)textViewDidFinsihEditing:(ALTextField *)textField //点击键盘框上的"确认"按钮。
{
    [textField resignFirstResponder];
    //    ALSearchViewController *theSearchCtrl=[[ALSearchViewController alloc] init];
    //    [theSearchCtrl setKey:textField.text];
    //    [self.navigationController pushViewController:theSearchCtrl animated:YES];
    [self goToSearchList:textField.text];
    textField.text = @"";
}

#pragma mark - 进入搜索结果列表页


-(void)toSearchCtrl
{
    MGUICtrl_Search *theSearchCtrl = [[MGUICtrl_Search alloc] init];
    [self.navigationController pushViewController:theSearchCtrl animated:YES];
}

- (void)goToSearchList:(NSString *)text
{
    ALSearchViewController *theSearchCtrl=[[ALSearchViewController alloc] init];
    [theSearchCtrl setKey:text];
    [self.navigationController pushViewController:theSearchCtrl animated:YES];
    _txtField.text = @"";
}

#pragma mark -- 人气界面
-(void)ceretePopularity
{
    __block ALFashionSquareViewController *theBlockCtrl=self;
    view_Popularity = [[MGUI_Popularity alloc]init];
    UISwipeGestureRecognizer* recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    UISwipeGestureRecognizer* recognizerR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerR setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [view_Popularity addGestureRecognizer:recognizerLeft];
    [view_Popularity addGestureRecognizer:recognizerR];
    [view_Popularity setTheBlock:^(NSString* keyFashionsId)
    {
        ALClothesDetailViewController *theClothesDetailCtrl=[[ALClothesDetailViewController alloc] init];
        [theClothesDetailCtrl setFashionId:keyFashionsId];
        [theBlockCtrl.navigationController pushViewController:theClothesDetailCtrl animated:YES];
    }];
    [view_Popularity setBlock:^(BOOL isTop){
        if (isTop)
        {
            [theBlockCtrl ->_showTopBtn setHidden:NO];
        }
        else
        {
            [theBlockCtrl ->_showTopBtn setHidden:YES];
        }
    }];
    [self.contentView addSubview:view_Popularity];
    view_Popularity.backgroundColor = [UIColor clearColor];
    view_Popularity.frame = CGRectMake(kScreenWidth,0, kScreenWidth, self.contentView.height);
}

#pragma mark --  分类界面
-(void)createType
{
    __block ALFashionSquareViewController *theBlockCtrl=self;
    

    view_Type = [[MGUI_Type alloc]initWithFrame:CGRectMake(kScreenWidth*3,0, kScreenWidth, self.contentView.height)];
    [view_Type setTheblock:^(NSString* fId)
     {
         ALClothesDetailViewController *theClothesDetailCtrl = [[ALClothesDetailViewController alloc] init];
          [theClothesDetailCtrl setFashionId:fId];
         [theBlockCtrl.navigationController pushViewController:theClothesDetailCtrl animated:YES];
     }];
    UISwipeGestureRecognizer* recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionRight)];
    UISwipeGestureRecognizer* recognizerR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerR setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [view_Type addGestureRecognizer:recognizerLeft];
    [view_Type addGestureRecognizer:recognizerR];
   
    [self.contentView addSubview:view_Type];
    
}
#pragma mark --  为你精选 界面
-(void)createForYou
{
    __block ALFashionSquareViewController *theBlockCtrl=self;
    view_ForYou = [[MGUI_ForYou alloc]initWithFrame:CGRectMake(kScreenWidth*2,0, kScreenWidth, self.contentView.height)];
    view_ForYou.userInteractionEnabled = true;
    UISwipeGestureRecognizer* recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    UISwipeGestureRecognizer* recognizerR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerR setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [view_ForYou addGestureRecognizer:recognizerLeft];
    [view_ForYou addGestureRecognizer:recognizerR];
    [view_ForYou setFirstBlock:^{
    
        ALTestControlViewController *theChildCtrl=[[ALTestControlViewController alloc] init];
        __block ALTestControlViewController *theChildCrtSelf = theChildCtrl;
        [theChildCtrl setTheBackBlock:^(id sender){
            if ([[ALLoginUserManager sharedInstance] loginCheck])
            {
                [theBlockCtrl -> view_ForYou reload];
                [theChildCrtSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [theBlockCtrl toLoginAndBlock:^{
                     [theChildCrtSelf.navigationController popViewControllerAnimated:YES];
                } andObj:theBlockCtrl];
            }
        }];
        [theBlockCtrl.navigationController pushViewController:theChildCtrl animated:YES];
    }];
    
    
    [view_ForYou setTheBlock:^{
        ALTestControlViewController *theChildCtrl=[[ALTestControlViewController alloc] init];
        [theBlockCtrl.navigationController pushViewController:theChildCtrl animated:YES];
        [theChildCtrl setTheBackBlock:^(id sender){
            [theBlockCtrl ->view_ForYou reload];
            [theBlockCtrl.navigationController popViewControllerAnimated:YES];
        }];
    }];
    [view_ForYou setTheViewBlock:^(NSString* keyFashionsId)
     {
         ALClothesDetailViewController *theClothesDetailCtrl=[[ALClothesDetailViewController alloc] init];
         [theClothesDetailCtrl setFashionId:keyFashionsId];
         [theBlockCtrl.navigationController pushViewController:theClothesDetailCtrl animated:YES];
     }];
    [view_ForYou setBlock:^(BOOL isTop){
        if (isTop)
        {
            [theBlockCtrl ->_showTopBtn setHidden:NO];
        }
        else
        {
            [theBlockCtrl ->_showTopBtn setHidden:YES];
        }
    }];
    
    
     [self.contentView addSubview:view_ForYou];
    
}
#pragma mark --  初始化View
-(void)_initView{

    NSArray* array_Btn =  [NSArray arrayWithObjects:@"上新",@"人气",@"为你精选",@"分类",@"免费试用",nil];
    array_B = [[NSMutableArray alloc]init];
    __block ALFashionSquareViewController* theBlockCtrl = self;
    [array_Btn enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
         CGFloat btnSpaceWidth = kScreenWidth/5;
         [array_B addObject:btn];
         [btn setFrame:CGRectMake(idx * btnSpaceWidth ,0,btnSpaceWidth,35)];
         [btn setTitle:array_Btn[idx] forState:UIControlStateNormal];
         [btn setTitleColor:ALUIColorFromHex(0x92887c) forState:UIControlStateNormal];
         [btn setTitleColor:ALUIColorFromHex(0xa07845) forState:UIControlStateSelected];
         if (idx == 0)
         {
             btn.selected = true;
         }
         [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
         btn.index = idx;
         [btn setTag:idx+10000];
         [btn setTheBtnClickBlock:^(id sender)
         {
             [theBlockCtrl ->_showTopBtn setHidden:YES];
             ALButton *theBtn=sender;
             
             if (theBtn.tag==0+10000)
             {
                 current = 0;
                 
             }
             else if (theBtn.tag==1+10000)
             {
                 current = 1;
                 
             }
             else if (theBtn.tag==2+10000)
             {
                 current = 2;
     
             }
             else if (theBtn.tag==3+10000)
             {
                 current = 3;
             
             }
             else
             {
                 current = 4;
             }
             [array_B enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                 ALButton* btn = obj;
                 btn.selected = false;
             }];
             theBtn.selected = true;
             [UIView animateWithDuration:0.3 animations:^{
                view_Line.frame = CGRectMake(kScreenWidth/5*current, 34, kScreenWidth/5, 1);
                [self.contentView setContentOffset:CGPointMake(320*current, 0) animated:true];
             } completion:^(BOOL finished) {
                 
             }];
             
         }];
         [self.view_Top addSubview:btn];
     }];
    //__block ALFashionSquareViewController *theBlockCtrl = self;
    btn_ShowType = [[ALButton alloc]init];
    [btn_ShowType setTheBtnClickBlock:^(id sender)
     {
         [theBlockCtrl -> view_Type showChoose];
         [UIView animateWithDuration:0.3 animations:^{
              self.view_Top.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, 35);
       
         }];
         
       
     }];
    
    self.view_Top.hidden = false;
    view_TopLine = [[UIView alloc]init];
    view_TopLine.backgroundColor = ALUIColorFromHex(0xdedede);
    view_TopLine.frame = CGRectMake(0, 35, kScreenWidth*2, 0.5);
    [self.view_Top addSubview:view_TopLine];
    view_Line = [[UIView alloc]init];
    view_Line.backgroundColor = ALUIColorFromHex(0xa07845);
    [self.view_Top addSubview:view_Line];
    view_Line.frame = CGRectMake(0, 34.5, kScreenWidth/5, 1);
    //self.contentView.backgroundColor = AL_RGB(240,236,233);
    theHeadView=[[ALFashionSquareHeadView alloc]
                 initWithFrame:CGRectMake(0, 0, kScreenWidth, FSHeadViewHeight)
                 andDelegate:self];
    theHeadView.delegate = self;
   self.contentView.frame = CGRectMake(0, kNavigationBarHeight+35 , kScreenWidth, self.contentView.height - 35 );
    self.contentView.scrollEnabled = false;
    _tableView=[[ALTableView alloc]
                initWithFrame:CGRectMake(0, 0, kScreenWidth, self.contentView.height) style:UITableViewStyleGrouped];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView addHeaderWithTarget:self action:@selector(headViewLoad)];
    [_tableView addFooterWithTarget:self action:@selector(foodViewLoad)];

    [self.contentView addSubview:_tableView];
    self.contentView.contentSize = CGSizeMake(kScreenWidth*5, self.contentView.height);
    
   UISwipeGestureRecognizer* recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    UISwipeGestureRecognizer* recognizerR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerR setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_tableView addGestureRecognizer:recognizerR];
  //  [_tableView headerBeginRefreshing];
    UIColor *backColor =  colorByStr(@"#F0ECE9");
  //  theHeadView.backgroundColor = backColor;
    _tableView.backgroundColor = backColor;
    self.contentView.backgroundColor = backColor;
    [self ceretePopularity];
    [self createForYou];
    [self createType];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
 if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft)
 {
     if (current < 5)
     {
         current += 1;
     }
 }
    else
    {
        if(current >= 1)
        {
        current -= 1;
        }
    }
    
    
    [array_B enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALButton* btn = obj;
        if(btn.tag - 10000 == current)
        {
            btn.selected = true;
            [UIView animateWithDuration:0.3 animations:^{
                view_Line.frame = CGRectMake(kScreenWidth/5*current, 34, kScreenWidth/5, 1);
                [self.contentView setContentOffset:CGPointMake(320*current, 0) animated:true];
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
        btn.selected = false;
        }
        
    }];
    
//    [array_B enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        ALButton* btn = obj;
//        btn.selected = false;
//
//    if (theBtn.tag==0+10000)
//    {
//        current = 0;
//        
//    }
//    else if (theBtn.tag==1+10000)
//    {
//        current = 1;
//        
//    }
//    else if (theBtn.tag==2+10000)
//    {
//        current = 2;
//        
//    }
//    else if (theBtn.tag==3+10000)
//    {
//        current = 3;
//        
//    }
//    else
//    {
//        current = 4;
//    }
//   
//    }];
//    theBtn.selected = true;
  
  

      [self.contentView setContentOffset:CGPointMake(current*320, 0) animated:true];
}
#pragma mark -- 下拉刷新
-(void)headViewLoad{
    _currentPage=1;
    [self _loadFashionSquareDataAndBlock:^{
        [_tableView headerEndRefreshing];
        [_tableView reloadData];
    }];
}
#pragma mark -- 上拉加载
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

#pragma mark 首次显示
#pragma mark --
-(void)_firstShowAndBlock:(void(^)())theBlock{
    ALComView *bgView=[[ALComView alloc]
                       initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [bgView setAlpha:.3f];
    [bgView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:bgView];
    
    ALImageView *imgView=[[ALImageView alloc]
                          initWithFrame:CGRectMake((kScreenWidth-247)/2, (kScreenHeight-152)/2, 247, 152)];
    [imgView setImage:[ALImage imageNamed:@"Magic_Welcome_"]];
    [imgView setUserInteractionEnabled:YES];
    __block ALFashionSquareViewController *theBlockCtrl=self;
    [imgView setTheImageVimageTouchuBlock:^(id sender){
        ALTestControlViewController *viewController = [[ALTestControlViewController alloc] init];
        [theBlockCtrl.navigationController pushViewController:viewController animated:YES];
        [bgView removeFromSuperview];
        [imgView removeFromSuperview];
        if (theBlock) {
            theBlock();
        }
        __block ALTestControlViewController * selfBlock = viewController;
        [viewController setTheBackBlock:^(id sender){
            if ([[ALLoginUserManager sharedInstance] loginCheck]) {
                [selfBlock.navigationController popViewControllerAnimated:YES];
            }else{
                [theBlockCtrl toLoginAndBlock:^{
                    [selfBlock reTestRequestAndBlock:^{
                        [self afterAction:^{
                            [selfBlock.navigationController popViewControllerAnimated:YES];
                        } afterVal:.5f];
                    }];
                } andObj:theBlockCtrl];
            }
        }];
    }];
    [self.view addSubview:imgView];
    
    //[ALImage imageNamed:@"icon017"]
    ALButton *delBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [delBtn setFrame:CGRectMake(imgView.width-30, imgView.height-30, 30, 30)];
    [delBtn setImage:nil forState:UIControlStateNormal];
    [delBtn setTheBtnClickBlock:^(id sender){
        [bgView removeFromSuperview];
        [imgView removeFromSuperview];
        if (theBlock) {
            theBlock();
        }
    }];
    [imgView addSubview:delBtn];
    
    //    AppDelegate *theDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
}
#pragma mark datasource and Delegate
#pragma mark -

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listClothesArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *clothesIdentify= @"clothesIdentifyssss";
    MGUI_MainCell *theCell=[tableView dequeueReusableCellWithIdentifier:clothesIdentify];
    if (theCell==nil)
    {
        theCell=[[MGUI_MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clothesIdentify];
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    theCell.backgroundColor = AL_RGB(240,236,233);
    theCell.contentView.backgroundColor = AL_RGB(240,236,233);
    [theCell setModel:_listClothesArr[indexPath.row]];
    if(indexPath.row == 0)
    {
        [theCell setTime];
        NSMutableDictionary* dict = array_Time[indexPath.row];
        dict[@"height"] = [NSString stringWithFormat:@"%d",370];

    }
    else
    {
        MGData_KeyFashions* modelB = _listClothesArr[indexPath.row -1];
        MGData_KeyFashions* model = _listClothesArr[indexPath.row];
        
        NSDate *dateB = [NSDate dateWithTimeIntervalSince1970: [modelB.saleTime doubleValue]/1000];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970: [model.saleTime doubleValue]/1000];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM月dd日"];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit |NSMonthCalendarUnit |NSDayCalendarUnit |NSWeekdayCalendarUnit |NSHourCalendarUnit |
        NSMinuteCalendarUnit |NSSecondCalendarUnit;
        NSDateComponents *compsB = [[NSDateComponents alloc] init];
        //int week=0;
        compsB = [calendar components:unitFlags fromDate:dateB];
        comps = [calendar components:unitFlags fromDate:date];
        int month = (int)[comps month];
        int day = (int)[comps day];
        int monthb = (int)[compsB month];
        int dayb = (int)[compsB day];
        if (month != monthb || dayb!=day )
        {
            NSMutableDictionary* dict = array_Time[indexPath.row];
            dict[@"height"] = [NSString stringWithFormat:@"%d",370];
            [theCell setTime];
        }
        // [theCell setTime];
    }
    return theCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    float height =  [array_Time[indexPath.row][@"height"]floatValue];
    return height;
}
//分区为一个， 区头高为轮播图高 - 30
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headTableViewHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return theHeadView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALClothesDetailViewController *theClothesDetailCtrl=[[ALClothesDetailViewController alloc] init];
    MGData_KeyFashions *theModel=_listClothesArr[indexPath.row];
    [theClothesDetailCtrl setFashionId:theModel.keyFashionsId];
    [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
}

#pragma mark --  FFScrollView - 轮播图代理方法
- (void)scrollViewDidClickedAtPage:(NSInteger)pageNumber{
    if (_periodicalsArr.count>pageNumber) {
        ALPeriodicalsViewController *theCtrl=[[ALPeriodicalsViewController alloc] init];
        ALPeriodicalsModel *theModel=_periodicalsArr[pageNumber];
        [theCtrl setPeriodicalsId:theModel.periodicalsId];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }
}

#pragma mark -- 领取魔法包点击方法
- (void)doclickMagicButtonAction
{
    typeof(self) aSelf = self;
    if (![[ALLoginUserManager sharedInstance] loginCheck]) {
        ALLoginViewController *loginController = [[ALLoginViewController alloc] init];
        [aSelf.navigationController pushViewController:loginController animated:YES];
    } else if ([[ALLoginUserManager sharedInstance] loginCheck]){
        [view_Mini _loadIsBuyDataAndBlock:^{
            if ([view_Mini.isBuy isEqualToString:@"Y"]) { //已购买
                ALTabBarViewController *tabBarVC = [ALTabBarViewController shareALTabBarVC];
                [tabBarVC selectTabIndex:2];
            } else {
                ALMagicBagBuyViewController *bagBuyController = [[ALMagicBagBuyViewController alloc] init];
                [aSelf.navigationController pushViewController:bagBuyController animated:YES];
            }
        }];
    }
}


#pragma mark loadData
#pragma mark -

-(void)_loadGetSysConfigAndBlock:(void(^)())theBlock
{
    NSDictionary *sendDic=@{@"configKey":@"xiaomourl"};
    [DataRequest requestApiName:@"fashionSquare_SysCongfig"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       @try {
                           @try {
                               //configdesc   configvalue
                               dict_Im=sucContent[@"body"][@"result"];
                               // array_MostS = arr;
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
                       if (theBlock)
                       {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
    
    
}


//加载潮流广场首页数据
-(void)_loadFashionSquareDataAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"pageNo":@(_currentPage),
                            @"pageSize":@"10"
                            };
    [DataRequest requestApiName:@"fashionSquare_fashionSquareNewData"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       if (_currentPage==1) {
                           [_listClothesArr removeAllObjects];
                           [array_Time removeAllObjects];
                       }
                       @try {
                           NSArray *clothsArr=sucContent[@"body"][@"result"][@"fashions"];
                           if (!clothsArr.count>0) {
                               _canLoad=NO;
                           }else{
                               _canLoad=YES;
                           }
                           NSArray *periodicalsArr=sucContent[@"body"][@"result"][@"periodicals"];
                           if (clothsArr) {
                               [clothsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                   MGData_KeyFashions *theModel=[MGData_KeyFashions questionWithDict:obj];
                                   [_listClothesArr addObject:theModel];
                               }];
                           }
                           [_listClothesArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                               if (idx > array_Time.count - 1 || array_Time.count  == 0)
                               {
                                   NSMutableDictionary*dict = [[NSMutableDictionary alloc]init];
                                   dict[@"row"] =[NSString stringWithFormat:@"%d",(int)idx];
                                   dict[@"height"] =[NSString stringWithFormat:@"%d",345];
                                   [array_Time addObject:dict];
                               }
                              
                           }];
                           
                           if (periodicalsArr && _currentPage==1 && _periodicalsArr.count==0)
                           {
                               [periodicalsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                   ALPeriodicalsModel *theModel=[ALPeriodicalsModel questionWithDict:obj];
                                   [_periodicalsArr addObject:theModel];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   //     [self.contentView setContentOffset:CGPointMake(320*current, 0) animated:true];
    NSInteger curPage=scrollView.contentOffset.y/scrollView.height;
    if (curPage>=2) {
        [_showTopBtn setHidden:NO];
    }else{
        [_showTopBtn setHidden:YES];
    }
}

@end
