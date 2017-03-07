//
//  ALMagicWardrobeViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicWardrobeViewController.h"
#import "CustomSegmentedControl.h"
#import "ALUtilities.h"
#import "ALMagicWardrobeCollectionViewCell.h"
#import "ALClothesDetailViewController.h"
#import "ALTestControlViewController.h"
#import "ALMyMagicWardrobeViewController.h"
#import "ALMagicWardrobeFirstEnterView.h"
#import "ALClothsModel.h"
//#import "AFNconnectionImport.h"
#import "ALLoginViewController.h"
#import "ALSetTestViewController.h"
#import "ALMyMWTableViewCell.h"
#import "ALMyBasketCollectionViewCell.h"
#import "ALLine.h"
#import "ALMagicBagFirstEnterView.h"

@interface CustFlowLayout : UICollectionViewFlowLayout


@end
@implementation CustFlowLayout
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for(int i = 1; i < [attributes count]; ++i) {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        //我们想设置的最大间距，可根据需要改
        NSInteger maximumSpacing = 8;
        //前一个cell的最右边
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
        return  attributes;
}
@end

@interface ALMagicWardrobeViewController ()
<
UITableViewDataSource,
UITableViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>
@end

@implementation ALMagicWardrobeViewController
{
    float _orginY;
    ALComView *theMyCloseListView;
    ALComView *theRecommentView;
    int _pageNo;
    int _rightBtnX;
    int _rightBtnWidth;
    ALLabel *_showLabel;
    NSString *_type;
    ALImageView *headImgView;
    ALTableView *_myMWTableView;
    UIImageView *leftGressImgView;
    UIImageView *rightTopGressImgView;
    UIImageView *rightBottomGressImgView;
    UILabel *_leftTopCountLbl;
    UIImageView *_leftTopImg;
    UILabel *_rightTopCountLbl;
    UIImageView *_rightTopImg;
    UILabel *_rightBtmCountLbl;
    UIImageView *_rightBtmImg;
    UIScrollView*                             view_UnLogin;
    UILabel* lbl_Tag;
    UIView*                             view_Pop;
    UILabel*                            lbl_AlertPrompt;
    UIView*                             view_Alert;
    UIView*                             view_AlertTop;
    UIButton*                           btn_Cancel;
    UIButton*                           btn_Decide;
    NSString*                           string_MwColothsId;
    UIView*                             view_Middle;
    UIButton*                           btn_YC;
    UIButton*                           btn_FYL;
    UIView*                             view_BtnLine;
    ALComView*                          view_Top;
    NSMutableArray*                     _listClothesArr;
    NSString *                          CellIdentifier;
    NSMutableArray *                    _listClothesArrBR;
    UICollectionView *                  _collectView;
    int _pageNoB;
    BOOL isLeft;
    BOOL _isEdit;
    BOOL haveNone;
    BOOL isEnough;
    UIView*      view_Load;
    UIImageView* img_Load;
    UIImageView* imgView_Search;
    UIView* view_TopLine;
    BOOL isBottom;
    BOOL isFirst;
    ALLabel* showLabel;
}

@synthesize string_Title;
- (void)viewDidLoad
{
    UIColor *color = colorByStr(@"#75491F");
    isFirst = true;
    isLeft = true;
    showLabel  = [[ALLabel alloc]
                   initWithFrame:CGRectMake(15, 270, kScreenWidth-30, 50)];
    showLabel.backgroundColor = [UIColor clearColor];
    showLabel.font = [UIFont systemFontOfSize:14.f];
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.text = @"这个衣橱是空的,这样是生成不了魔法包的呢";
    showLabel.numberOfLines = 2;
    showLabel.textColor = color;
    showLabel.layer.borderColor =color.CGColor;
    showLabel.layer.borderWidth = 1;
    showLabel.layer.masksToBounds = YES;
    showLabel.layer.cornerRadius = 2;
    [super viewDidLoad];
    if (string_Title) {
        string_Title = @"着装测试";
    }
    else
    {
         string_Title = @"魔法衣橱";
    }
    [self setTitle:string_Title];
    _pageNo =1;
    _pageNoB = 1;
    _isEdit = NO;
    [self _initData];
    [self _initView];
    _type = @"全身";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    view_BtnLine.center = CGPointMake(btn_YC.center.x, btn_YC.center.y + 13);
    lbl_Tag.hidden = true;
    view_UnLogin.hidden = false;
 
//     __block ALMagicWardrobeViewController *blockSelf  = self;
    if ([[ALLoginUserManager sharedInstance] loginCheck])
    {
        _myMWTableView.hidden = false;
        view_UnLogin.hidden = true;
        [self test1:nil];
        [[ALLoginUserManager sharedInstance]
         getUserInfo:[[ALLoginUserManager sharedInstance] getUserId]
         andBack:^(ALUserDetailModel *theUserDetailInfo)
        {
            hideRequest;
            view_Top.hidden = false;
                _pageNo=1;
            if (isFirst)
            {
                [self _loadMyWardrobeDataAndBlock:^{
                    
                    [_myMWTableView reloadData];
                }];
            }
            
            [self _headLoadMore];
            view_Top.hidden = false;
            _collectView.hidden = false;
            view_TopLine.hidden = false;
        } andReLoad:YES];
        
        
        [self setViewWithType:rightBtn1_type
                      andView:^(id view) {
                          ALButton *btn=view;
                          [btn setHidden:NO];
                          [btn setTitle:@"清空" forState:0];
                          btn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
                          [btn setTitleColor:colorByStr(@"#907948") forState:0];
                      } andBackEvent:^(id sender) {
                          view_Load.hidden = true;
                          [btn_Decide setTitle:@"确定" forState:0];
                          view_Middle.hidden = false;
                          lbl_AlertPrompt.text = @"确认清空吗?(操作不可逆)\n";
                          view_Pop.hidden = false;
                          btn_Cancel.hidden = false;
                          btn_Cancel.frame = CGRectMake((kScreenWidth - 40)/2,100, (kScreenWidth - 40)/2, 40);
                          btn_Decide.frame = CGRectMake(0,  100, (kScreenWidth - 40)/2, 40);
                      }];
        [self setViewWithType:backBtn_type
                      andView:^(id view) {
                          ALButton *btn=view;
                          [btn setImage:nil forState:UIControlStateNormal];
                          btn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
                          [btn setHidden:NO];
                          [btn setTitle:@"我要魔法包" forState:0];
                          [btn setTitleColor:colorByStr(@"#907948") forState:0];
                          
                      } andBackEvent:^(id sender)
         {
             view_Middle.hidden = true;
             lbl_AlertPrompt.text = [NSString stringWithFormat:@"扫描结果出来了\n\n*衣橱满20件衣服.................%@\n*三个柜子都不为空..............%@\n",isEnough?@"√":@"×",haveNone?@"√":@"×"] ;
             if (isEnough && haveNone)
             {
                  lbl_AlertPrompt.text = @"扫描结果出来了~\n\n已经满足启动魔法包的条件了,\n快去“魔法包”里启动它吧！\n";
             }
             
             view_Pop.hidden = false;
             view_Alert.hidden = true;
             view_Load.hidden = false;
             img_Load.frame = CGRectMake(1, 0, 1, 8);
             
             CGRect boundingRect = CGRectMake(-10,-25, 30, 30);
             CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
             orbit.keyPath = @"position";
             orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
             orbit.duration = 1;
             orbit.additive = YES;
             orbit.repeatCount = HUGE_VALF;
             orbit.calculationMode = kCAAnimationPaced;
             orbit.rotationMode = /*kCAAnimationRotateAuto*/ nil;
             
             [imgView_Search.layer addAnimation:orbit forKey:@"ani-track"];
             
             [UIView animateWithDuration:2.5 animations:^{
                 
                 img_Load.frame = CGRectMake(1, 0, 237, 8);
             } completion:^(BOOL finished) {
                 view_Alert.hidden = false;
                 if (!isEnough || !haveNone)
                 {
                     [btn_Decide setTitle:@"去填满衣橱" forState:0];
                 }
                 else
                 {
                     [btn_Decide setTitle:@"确定" forState:0];
                 }
                 btn_Decide.frame = CGRectMake(0,  100, kScreenWidth - 40, 40);
                 btn_Cancel.hidden = true;
                 view_Load.hidden = true;
                 // [selfBlocke gotoSeeDetaiMessage];
             }];
             
         }];
    }
    else{
        
            view_UnLogin.hidden = false;
            view_Top.hidden = true;
            _myMWTableView.hidden = true;
            view_TopLine.hidden = true;
            _collectView.hidden = true;
        [self setViewWithType:rightBtn1_type
                      andView:^(id view) {
                          ALButton *btn=view;
                          [btn setHidden:true];
                          [btn setTitle:@"清空" forState:0];
                          btn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
                          [btn setTitleColor:colorByStr(@"#907948") forState:0];
                      } andBackEvent:^(id sender) {
                
                      }];
    }

}



-(void)_initData{
     CellIdentifier = @"ALMyBasketCollectionViewCell";
    _listClothesArr=[[NSMutableArray alloc] initWithCapacity:2];
    _listClothesArrBR=[[NSMutableArray alloc] initWithCapacity:2];
}
-(void)create
{
    ALImageView *imgView=[[ALImageView alloc]
                          initWithFrame:CGRectMake(35/2,
                                                   82/2,
                                                   kScreenWidth-35/2-35/2,
                                                   620/2)];
    [imgView setImage:[ALImage imageNamed:@"finish_bg"]];
    [view_UnLogin addSubview:imgView];
    
    ALLabel *titLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(54/2, 20, imgView.width-54/2*2, 20)
                     andColor:AL_RGB(124,84,1)
                     andFontNum:13];
    [titLbl setText:@"创建属于你的云端衣橱"];
    [titLbl setFont:[UIFont systemFontOfSize:13]];
    [titLbl setTextColor:colorByStr(@"#9B7D56")];
    
    [imgView addSubview:titLbl];
    
    ALLabel *subTitLbl=[[ALLabel alloc]
                        initWithFrame:CGRectMake(titLbl.left, titLbl.bottom, titLbl.width, 20)
                        andColor:AL_RGB(124,84,1)
                        andFontNum:13];
    [subTitLbl setText:@"每月不限次不限时领取魔法包"];
    [subTitLbl setFont:[UIFont systemFontOfSize:13]];
    [subTitLbl setTextColor:colorByStr(@"#9B7D56")];
    [imgView addSubview:subTitLbl];
    
    ALImageView *lineImgView=[[ALImageView alloc]
                              initWithFrame:CGRectMake(0,
                                                       164/2,
                                                       imgView.width,
                                                       6)];
    [lineImgView setImage:[ALImage imageNamed:@"halving_line"]];
    [imgView addSubview:lineImgView];
    
    NSArray *arr=@[
                   @"快把喜爱的衣服装入你的私人衣橱",
                   @"距离收到漂亮衣服只有一步之遥",
                   @"还不赶快加入我们！",
                   ];
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSUInteger index = idx;
            if (idx > 2)
            {
                index = index - 1;
            }
            CGFloat space = 5.f;
            if (idx != 3)
            {
                space = 1.f;
            }
            ALLabel *lbl=[[ALLabel alloc]
                            initWithFrame:CGRectMake(30, lineImgView.bottom+30*index+space*index, imgView.width - 60, 50)];
            lbl.text = obj;
            [lbl setFont:[UIFont systemFontOfSize:11]];
            [lbl setNumberOfLines:0];
            [lbl setTextColor:AL_RGB(64, 64, 64)];
            [imgView addSubview:lbl];
        
    }];
    
    ALLine *line=[[ALLine alloc]
                  initWithFrame:CGRectMake(0, 504/2, imgView.width, 1)];
    [imgView addSubview:line];
    
    ALLabel *bottomLbl=[[ALLabel alloc]
                        initWithFrame:CGRectMake(30,
                                                 line.bottom+5,
                                                 imgView.width - 30,
                                                 30)
                        andColor:[UIColor grayColor]
                        andFontNum:12];
     [bottomLbl setText:@"加入魔法衣橱，获取你的私人云端衣橱"];
    [bottomLbl setTextAlignment:NSTextAlignmentLeft];
    [imgView addSubview:bottomLbl];
    
    
    ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    CGFloat btnY = imgView.bottom+100/2;
    [okBtn setFrame:CGRectMake(40,
                               btnY, 240, 30)];
    [okBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    if ([[ALLoginUserManager sharedInstance] loginCheck]) {
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    }else{
        [okBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    [okBtn setTheBtnClickBlock:^(id sender){
        ALLoginViewController *loginView = [[ALLoginViewController alloc]init];
        [self.navigationController pushViewController:loginView animated:YES];
    }];
    [view_UnLogin addSubview:okBtn];
    
    view_UnLogin.contentSize = CGSizeMake(kScreenWidth, self.contentView.height + 90);

}

-(void)_initView
{
    [self.contentView removeAllSubviews];
      __block ALMagicWardrobeViewController *blockSelf  = self;
    view_UnLogin = [[UIScrollView alloc]init];
    view_UnLogin.hidden = true;
    [self create];
    UILabel* lbl_Prompt = [[UILabel alloc]init];
    lbl_Prompt.textAlignment = NSTextAlignmentCenter;
    lbl_Prompt.numberOfLines = 0;
    lbl_Prompt.font = [UIFont systemFontOfSize:14];
    lbl_Prompt.text = @"创建属于你的云端衣橱，\n距离收到漂亮的衣服只有一步之遥，\n还不赶快登录创建一个！";
    lbl_Prompt.textColor =  colorByStr(@"#907948");
    ALButton*   btn_Login =[ALButton buttonWithType:UIButtonTypeCustom];
    [btn_Login setFrame:CGRectMake((kScreenWidth-480/2)/2, self.contentView.height - 54, 240, 60/2)];
    [btn_Login setTitle:@"登录" forState:UIControlStateNormal];
    btn_Login.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn_Login setBackgroundImage:[ALImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [btn_Login setTheBtnClickBlock:^(id sender){
        ALLoginViewController *loginView = [[ALLoginViewController alloc]init];
        [self.navigationController pushViewController:loginView animated:YES];
    }];
//    [view_UnLogin addSubview:btn_Login];
//    [view_UnLogin addSubview:lbl_Prompt];
    
    lbl_Tag = [[UILabel alloc]init];
    lbl_Tag.font = [UIFont systemFontOfSize:14];
    lbl_Tag.textAlignment = NSTextAlignmentCenter;
    lbl_Tag.numberOfLines = 0;
    lbl_Tag.hidden = true;
    lbl_Tag.textColor =  colorByStr(@"#907948");

    view_Top =[[ALComView alloc]initWithFrame:CGRectMake((kScreenWidth-106/2*2*2)/2, self.contentView.origin.y + 5 , 106/2*2*2, 40)];
    _orginY=view_Top.bottom;

    btn_YC = [[UIButton alloc]init];
    [btn_YC setTitle:@"衣橱" forState:0];
    btn_YC.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_YC setTitleColor:ALUIColorFromHex(0x92887c) forState:UIControlStateNormal];
    [btn_YC setTitleColor:ALUIColorFromHex(0xa07845) forState:UIControlStateSelected];
    btn_YC.selected = true;
    btn_YC.frame = CGRectMake((view_Top.width - 130)/2,0,65,30);
    [btn_YC addTarget:self action:@selector(test1:) forControlEvents:UIControlEventTouchUpInside];
     btn_FYL = [[UIButton alloc]init];
     btn_FYL.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_FYL setTitle:@"衣篓" forState:0];
    [btn_FYL setTitleColor:ALUIColorFromHex(0x92887c) forState:UIControlStateNormal];
    [btn_FYL setTitleColor:ALUIColorFromHex(0xa07845) forState:UIControlStateSelected];
    [btn_FYL addTarget:self action:@selector(test2:) forControlEvents:UIControlEventTouchUpInside];
    btn_FYL.frame = CGRectMake((view_Top.width - 130)/2 + 65,0,65,30);
    view_BtnLine = [[UIView alloc]init];
    view_BtnLine.backgroundColor = ALUIColorFromHex(0xa07845);
    view_BtnLine.frame = CGRectMake((view_Top.width - 130)/2 , 20, 60, 1);
    view_BtnLine.center = CGPointMake(btn_YC.center.x, btn_YC.center.y + 13);
    [view_Top addSubview:btn_YC];
    [view_Top addSubview:btn_FYL];
    [view_Top addSubview:view_BtnLine];
    [self.view addSubview:view_Top];
    [self createYC];
    UIColor *color = colorByStr(@"#75491F");

    
    _myMWTableView=[[ALTableView alloc] initWithFrame:CGRectMake(0,40,kScreenWidth,self.contentView.height - 40) style:UITableViewStylePlain];
    [_myMWTableView setDataSource:self];
    [_myMWTableView setDelegate:self];
    [_myMWTableView setBackgroundColor:[UIColor clearColor]];
    [_myMWTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _myMWTableView.hidden = true;
    [_myMWTableView addHeaderWithCallback:^{
        [blockSelf loadView:0];
    }];
    [_myMWTableView addFooterWithCallback:^{
        [blockSelf loadView:1];
    }];
    [_myMWTableView addSubview:showLabel];
//    UISwipeGestureRecognizer* recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    UISwipeGestureRecognizer* recognizerR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerR setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
  //  [_myMWTableView addGestureRecognizer:recognizerLeft];
    [_myMWTableView addGestureRecognizer:recognizerR];
    [_myMWTableView setTableHeaderView:headImgView];
    [self.contentView addSubview:_myMWTableView];
    [self.contentView addSubview:lbl_Tag];
    self.contentView.scrollEnabled = NO;
    _showLabel  = [[ALLabel alloc]
                   initWithFrame:CGRectMake(15, 270, kScreenWidth-30, 50)];
    _showLabel.backgroundColor = [UIColor clearColor];
    _showLabel.font = [UIFont systemFontOfSize:14.f];
    _showLabel.textAlignment = NSTextAlignmentCenter;
    _showLabel.numberOfLines = 2;
    _showLabel.textColor = color;
    _showLabel.layer.borderColor =color.CGColor;
    _showLabel.layer.borderWidth = 1;
    _showLabel.layer.masksToBounds = YES;
    _showLabel.layer.cornerRadius = 2;
    _showLabel.hidden = YES;
//    self.contentView.backgroundColor = AL_RGB(240, 236, 233);
    
    view_UnLogin.frame = self.contentView.bounds;
    lbl_Prompt.frame = self.contentView.bounds;
    view_UnLogin.backgroundColor = self.contentView.backgroundColor;
    [self createAlert];
    self.contentView.contentSize = CGSizeMake(kScreenWidth*2, self.contentView.height);
    view_TopLine = [[UIView alloc]init];
    view_TopLine.backgroundColor = ALUIColorFromHex(0x92887c);
    view_TopLine.frame = CGRectMake(0, 40, kScreenWidth*2, 0.5);
    [self.contentView addSubview:view_TopLine];
    [self.contentView addSubview:view_UnLogin];
    
    view_UnLogin.hidden = true;
    view_Top.hidden = true;
    view_TopLine.hidden = true;
    _collectView.hidden = true;
}
-(void)createYC
{
    __block ALMagicWardrobeViewController *blockSelf  = self;
    headImgView=[[ALImageView alloc]
                 initWithFrame:CGRectMake(5, 5, 605/2, 455/2+5+5)];
    [headImgView setImage:[ALImage imageNamed:@"wardrobe_bg"]];
    UIImageView *clothesLeftImgView=[[UIImageView alloc]
                                     initWithFrame:CGRectMake(38, 40, 102, 150)];
    [clothesLeftImgView setImage:[ALImage imageNamed:@"wardrobe_clothes_left"]];
    clothesLeftImgView.userInteractionEnabled = YES;
    [headImgView addSubview:clothesLeftImgView];
    leftGressImgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 281/2+10+5,427/2+20)];
    [leftGressImgView setImage:[ALImage imageNamed:@"wardrobe_glass_left"]];
    [headImgView addSubview:leftGressImgView];
    ALButton *leftBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:leftGressImgView.frame];
    [leftBtn setTheBtnClickBlock:^(id sender){
        [leftGressImgView setHidden:YES];
        [rightTopGressImgView setHidden:NO];
        [rightBottomGressImgView setHidden:NO];
        _type = @"全身";
        if (_listClothesArr.count>0) {
            [_listClothesArr removeAllObjects];
        }
        [_myMWTableView reloadData];
        [blockSelf _loadMyWardrobeDataAndBlock:^{
            if (_listClothesArr.count == 0)
            {
                showLabel.hidden = false;
            }
            else
            {
                showLabel.hidden = true;
            }
            [_myMWTableView reloadData];
        }];
        
    }];
    [clothesLeftImgView addSubview:leftBtn];
    _leftTopImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yiChuCountBack.png"]];
    _leftTopImg.frame = CGRectMake(leftGressImgView.left + 90, leftGressImgView.height - 63, 20, 15);
    [clothesLeftImgView addSubview:_leftTopImg];
    _leftTopCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftGressImgView.left + 90, leftGressImgView.height - 63, 20, 15)];
    _leftTopCountLbl.textAlignment = NSTextAlignmentRight;
    _leftTopCountLbl.textColor = [UIColor whiteColor];
    _leftTopCountLbl.font = [UIFont boldSystemFontOfSize:12];
    _leftTopCountLbl.textAlignment = NSTextAlignmentCenter;
    _leftTopCountLbl.text = @"0";
    [clothesLeftImgView addSubview:_leftTopCountLbl];
    UIImageView *clothesRightTopImgView=[[UIImageView alloc]
                                         initWithFrame:CGRectMake(clothesLeftImgView.right+60,
                                                                  20,
                                                                  72,
                                                                  89)];
    [clothesRightTopImgView setImage:[ALImage imageNamed:@"wardrobe_clothes_right_top"]];
    [headImgView addSubview:clothesRightTopImgView];
    clothesRightTopImgView.userInteractionEnabled = YES;
    
    rightTopGressImgView=[[UIImageView alloc]
                          initWithFrame:CGRectMake(326/2,18/2-10, 278/2+10+5,206/2+10+5)];
    [rightTopGressImgView setImage:[ALImage imageNamed:@"wardrobe_glass_right_top"]];
    [headImgView addSubview:rightTopGressImgView];
    
    _rightTopImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yiChuCountBack.png"]];
    _rightTopImg.frame = CGRectMake(rightTopGressImgView.left + 120, rightTopGressImgView.bottom - 25, 20, 15);
    [headImgView addSubview:_rightTopImg];
    _rightTopCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(rightTopGressImgView.left + 120, rightTopGressImgView.bottom - 25, 20, 15)];
    _rightTopCountLbl.textAlignment = NSTextAlignmentRight;
    _rightTopCountLbl.textColor = [UIColor whiteColor];
    _rightTopCountLbl.font = [UIFont boldSystemFontOfSize:12];
    _rightTopCountLbl.textAlignment = NSTextAlignmentCenter;
    [headImgView addSubview:_rightTopCountLbl];
    _rightTopCountLbl.text = @"0";
    ALButton *rightTopBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [rightTopBtn setFrame:rightTopGressImgView.frame];
    [rightTopBtn setTheBtnClickBlock:^(id sender){
        [leftGressImgView setHidden:NO];
        [rightTopGressImgView setHidden:YES];
        [rightBottomGressImgView setHidden:NO];
        _type = @"上半身";
        if (_listClothesArr.count>0) {
            [_listClothesArr removeAllObjects];
        }
        [_myMWTableView reloadData];
        
        [blockSelf _loadMyWardrobeDataAndBlock:^{
            
            [_myMWTableView reloadData];
            if (_listClothesArr.count == 0)
            {
                 showLabel.hidden = false;
            }
            else
            {
                  showLabel.hidden = true;
            }
 
        }];
    }];
    [headImgView addSubview:rightTopBtn];
    UIImageView *clothesRightBottomImgView=[[UIImageView alloc]
                                            initWithFrame:CGRectMake(
                                                                     clothesRightTopImgView.left - 10, clothesRightTopImgView.bottom+30,
                                                                     87,
                                                                     77)];
    [clothesRightBottomImgView setImage:[ALImage imageNamed:@"wardrobe_clothes_right_bottom"]];
    [headImgView addSubview:clothesRightBottomImgView];
    rightBottomGressImgView=[[UIImageView alloc]
                             initWithFrame:CGRectMake(326/2,rightTopGressImgView.bottom+10-5, 278/2+10+5,206/2+10)];
    [rightBottomGressImgView setImage:[ALImage imageNamed:@"wardrobe_glass_right_bottom"]];
    [headImgView addSubview:rightBottomGressImgView];
    clothesRightBottomImgView.userInteractionEnabled = YES;
    _rightBtmImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yiChuCountBack.png"]];
    _rightBtmImg.frame = CGRectMake(rightBottomGressImgView.left + 120, rightBottomGressImgView.bottom - 25, 20, 15);
    [headImgView addSubview:_rightBtmImg];
    _rightBtmCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(rightBottomGressImgView.left + 120, rightBottomGressImgView.bottom - 25, 20, 15)];
    _rightBtmCountLbl.textAlignment = NSTextAlignmentRight;
    _rightBtmCountLbl.textColor = [UIColor whiteColor];
    _rightBtmCountLbl.font = [UIFont boldSystemFontOfSize:12];
    _rightBtmCountLbl.textAlignment = NSTextAlignmentCenter;
    [headImgView addSubview:_rightBtmCountLbl];
    _rightBtmCountLbl.text = @"0";
    ALButton *rightBottomBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [rightBottomBtn setFrame:rightBottomGressImgView.frame];
    [rightBottomBtn setTheBtnClickBlock:^(id sender){
        [leftGressImgView setHidden:NO];
        [rightTopGressImgView setHidden:NO];
        [rightBottomGressImgView setHidden:YES];
        _type = @"下半身";
        if (_listClothesArr.count>0) {
            [_listClothesArr removeAllObjects];
        }
        [_myMWTableView reloadData];
        [blockSelf _loadMyWardrobeDataAndBlock:^{

            [_myMWTableView reloadData];
        }];
    }];
    [headImgView addSubview:rightBottomBtn];
    //默认
    [leftGressImgView setHidden:YES];
    [rightTopGressImgView setHidden:NO];
    [rightBottomGressImgView setHidden:NO];
    headImgView.userInteractionEnabled = YES;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectView = [[UICollectionView alloc]
                    initWithFrame:CGRectMake(kScreenWidth,
                                             40,
                                             kScreenWidth,
                                             self.contentView.height - 40)
                    collectionViewLayout:layout];
    [_collectView setBackgroundColor:_myMWTableView.backgroundColor];
    [_collectView registerClass:[ALMyBasketCollectionViewCell class]
     forCellWithReuseIdentifier:CellIdentifier];
    [_collectView setAlwaysBounceVertical:YES];
    [_collectView setDelegate:self];
    [_collectView setDataSource:self];
    [self.contentView addSubview:_collectView];
    [_collectView addHeaderWithCallback:^{
        [blockSelf _headLoadMore];
    }];
    [_collectView addFooterWithCallback:^{
      // [AFNconnectionImport AFNconnectionStarttest];
        [blockSelf _footLoadMore];
    }];
    UISwipeGestureRecognizer* recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    UISwipeGestureRecognizer* recognizerR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerR setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_collectView addGestureRecognizer:recognizerLeft];
}
-(void)createAlert
{
    btn_Cancel = [[UIButton alloc]init];
    [btn_Cancel setTitle:@"取消" forState:UIControlStateNormal];
    [btn_Cancel setTitleColor:[UIColor blueColor] forState:0];
    btn_Cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    btn_Cancel.layer.cornerRadius = 5;
    btn_Cancel.backgroundColor = colorByStr(@"#xa2a2a2");
    [btn_Cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [btn_Cancel setTitleColor:ALUIColorFromHex(0xa07845) forState:UIControlStateNormal];
    btn_Decide = [[UIButton alloc]init];
    [btn_Decide setTitleColor:ALUIColorFromHex(0xa07845) forState:UIControlStateNormal];
    btn_Decide.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn_Decide addTarget:self action:@selector(decide) forControlEvents:UIControlEventTouchUpInside];
    [btn_Decide setTitle:@"确定" forState:UIControlStateNormal];
    UIView* view_line = [[UIView alloc]init];
    view_line.backgroundColor = ALUIColorFromHex(0xa07845);
    view_Middle = [[UIView alloc]init];
    view_Middle.backgroundColor = ALUIColorFromHex(0xa07845);
    btn_Decide.layer.cornerRadius = 5;
    btn_Decide.backgroundColor = colorByStr(@"x25b6ed");
    view_Pop = [[UIView alloc]init];
    view_Pop.backgroundColor = [UIColor colorWithRed:144/255 green:144/255 blue:144/255 alpha:0.5];
    view_Pop.hidden = true;
    view_Alert = [[UIView alloc]init];
    view_Alert.clipsToBounds = true;
    view_Alert.layer.cornerRadius = 5;
    view_Alert.backgroundColor = [UIColor whiteColor];
    lbl_AlertPrompt = [[UILabel alloc]init];
    lbl_AlertPrompt.textColor = [UIColor blackColor];
    lbl_AlertPrompt.font = [UIFont systemFontOfSize:14];
    lbl_AlertPrompt.numberOfLines = 0;
    lbl_AlertPrompt.textAlignment = NSTextAlignmentCenter;
    [view_Alert addSubview:lbl_AlertPrompt];
    [view_Pop addSubview:view_Alert];
    [view_Alert addSubview:btn_Cancel];
    [view_Alert addSubview:btn_Decide];
    [view_Alert addSubview:view_line];
    [view_Alert addSubview:view_Middle];
    
    view_Load = [[UIView alloc]init];
    view_Load.hidden = true;
    UIImageView* img_O = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"load"]];
    
    img_Load = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading"]];
    img_Load.frame = CGRectMake(1, 0, 1, 8);
    [img_O addSubview:img_Load];
    imgView_Search  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    
    [view_Load addSubview:imgView_Search];
    [view_Load addSubview:img_O];
    [view_Pop addSubview:view_Load];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication].windows lastObject];
    [keyWindow addSubview:view_Pop];
    view_Pop.frame =  CGRectMake(0, 0,kScreenWidth, kScreenHeight);

    view_Alert.frame = CGRectMake(20,(kScreenHeight - 160 )/2 ,kScreenWidth - 40, 140);
    img_O.frame = CGRectMake((kScreenWidth - 40 - 238)/2, 69 + 10, 238, 8);
    view_Load.frame = CGRectMake(20,(kScreenHeight - 160 )/2 ,kScreenWidth - 40, 140);
    imgView_Search.frame = CGRectMake((kScreenWidth - 40 - 69)/2, 0, 69, 69);
    lbl_AlertPrompt.frame = CGRectMake( 20, 10,kScreenWidth - 40 - 40 , 100);
    
    btn_Cancel.frame = CGRectMake((kScreenWidth - 40)/2,100, (kScreenWidth - 40)/2, 40);
    btn_Decide.frame = CGRectMake(0,  100, (kScreenWidth - 40)/2, 40);
    view_line.frame = CGRectMake(0, 100, kScreenWidth - 40, 0.5);
    view_Middle.frame = CGRectMake((kScreenWidth - 40)/2,100,0.5,40);
       lbl_Tag.frame = CGRectMake(kScreenWidth,50,kScreenWidth,self.contentView.height - 50);
}
-(void)decide
{
    view_Pop.hidden = true;
 
    if ([lbl_AlertPrompt.text rangeOfString:@"确认清空吗"].length > 0)
    {
        if (isLeft)
        {
            [self _cleanWardrobe:^{
                
            }];
        }
        else
        {
            [self _cleanAbolishWardrobe:^{
            
            }];
        }

    }
    else if([lbl_AlertPrompt.text rangeOfString:@"确认移除至废衣篓吗"].length > 0)
    {
        
         [self _addAbanWardrobe:string_MwColothsId];
    }
    else if([lbl_AlertPrompt.text rangeOfString:@"确认添加至衣橱吗"].length > 0)
    {
       
        [self _returnWardrobeAndBlock:^{
            [self _loadMyWardrobeAbanDataAndBlock:^{
                if (isLeft == false)
                {
                    if (_listClothesArrBR.count == 0)
                    {
                        lbl_Tag.hidden = false;
                    }
                    else
                    {
                        lbl_Tag.hidden = true;
                    }
                }
                [_collectView reloadData];
            }];
        } andWardrobeId:string_MwColothsId];
    }
    
}
-(void)cancel
{
    view_Pop.hidden = true;
}

-(void)test1:(id)sender
{
//    lbl_Tag.hidden = true;
    isFirst = false;
    _pageNo=1;
    [self _loadMyWardrobeDataAndBlock:^{
        
        [_myMWTableView reloadData];
    }];
    btn_YC.selected = true;
    btn_FYL.selected = false;
    [UIView animateWithDuration:0.3 animations:^{
        view_BtnLine.center = CGPointMake(btn_YC.center.x, btn_YC.center.y + 13);
    } completion:^(BOOL finished) {
        
    }];

    isLeft = true;
  //  lbl_Tag.text = @"快去潮流广场发现好看的衣服吧！\n加入我的衣橱20件以上，就可以申请魔法包了哦~";
 
    [self setViewWithType:backBtn_type
                  andView:^(id view) {
                      ALButton *btn=view;
                      [btn setImage:nil forState:UIControlStateNormal];
                      btn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
                      
                      [btn setHidden:NO];
                      [btn setTitle:@"我要魔法包" forState:0];
                      [btn setTitleColor:colorByStr(@"#907948") forState:0];
                      
                  } andBackEvent:^(id sender)
     {
         view_Middle.hidden = true;
         lbl_AlertPrompt.text = [NSString stringWithFormat:@"扫描结果出来了\n\n*衣橱满20件衣服.................%@\n*三个柜子都不为空..............%@\n",isEnough?@"√":@"×",haveNone?@"√":@"×"] ;
         if (isEnough && haveNone)
         {
            lbl_AlertPrompt.text = @"扫描结果出来了~\n\n已经满足启动魔法包的条件了,\n快去“魔法包”里启动它吧！\n";
         }
         
         view_Pop.hidden = false;
         view_Alert.hidden = true;
         view_Load.hidden = false;
         img_Load.frame = CGRectMake(1, 0, 1, 8);
         
         CGRect boundingRect = CGRectMake(-10,-25, 30, 30);
         CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
         orbit.keyPath = @"position";
         orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
         orbit.duration = 1;
         orbit.additive = YES;
         orbit.repeatCount = HUGE_VALF;
         orbit.calculationMode = kCAAnimationPaced;
         orbit.rotationMode = /*kCAAnimationRotateAuto*/ nil;
         
         [imgView_Search.layer addAnimation:orbit forKey:@"ani-track"];
         
         [UIView animateWithDuration:2.5 animations:^{
             
             img_Load.frame = CGRectMake(1, 0, 237, 8);
         } completion:^(BOOL finished) {
             view_Alert.hidden = false;
             if (!isEnough || !haveNone)
             {
                 [btn_Decide setTitle:@"去填满衣橱" forState:0];
             }
             else
             {
                 [btn_Decide setTitle:@"确定" forState:0];
             }
             btn_Decide.frame = CGRectMake(0,  100, kScreenWidth - 40, 40);
             btn_Cancel.hidden = true;
             view_Load.hidden = true;
             // [selfBlocke gotoSeeDetaiMessage];
         }];
         
     }];
    [self.contentView setContentOffset:CGPointMake(0, 0) animated:true];
}
-(void)test2:(id)sender
{  //我的衣橱
    lbl_Tag.hidden = true;
    btn_FYL.selected = true;
    btn_YC.selected = false;
    [UIView animateWithDuration:0.3 animations:^{
        view_BtnLine.center = CGPointMake(btn_FYL.center.x, btn_FYL.center.y + 13);
    } completion:^(BOOL finished) {
        
    }];
    isLeft = false;
 
    [self.contentView setContentOffset:CGPointMake(kScreenWidth, 0) animated:true];
     lbl_Tag.text = @"这里空空的,什么都没有~";
    
    [self _loadMyWardrobeAbanDataAndBlock:^{
        if (isLeft == false)
        {
            if (_listClothesArrBR.count == 0)
            {
                lbl_Tag.hidden = false;
            }
            else
            {
                lbl_Tag.hidden = true;
            }
        }
       
        [_collectView reloadData];
    }];
    [self setViewWithType:backBtn_type
                  andView:^(id view) {
                      ALButton *btn=view;
                      [btn setHidden:true];
                  } andBackEvent:^(id sender) {
                  }];
}

-(void)loadView:(int)pageNo{
    if (pageNo==0) {
        _pageNo=1;
    }else{
        _pageNo+=1;
    }
    [self _loadMyWardrobeDataAndBlock:^{
        if (pageNo==0) {
            [_myMWTableView headerEndRefreshing];
        }else{
            [_myMWTableView footerEndRefreshing];
        }
        
        [_myMWTableView reloadData];
    }];
}


-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft)
    {
         [self test2:nil];
          [self.contentView setContentOffset:CGPointMake(320, 0) animated:true];
       
    }
    else
    {
        [self test1:nil];
          [self.contentView setContentOffset:CGPointMake(0, 0) animated:true];
    }
    
    

    
  
}

#pragma mark datasource and Delegate
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_listClothesArr.count>0)
    {
        NSInteger count = _listClothesArr.count;
        NSInteger mod = _listClothesArr.count/2;
        if (count % 2 > 0)
        {
            mod ++;
        }
        
        return mod;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *clothesIdentify=@"clothesMoreIdentify";
    ALMyMWTableViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:clothesIdentify];
    if (theCell==nil) {
        theCell=[[ALMyMWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clothesIdentify];
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSInteger index = indexPath.row;
    NSInteger count = _listClothesArr.count;
    NSInteger mod = count /2;
    if (count % 2 > 0)
    {
        mod ++;
    }
     [theCell setRightModel:nil];
    if (index < mod)
    {
        [theCell setLeftModel:_listClothesArr[indexPath.row*2+0]];
        theCell.index = 0;
        theCell.userInteractionEnabled = YES;
        if ((index+1)*2<=_listClothesArr.count) {
            [theCell setRightModel:_listClothesArr[index*2+1]];
            theCell.userInteractionEnabled = YES;
            theCell.index = 1;
        }
        else
        {
            [theCell setRightModel:nil];
            theCell.index = 1;
            
        }
        [theCell setTheBigBlock:^(NSInteger index){
            ALClothesDetailViewController *theClothesDetailCtrl=[[ALClothesDetailViewController alloc] init];
            theClothesDetailCtrl.fromMyMagicWardrobe = YES;
            if (index==0) {
                ALMagicWardrobeClothsModel *theModel=_listClothesArr[indexPath.row*2+0];
                [theClothesDetailCtrl setFashionId:theModel.fashion_id];
                theClothesDetailCtrl.mwColothsId = theModel.mwColothsId;
                [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
            }else if (index==1){
                NSInteger index = indexPath.row*2+1;
                if (index < _listClothesArr.count)
                {
                    ALMagicWardrobeClothsModel *theModel=_listClothesArr[index];
                    [theClothesDetailCtrl setFashionId:theModel.fashion_id];
                    theClothesDetailCtrl.mwColothsId = theModel.mwColothsId;
                    [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
                }
                
            }
            
            
            
            
        }];
        [theCell setTheSmallBlock:^(NSInteger index){
            NSInteger indexTmp = indexPath.row;
            indexTmp = indexTmp * 2 + index;
            if (indexTmp < _listClothesArr.count)
            {
                lbl_AlertPrompt.text = @"确认移除至废衣篓吗？\n";
                btn_Cancel.hidden = false;
                [btn_Cancel setTitle:@"取消" forState:0];
                [btn_Decide setTitle:@"确定" forState:0];
                btn_Cancel.frame = CGRectMake((kScreenWidth - 40)/2,100, (kScreenWidth - 40)/2, 40);
                btn_Decide.frame = CGRectMake(0,  100, (kScreenWidth - 40)/2, 40);
                view_Middle.hidden = false;
                view_Pop.hidden = false;
                ALMagicWardrobeClothsModel *theModel=_listClothesArr[indexTmp];
                string_MwColothsId = theModel.mwColothsId;
               
            }
            
            
        }];
        
        return theCell;
    }
    return theCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 644/4+10+108/4 - 5;
}


#pragma mark Collection

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _listClothesArrBR.count;
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
    return CGSizeMake(140,175);
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
      [cell setModel:nil];
    if (row < _listClothesArrBR.count)
    {
        [cell setModel:_listClothesArrBR[indexPath.row]];
        cell.isEdit = _isEdit;
        [cell setTheBlock:^(id sender){
            if (indexPath.row < _listClothesArrBR.count)
            {
                [btn_Cancel setTitle:@"取消" forState:0];
                [btn_Decide setTitle:@"确定" forState:0];
                btn_Cancel.frame = CGRectMake((kScreenWidth - 40)/2,100, (kScreenWidth - 40)/2, 40);
                btn_Decide.frame = CGRectMake(0,  100, (kScreenWidth - 40)/2, 40);
                btn_Cancel.hidden = false;
                lbl_AlertPrompt.text = @"确认添加至衣橱吗？\n";
                view_Middle.hidden = false;
                ALMagicWardrobeClothsModel *theModel=_listClothesArrBR[indexPath.row];
              
                view_Pop.hidden = false;
                string_MwColothsId = theModel.mwColothsId;
            
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
    if (row < _listClothesArrBR.count)
    {
        ALMagicWardrobeClothsModel *theModel=_listClothesArrBR[row];
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
    _pageNoB=1;
    [self _loadMyWardrobeAbanDataAndBlock:^{
        if (isLeft == false)
        {
            if (_listClothesArrBR.count == 0)
            {
                lbl_Tag.hidden = false;
            }
            else
            {
                lbl_Tag.hidden = true;
            }
        }
     //   [AFNconnectionImport AFNconnectionStarttest];
        [_collectView headerEndRefreshing];
        [_collectView reloadData];
    }];
}
-(void)_footLoadMore{
    _pageNoB+=1;
    [self _loadMyWardrobeAbanDataAndBlock:^{
        
        [_collectView footerEndRefreshing];
        [_collectView reloadData];
    }];
}
#pragma mark loadData
#pragma mark - 请求衣橱
-(void)_loadMyWardrobeDataAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"pageNo":[NSString stringWithFormat:@"%ld",(long)_pageNo],
                            @"pageSize":@"10",
                            @"type":_type
                            };
    if (_pageNo==1) {
        [_listClothesArr removeAllObjects];
    }
    [DataRequest requestApiName:@"fashionSquare_myWardrobeData"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       @try {
                           hideRequest;
                           //            id object = sucContent;
                           NSArray *tempArr=sucContent[@"body"][@"result"][@"dataList"];
                           [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                               ALMagicWardrobeClothsModel *theModel=[ALMagicWardrobeClothsModel questionWithDict:obj];
                               [_listClothesArr addObject:theModel];
                           }];
                           
                           NSDictionary *totalDic = sucContent[@"body"][@"result"][@"counts"];
                           if (totalDic != nil)
                           {
                               _rightTopCountLbl.text = [NSString stringWithFormat:@"%@",totalDic[@"sbs"]];
                               _leftTopCountLbl.text  = [NSString stringWithFormat:@"%@",totalDic[@"qs"]];
                               _rightBtmCountLbl.text = [NSString stringWithFormat:@"%@",totalDic[@"xbs"]];
                           }
                         
                           
                           int rightTop = [_rightTopCountLbl.text intValue];
                           int leftTop = [_leftTopCountLbl.text intValue];
                           int rightBtm = [_rightBtmCountLbl.text intValue];
                
                           if (rightBtm != 0 && leftTop!= 0&& rightTop!=0)
                           {
                               haveNone = true;
                           }
                           else
                           {
                               haveNone= false;
                           }
                           if (rightBtm + leftTop + rightTop >= 20)
                           {
                               isEnough = true;
                           }
                           else
                           {
                               isEnough = false;
                           }
                           if (_listClothesArr.count == 0)
                           {
                               showLabel.hidden = false;
                           }
                           else
                           {
                               showLabel.hidden = true;
                           }
                           
                           [_myMWTableView reloadData];
                       }
                       @catch (NSException *exception) {
                           NSLog(@"error:%@",exception);
                       }
                       @finally {
                       }
                       if (theBlock) {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   } andShowLoad:YES];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)endRefresh
{
    [_collectView headerEndRefreshing];
    [_collectView footerEndRefreshing];
    [_myMWTableView headerEndRefreshing];
    [_myMWTableView footerEndRefreshing];
}
#pragma mark loadData
#pragma mark -
#pragma mark 移至废衣篓
-(void)_addAbanWardrobe:(NSString *)wardrobeId{
    NSDictionary *sendDic=@{
                            @"wardrobeId":filterStr(wardrobeId),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            
                            };
    [DataRequest requestApiName:@"fashionSquare_addAbanWardrobe"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       showWarn(@"移除成功");
                       _pageNo=1;
                       [_myMWTableView reloadData];
                       [self _loadMyWardrobeDataAndBlock:^{
                           
                       }];
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}
#pragma mark 清空废衣篓
-(void)_cleanAbolishWardrobe:(void(^)())theBlock{
    
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            };
    [DataRequest requestApiName:@"fashionSquare_cleanAbolishWardrobe" andParams:sendDic andMethod:Get_type successBlcok:^(id sucContent) {
        @try {
            
            [_listClothesArrBR removeAllObjects];
            [_collectView reloadData];
    
                lbl_Tag.hidden = false;
        

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
    
};


#pragma mark 清空衣橱
-(void)_cleanWardrobe:(void(^)())theBlock{

    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            };
    [DataRequest requestApiName:@"fashionSquare_cleanMyWardrobe" andParams:sendDic andMethod:Get_type successBlcok:^(id sucContent) {
        @try {
            
            [_listClothesArr removeAllObjects];
            [_myMWTableView reloadData];
           _rightTopCountLbl.text = [NSString stringWithFormat:@"%d",0];
           _leftTopCountLbl.text  = [NSString stringWithFormat:@"%d",0];
           _rightBtmCountLbl.text = [NSString stringWithFormat:@"%d",0];
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

};


#pragma mark 获取我的废衣娄数据
-(void)_loadMyWardrobeAbanDataAndBlock:(void(^)())theBlock{
    if (_pageNoB==1) {
        [_listClothesArrBR removeAllObjects];
    }
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"pageNo":[NSString stringWithFormat:@"%d",_pageNoB],
                            @"pageSize":@"10"
                            };
    [DataRequest requestApiName:@"fashionSquare_myWardrobeAbanData" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
        @try {
            NSArray *tempArr=sucContent[@"body"][@"result"][@"dataList"];
            [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALMagicWardrobeClothsModel *theModel=[ALMagicWardrobeClothsModel questionWithDict:obj];
             //   [AFNconnectionImport  connectionWifi];
                
                [_listClothesArrBR addObject:theModel];
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
        [_listClothesArrBR enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
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



@end
