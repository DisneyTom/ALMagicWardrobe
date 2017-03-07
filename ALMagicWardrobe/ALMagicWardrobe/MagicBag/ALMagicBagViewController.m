//
//  ALMagicBagViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicBagViewController.h"
#import "ALMagicBagFirstEnterView.h"
#import "CustomSegmentedControl.h"
#import "ALMagicBagRecordViewController.h"
#import "ALMagicShowViewController.h"
#import "ALMagicBagBuyViewController.h"
#import "ALLoginUserManager.h"
#import "UIKit+AFNetworking.h"
#import "ALLine.h"
#import "ALMagicBagRecomentViewController.h"
#import "ALEditAddressViewController.h"
#import "ALMyMagicWardrobeViewController.h"
#import "ALMagicBagRuleViewController.h"
#import "CustomImagePickerController.h"
#import "ImageFilterProcessViewController.h"
#import "ALTabBarViewController.h"

static const int InitTag = 100000000;

@interface ALMagicBagViewController ()
<CustomSegmentedControlDelegate,CustomImagePickerControllerDelegate,
ImageFitlerProcessDelegate,UIActionSheetDelegate>
@end

@implementation ALMagicBagViewController{
    float _headHight;
    float _orginY;
    
    BOOL _isFirstBuyBool; //是否第一次购买
    NSDictionary *_enterMagicBackDic; //进入魔法包返回数据字典
    NSDictionary *_startMagicPackageBackDic;  //启动魔法包返回数据字典
    NSMutableArray *_imgMulArr; //魔法包下面的三条服装
    
    ALAddressModel *_theAddressModel;
    CustomSegmentedControl* blueSegmentedControl;
    
    NSString *_imgUrl;
    
    BOOL _isFrush; //是否刷新页面，也就是说，是否调用 viewWillAppear 默认 YES
    ALLabel *linkMan;
    ALLabel *telLbl;
    ALLabel *addressLbl;
    NSString *      _linkManTxt;
    NSString *      _telTxt;
    NSString *      _addressText;
    
    UIImage *       _showImg;
    
    UILabel*        lbl_ExpressCompany;
    UILabel*        lbl_ExpressId;
    UIButton*       btn_ChooseEx;
    ALTextField*    txt_ExId;
    NSString*       string_ExCompanyName;
    UIView*         view_Choose;
    NSString*       string_CPN;
    NSMutableArray*     array_IMG;
    NSMutableArray*     array_Btn;
    ALButton*     btn_SendMG;
    NSMutableArray* array_IMGURL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"魔法包"];
    array_IMG = [[NSMutableArray alloc]init];
    array_Btn = [[NSMutableArray alloc]init];
    [self _initData];
    string_ExCompanyName = @"";
//    //首次使用
//    NSString *val= [[NSUserDefaults standardUserDefaults]
//                    valueForKey:MBFIRST];
//    if ([val isEqualToString:@"1"]) {  //已使用过
//        [self _initView];
//    }else{ //还未使用过
//    }
}
-(void)_initData{
    _isFrush=YES;
    _orginY=0;
    _imgMulArr=[[NSMutableArray alloc] initWithCapacity:2];
    _theAddressModel=nil;
}
-(void)_initView{
    ALComView *theView= (ALComView *)[self.contentView viewWithTag:123456];
    [theView removeFromSuperview];
    
    ALComView *view=[[ALComView alloc]
                     initWithFrame:CGRectMake((kScreenWidth-106/2*2*2)/2,
                                              5,
                                              106/2*2*2,
                                              30)];
    [view setTag:123456];
    [self.contentView addSubview:view];
    
    _headHight=view.bottom+5;
    
    blueSegmentedControl =
    [[CustomSegmentedControl alloc]
     initWithSegmentCount:2
     segmentsize:CGSizeMake(106/2*2, 30)
     dividerImage:nil
     tag:0
     delegate:self];
    [view addSubview:blueSegmentedControl];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    string_ExCompanyName = @"";
    _enterMagicBackDic = [[NSDictionary alloc]init];
    if (!_isFrush) {
        _isFrush=YES;
    }else{
        //首次使用
        NSString *val= [[NSUserDefaults standardUserDefaults]
                        valueForKey:MBFIRST];
        BOOL isLogined = [[ALLoginUserManager sharedInstance] loginCheck];
        //
        if ([val isEqualToString:@"1"] || isLogined) {  //已使用过
            
            if (!isLogined) {
                
                ALComView *firstView=(ALComView *)[self.contentView viewWithTag:4000];
                [firstView removeFromSuperview];
                ALComView *theView= [self loadFisrtViewAndBlock:^{
                }];
                [theView setTag:4000];
                [self.contentView addSubview:theView];
                
                return;
            }
            [self.contentView removeAllSubviews];
            [self _initView];
            [self _loadDataMagicBagIsFirstBuyAndBlock:^{
                [self _createContentView];
            }];
        }else{
            ALComView *firstView=(ALComView *)[self.contentView viewWithTag:4000];
            [firstView removeFromSuperview];
            [self.contentView removeAllSubviews];
            
            ALComView *theView= [self loadFisrtViewAndBlock:^{
                [[NSUserDefaults standardUserDefaults]
                 setValue:@"1"
                 forKey:MBFIRST];
                if (![[ALLoginUserManager sharedInstance] loginCheck]) {
                    showWarn(@"请先登录");
                    //                [self.contentView removeAllSubviews];
                    return;
                }
                [self.contentView removeAllSubviews];
                [self _initView];
                [self _loadDataMagicBagIsFirstBuyAndBlock:^{
                    
                    [self _createContentView];
                }];
            }];
            [theView setTag:4000];
            [self.contentView addSubview:theView];
        }
        
        [blueSegmentedControl.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton *theBtn=obj;
            if (theBtn.tag==111111) {
                [theBtn setSelected:YES];
            }else{
                [theBtn setSelected:NO];
            }
        }];
        
        __block ALMagicBagViewController *theBlockCtrl=self;
        
        [self setViewWithType:rightBtn1_type
                      andView:^(id view) {
                          ALButton *btn=view;
                          if ([[ALLoginUserManager sharedInstance] loginCheck]) {
                              [btn setHidden:NO];
                          }else{
                              [btn setHidden:YES];
                          }
                          [btn setImage:[ALImage imageNamed:@"icon_date"] forState:UIControlStateNormal];
                      } andBackEvent:^(id sender) {
                          ALMagicBagRecordViewController *theCtrl=[[ALMagicBagRecordViewController alloc] init];
                          [theBlockCtrl.navigationController pushViewController:theCtrl animated:YES];
                      }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
#pragma mark 第一次进入魔法包显示界面
-(ALComView *)loadFisrtViewAndBlock:(void(^)())theBlock{
   __block ALMagicBagFirstEnterView *theView=[[ALMagicBagFirstEnterView alloc]
                                       initWithFrame:CGRectMake(0,
                                                                0,
                                                                kScreenWidth,
                                                                self.contentView.height)
                                              andBackBlock:^(id sender) {
                                                  if (![[ALLoginUserManager sharedInstance] loginCheck])
                                                   {
                                                      [self toLoginAndBlock:^{
                                                          [theView removeFromSuperview];
                                                      } andObj:self];
                                                      return;
                                                  }else{
                                                      [theView removeFromSuperview];
                                                  }
                                           if (theBlock) {
                                               theBlock();
                                           }
                                       }];
    return theView;
}
#pragma mark 创建魔法包不同状态时的显示效果
-(void)_createContentView{
  
    __block ALComView *theView;
    if (_isFirstBuyBool) {
        _orginY=_headHight;
        [self _getStartImageAndBlock:^(NSString *imgUrl) {
            _imgUrl=imgUrl;
            //未购买
            theView= [self _createNoPayAndBlock:^(id sender) {
                ALButton *btn=sender;
                if (btn.tag==10000+1) { //购买魔法包
                    ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
                    [self.navigationController pushViewController:theCtrl animated:YES];
                }else if (btn.tag==10000+2){ //去衣厨看看
                   // ALMyMagicWardrobeViewController *theCtrl=[[ALMyMagicWardrobeViewController alloc] init];
                //    self.tabBarController.selectedIndex = 2;
                    if (self.theBlcokALToMyAL)
                    {
                        self.theBlcokALToMyAL();
                    }
                   // [self.navigationController pushViewController:theCtrl animated:YES];
                }
            }];
            [self.contentView addSubview:theView];
        }];
    }else if (!_isFirstBuyBool){ //不是第一次
        _orginY=_headHight;
        //进入魔法包
        [self _enterMagicBagAndBlock:^{
            if (![_enterMagicBackDic isKindOfClass:[NSDictionary class]]||!_enterMagicBackDic||!_enterMagicBackDic.count>0) { //有数据才走魔法包流程，否者，显示，购买界面
                //未购买
                //未购买
                UIView *view = [self.contentView viewWithTag:1111];
                [view removeFromSuperview];
                
                [self _getStartImageAndBlock:^(NSString *imgUrl) {
                    _imgUrl=imgUrl;
                    //未购买
                    theView= [self _createNoPayAndBlock:^(id sender) {
                        ALButton *btn=sender;
                        if (btn.tag==10000+1) { //购买魔法包
                            ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
                            [self.navigationController pushViewController:theCtrl animated:YES];
                        }else if (btn.tag==10000+2){ //去衣厨看看
                            if (self.theBlcokALToMyAL)
                            {
                                self.theBlcokALToMyAL();
                            }
                        }
                    }];
                    [self.contentView addSubview:theView];
                }];
                return;
            }
            if ([_enterMagicBackDic[@"state"] isEqualToString:@"创建"]) {
                [self _getStartImageAndBlock:^(NSString *imgUrl) {
                    _imgUrl=imgUrl;
                    theView=[self _createHasPayNoRunAndBlock:^(id sender) {
                        ALButton *btn=sender;
                        if (btn.tag==10000+1) { //启动魔法包
                            [self _loadStartMagicPackageAndBlock:^{
                                [self _createContentView];
                            }];
                        }else if (btn.tag==10000+2){ //去衣厨看看
                            if (self.theBlcokALToMyAL)
                            {
                                self.theBlcokALToMyAL();
                            }
//                            ALMyMagicWardrobeViewController *theCtrl=[[ALMyMagicWardrobeViewController alloc] init];
//                            [self.navigationController pushViewController:theCtrl animated:YES];
                        }
                    }];
                    [theView setTag:1111];
                    [self.contentView addSubview:theView];
                }];
            }
            else if ([_enterMagicBackDic[@"state"] isEqualToString:@"已启动"])
            {
                theView=[self _createHasPayHasRunAndBlock:^(id sender) {
                    
                }];
                if ([_enterMagicBackDic[@"expressState"] isEqualToString:@"确认地址"]) {
                    
                    NSString *day = _enterMagicBackDic[@"surplusDays"];
                    int total = [day intValue];

                    if (total <= 3)
                    {
                        theView= [self _createNoPayAndBlock:^(id sender) {
                            ALButton *btn=sender;
                            if (btn.tag==10000+1) { //购买魔法包
                                ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
                                [self.navigationController pushViewController:theCtrl animated:YES];
                            }else if (btn.tag==10000+2){ //去衣厨看看
                                if (self.theBlcokALToMyAL)
                                {
                                    self.theBlcokALToMyAL();
                                }
//                                ALMyMagicWardrobeViewController *theCtrl=[[ALMyMagicWardrobeViewController alloc] init];
//                                [self.navigationController pushViewController:theCtrl animated:YES];
                            }
                        }];
                        [theView setTag:1111];
                        [self.contentView addSubview:theView];

                    }
                    else
                    {
 
                        ALComView *theContentView=[self _createOneViewAndBlock:^(id sender,NSDictionary *theViewDic){
                            ALButton *theBtn=sender;
                            if (theBtn.tag==10000+1) {
                                
                                if (btn_SendMG)
                                {
                                    if (btn_SendMG.userInteractionEnabled)
                                    {
                                        [self _loadDataConfirmAddressAndBlock:^{
                                            
                                            [self _createContentView];
                                        }];
                                    }
                                }
                                else
                                {
                                    [self _loadDataConfirmAddressAndBlock:^{
                                        
                                        [self _createContentView];
                                    }];
                                }
                             
                              
                                theBtn.userInteractionEnabled = false;
                                btn_SendMG = theBtn;
                                
                             
                            }else if (theBtn.tag==10000+2){
                                btn_SendMG.userInteractionEnabled = true;
                                ALEditAddressViewController *theCtrl=[[ALEditAddressViewController alloc] init];
                                theCtrl.isSelectedAddress = YES;
                                
                                [theCtrl setTheBlock:^(ALAddressModel *theAddressModel){
                                    _theAddressModel=theAddressModel;
                                    
                                    [linkMan setText:[NSString stringWithFormat:@"联系人:%@",_theAddressModel.linkman]];
                                    _linkManTxt = _theAddressModel.linkman;
                                    
                                    [telLbl setText:[NSString stringWithFormat:@"电话:%@",_theAddressModel.tel]];
                                    _telTxt = _theAddressModel.tel;
                                    
                                    [addressLbl setText:[NSString stringWithFormat:@"地址:%@",_theAddressModel.address]];
                                    _addressText = _theAddressModel.address;
                                    _isFrush=NO;
                                }];
                                [self.navigationController pushViewController:theCtrl animated:YES];
                            }
                            [self _createContentView];
                        }];
                        
                        [theView setHeight:theContentView.bottom];
                        [theView addSubview:theContentView];
                        
                    }
                    

                }else if ([_enterMagicBackDic[@"expressState"] isEqualToString:@"魔法包生成"]){
                    ALComView *theContentView=[self _createTwoViewAndBlock:^(id sender) {
                    }];
                    CGFloat height = theContentView.bottom;
                    if (height <= 420) {
                        height = 420;
                    }
                    [theView setHeight:height];
                    [theView addSubview:theContentView];
                }else if ([_enterMagicBackDic[@"expressState"] isEqualToString:@"派送中"]){
                    ALComView *theContentView=[self _createThreeViewAndBlock:^(id sender) {
                    }];
                    CGFloat height = theContentView.bottom;
                    if (height <= 420) {
                        height = 420;
                    }
                    [theView setHeight:height];
                    [theView addSubview:theContentView];
                }else if ([_enterMagicBackDic[@"expressState"] isEqualToString:@"送达完成"]){
                    ALComView *theContentView=[self _createFourViewAndBlock:^(id sender) {
                    }];
                    CGFloat height = theContentView.bottom;
                    if (height <= 420) {
                        height = 420;
                    }
                    [theView setHeight:height];
                    [theView addSubview:theContentView];
                }else if ([_enterMagicBackDic[@"expressState"] isEqualToString:@"使用中"]){
                    ALComView *theContentView=[self _createFiveViewAndBlock:^(id sender) {
                        ALButton *theBtn=sender;
                        if (theBtn.tag==10000+2) { //归还魔法包
                            [self _returnMagicPackageAndBlock:^{
                                 [self _createContentView];
                            }];
                        }else if (theBtn.tag==10000+1){ //咔嚓
                            [self CutPicker];
                        }
                    }];
                    [theView setHeight:theContentView.bottom];
                    [theView addSubview:theContentView];
                }else if ([_enterMagicBackDic[@"expressState"] isEqualToString:@"启动归还"]){
                                   }
                else if ([_enterMagicBackDic[@"expressState"] isEqualToString:@"取货中"])
                {
                    if ([_enterMagicBackDic[@"expresspickcompany"]isEqualToString:@""])
                    {
                        ALComView *theContentView=[self _createSixViewAndBlock:^(id sender,NSDictionary *theViewDic) {
                            ALButton *theBtn=sender;
                            if (theBtn.tag==10000+1) { //归还确定地址
                                [self _saveExInfo:^{
                                    [self _createContentView];
                                }];
                            }else if (theBtn.tag==10000+2){ //地址修改
                                ALEditAddressViewController *theCtrl=[[ALEditAddressViewController alloc] init];
                                [theCtrl setTheBlock:^(ALAddressModel *theAddressModel){
                                    _theAddressModel=theAddressModel;
                                    
                                    [linkMan setText:[NSString stringWithFormat:@"联系人:%@",filterStr(_theAddressModel.linkman)]];
                                    [telLbl setText:[NSString stringWithFormat:@"电话:%@",filterStr(_theAddressModel.tel)]];
                                    [addressLbl setText:[NSString stringWithFormat:@"地址:%@",filterStr(_theAddressModel.address)]];
                                    _isFrush=NO;
                                    
                                    [self _loadDataConfirmAddressAndBlock:^{
                                        [self _createContentView];
                                    }];
                                }];
                                [self.navigationController pushViewController:theCtrl animated:YES];
                            }
                        }];
                        [theView setHeight:theContentView.bottom];
                        [theView addSubview:theContentView];
                    }
                    else
                    {
                    ALComView *theContentView=[self _createSevenViewAndBlock:^(id sender)
                    {
                        ALButton *theBtn=sender;
                        if (theBtn.tag==10000+1)
                        { //评价魔法包
                            ALMagicBagRecomentViewController *theCtrl=[[ALMagicBagRecomentViewController alloc] init];
                            theCtrl.expressId = _enterMagicBackDic[@"expressId"];
                            [theCtrl setArr:array_IMGURL];
                            [self.navigationController pushViewController:theCtrl animated:YES];
                        }
                        else if (theBtn.tag==10000+2)
                        { //查看历史记录
                            ALMagicBagRecordViewController *theCtrl=[[ALMagicBagRecordViewController alloc] init];
                            [self.navigationController pushViewController:theCtrl animated:YES];
                        }
                    }];
                    [theView setHeight:theContentView.bottom];
                    [theView addSubview:theContentView];
                    }
                }
                else if ([_enterMagicBackDic[@"expressState"] isEqualToString:@"确认归还"])
                {
//                    theView= [self _createNoPayAndBlock:^(id sender) {
//                        ALButton *btn=sender;
//                        if (btn.tag==10000+1) { //购买魔法包
//                            ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
//                            [self.navigationController pushViewController:theCtrl animated:YES];
//                        }else if (btn.tag==10000+2){ //去衣厨看看
//                            ALMyMagicWardrobeViewController *theCtrl=[[ALMyMagicWardrobeViewController alloc] init];
//                            [self.navigationController pushViewController:theCtrl animated:YES];
//                        }
//                    }];
//                    [theView setTag:1111];
//                    [self.contentView addSubview:theView];
                    //未购买
                    UIView *view = [self.contentView viewWithTag:1111];
                    [view removeFromSuperview];
                    _orginY=_headHight;
                    [self _getStartImageAndBlock:^(NSString *imgUrl) {
                        _imgUrl=imgUrl;
                        //未购买
                        theView= [self _createNoPayAndBlock:^(id sender) {
                            ALButton *btn=sender;
                            if (btn.tag==10000+1) { //购买魔法包
                                ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
                                [self.navigationController pushViewController:theCtrl animated:YES];
                            }else if (btn.tag==10000+2){ //去衣厨看看
                                if (self.theBlcokALToMyAL)
                                {
                                    self.theBlcokALToMyAL();
                                }
//                                ALMyMagicWardrobeViewController *theCtrl=[[ALMyMagicWardrobeViewController alloc] init];
//                                [self.navigationController pushViewController:theCtrl animated:YES];
                            }
                        }];
                        UIView *view = [theView viewWithTag:1000000 + 1];
                        UILabel *lbl = (UILabel *)[view viewWithTag:1000000];
                        lbl.hidden = NO;
                        [self.contentView addSubview:theView];
                    }];

                    return;
                }
            }
            
            [self.contentView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALComView *childView=obj;
                if (childView.tag==1111) {
                    if (childView) {
                        _orginY=_headHight;
                        [childView removeAllSubviews];
                        [childView removeFromSuperview];
                    }else{
                        _orginY=childView.bottom;
                    }
                    
                    [childView removeFromSuperview];
                    childView=nil;
                }
            }];
            
            [theView setTag:1111];
            [self.contentView addSubview:theView];
            self.contentView.backgroundColor = AL_RGB(240, 236, 233);
        }];
    }else{
    }
}

#pragma mark 创建进度条
#pragma mark --
-(ALComView *)_createProgressViewAndBlock:(BOOL)isHiddenNote theBLock:(void(^)())theBlock{
    
//    CGFloat originY = kScreenHeight - 380;
    ALComView *theView=[[ALComView alloc]
                        initWithFrame:CGRectMake(0, _orginY -10, kScreenWidth, 260/4+20)];
    
    ALImageView *progress_bar_imgView=[[ALImageView alloc]
                                       initWithFrame:CGRectMake(25, (theView.height-11)/2 - 5, 270, 11)];
    [progress_bar_imgView setImage:[ALImage imageNamed:@"progress_bar"]];
    [theView addSubview:progress_bar_imgView];
    
    float surplusValue = 0;
    if (_enterMagicBackDic[@"surplusDays"]!=nil) {
        surplusValue = [_enterMagicBackDic[@"surplusDays"] floatValue];
    }
    float totalValue = 1.f;
    if (_enterMagicBackDic[@"totalDays"]!=nil) {
        totalValue =[_enterMagicBackDic[@"totalDays"] floatValue];
    }
    
    CGFloat progressWidth = (surplusValue/totalValue)*progress_bar_imgView.width;
    ALImageView *progress_bar_on_imgView=[[ALImageView alloc]
                                          initWithFrame:CGRectMake(20, (theView.height-11)/2 - 5, progressWidth, 11)];
    NSInteger surplusDays=[_enterMagicBackDic[@"surplusDays"] integerValue];
    if (surplusDays>15) {
        [progress_bar_on_imgView setImage:[ALImage imageNamed:@"progress_bar_on"]];
    }else if (surplusDays>10&&surplusDays<15){
        [progress_bar_on_imgView setImage:[ALImage imageNamed:@"progress_bar_yellow_on"]];
    }else if (surplusDays<10){
        [progress_bar_on_imgView setImage:[ALImage imageNamed:@"progress_bar_red_on"]];
    }
    [theView addSubview:progress_bar_on_imgView];
//    ALImageView *pointImgView=[[ALImageView alloc]
//                               initWithFrame:CGRectMake(progress_bar_on_imgView.right-50/2, progress_bar_on_imgView.top-50/2-10, 50, 50)];
    CGFloat y = (theView.height-11)/2 - 15;
    CGFloat x = 0.f;
    if (isHiddenNote == NO)
    {
        x = progress_bar_on_imgView.right-30/2;
    }
    else
    {
        x =  15;
    }
    
    ALImageView *pointImgView=[[ALImageView alloc]
                               initWithFrame:CGRectMake(x, y, 30, 30)];

    
    if (surplusDays>15) {
        [pointImgView setImage:[ALImage imageNamed:@"icon_vernier"]];
    }else if (surplusDays>10&&surplusDays<15){
        [pointImgView setImage:[ALImage imageNamed:@"icon_vernier_yellow"]];
    }else if (surplusDays<10){
        if (surplusDays <=3 && surplusDays >= 1) {
            x = progress_bar_on_imgView.right-20;
            pointImgView.frame = CGRectMake(x, y, 30, 30);
        }
        [pointImgView setImage:[ALImage imageNamed:@"icon_vernier_yellow"]];
    }
    [theView addSubview:pointImgView];
    

    NSString *tip = @"";
    NSString *day = _enterMagicBackDic[@"surplusDays"];
    int total = [day intValue];
    if (total < 10 && total >= 4)
    {
        tip =[NSString stringWithFormat:@"距离本次服务到期还有%@天,请续费.",day];
        
        if (total >= 4)
        {
            tip =[NSString stringWithFormat:@"距离本次服务到期还有%@天,服务只剩3天的时候就不能再申请魔法包了哦,请尽快续费吧.",day];
        }
    }
    else if (total <= 3 && total > 0)
    {
        tip =[NSString stringWithFormat:@"距离本次服务到期还有%@天,已经不能再申请魔法包了哦,请尽快续费吧.",day];
    }
    else if (total <= 0)
    {
        tip =[NSString stringWithFormat:@"本次服务已到期,不能再申请魔法包了哦,请尽快续费吧"];
        
    }
    else
    {
        tip = [NSString stringWithFormat:@"距离本次服务到期还有%@天",day];
    }
    
    CGSize size = [ALComAction getSizeByStr:tip andFont:[UIFont systemFontOfSize:12] andRect:CGSizeMake(300, 0.f)];
    
    ALLabel *noteLbl=[[ALLabel alloc]initWithFrame:CGRectMake(10,progress_bar_imgView.bottom+ 15,theView.width - 20,size.height)
                      andColor:colorByStr(@"#907948")
                      andFontNum:12];
    [noteLbl setText:tip];
    noteLbl.numberOfLines = 0;
    [noteLbl setTextAlignment:NSTextAlignmentCenter];
    noteLbl.hidden = isHiddenNote;
    noteLbl.tag = 1000000;
    [theView addSubview:noteLbl];
    
    ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, theView.width, theView.height)];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            theBlock();
        }
    }];
    [theView addSubview:btn];
    
    return theView;
}
- (UIButton*) buttonFor:(CustomSegmentedControl *)segmentedControl
                atIndex:(NSUInteger)segmentIndex{
    UIButton *btn=nil;
    if (segmentIndex==0) {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, 106, 30)];
        [btn setBackgroundImage:[ALImage imageNamed:@"select_left"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[ALImage imageNamed:@"select_left_on"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(test1:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"魔法旅程" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTag:111111];
        [btn setSelected:YES];
    }else if (segmentIndex==1){
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(106, 0, 106, 30)];
        [btn setBackgroundImage:[ALImage imageNamed:@"select_right"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[ALImage imageNamed:@"select_right_on"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(test2:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"魔镜秀" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTag:222222];
        [btn setSelected:NO];

    }else{
        
    }
    return btn;
}
-(void)test1:(id)sender{
    
}
-(void)test2:(id)sender{
    ALMagicShowViewController *theCtrl=[[ALMagicShowViewController alloc] init];
    [theCtrl setMagicBagDic:_enterMagicBackDic];
    [self.navigationController pushViewController:theCtrl animated:YES];
}

-(void)chooseEx:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    if (btn_ChooseEx == btn)
    {
        view_Choose.hidden = false;
        
        [array_IMG enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            UIImageView* imgView = array_IMG[idx];
            UIButton* btn = array_Btn[idx];
            imgView.hidden = true;
            NSString *strUrl = [btn_ChooseEx.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if([btn.titleLabel.text rangeOfString:strUrl].location !=NSNotFound)
            {
                imgView.hidden = false;
            }
        }];
    }
    else
    {
        NSString *strUrl = [btn.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([strUrl isEqualToString:@"百世汇通"])
        {
            [btn_ChooseEx setTitle:[NSString stringWithFormat:@"     %@",strUrl] forState:0];
        }
        else
        {
            [btn_ChooseEx setTitle:[NSString stringWithFormat:@"         %@",strUrl] forState:0];
        }
        view_Choose.hidden = true;
        string_ExCompanyName = btn.titleLabel.text;
    }
}
#pragma mark 未付费
#pragma mark --
-(ALComView *)_createNoPayAndBlock:(void(^)(id sender))theBlock{
    ALComView *theView=[[ALComView alloc]
                        initWithFrame:CGRectMake(0,
                                                 _orginY,
                                                 kScreenWidth,
                                                 0)];
    [theView setTag:1111];
    
    ALButton *imgBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setFrame:CGRectMake(0,
                               0,
                               theView.width,
                                1000/4)];
    [imgBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_imgUrl] placeholderImage:nil];
    [imgBtn setTheBtnClickBlock:^(id sender){
        ALMagicBagRuleViewController *theCtrl=[[ALMagicBagRuleViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [theView addSubview:imgBtn];
    
    ALButton *oneBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [oneBtn setFrame:CGRectMake(40,
                                imgBtn.bottom+10, 240, 30)];
    [oneBtn setBackgroundImage:[ALImage imageNamed:@"btn_magic_room"] forState:UIControlStateNormal];
    oneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [oneBtn setTitle:@"支付，成为会员"
            forState:UIControlStateNormal];
    [oneBtn setTag:10000+1];

    
    [oneBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            theBlock(sender);
        }
    }];
    [theView addSubview:oneBtn];
    
    ALButton *twoBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [twoBtn setFrame:CGRectMake(40,
                                oneBtn.bottom+10,
                                240,
                                30)];
//    [twoBtn setBackgroundImage:[ALImage imageNamed:@"btn_magic_room"] forState:UIControlStateNormal];
    [twoBtn setTitle:@"去衣橱看看" forState:UIControlStateNormal];
    [twoBtn setTitleColor:AL_RGB(161, 114, 61) forState:UIControlStateNormal];
    twoBtn.layer.cornerRadius = 4;
    twoBtn.layer.masksToBounds = YES;
    twoBtn.layer.borderWidth = 1;
    twoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIColor *borderColor = AL_RGB(186, 161, 142);
    twoBtn.layer.borderColor = borderColor.CGColor;
    [twoBtn setTag:10000+2];
    [twoBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            theBlock(sender);
        }
    }];
    
    [theView addSubview:twoBtn];
    
    _orginY=twoBtn.bottom;
    
    ALComView *theProgressView=[self _createProgressViewAndBlock:YES theBLock:^{
        ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    theProgressView.tag = 1000000 + 1;
    [theView addSubview:theProgressView];
    
    [theView setHeight:theProgressView.bottom];
    
    
    
//    [theView setHeight:twoBtn.bottom+10];

    return theView;
}

#pragma mark 已付费，未启动
#pragma mark --
-(ALComView *)_createHasPayNoRunAndBlock:(void(^)(id sender))theBlock{
    ALComView *theView=[[ALComView alloc]
                        initWithFrame:CGRectMake(0,
                                                 _orginY,
                                                 kScreenWidth,
                                                 0)];

    
    ALButton *imgBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setFrame:CGRectMake(0, 0, theView.width, 1000/4)];
    [imgBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_imgUrl] placeholderImage:LoadIngImg];
    [imgBtn setTheBtnClickBlock:^(id sender){
        ALMagicBagRuleViewController *theCtrl=[[ALMagicBagRuleViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [theView addSubview:imgBtn];
    
    ALButton *oneBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [oneBtn setFrame:CGRectMake(40,
                                imgBtn.bottom+10,
                                240,
                                30)];
    [oneBtn setBackgroundImage:[ALImage imageNamed:@"btn_magic_room"]
                      forState:UIControlStateNormal];
    [oneBtn setTitle:@"我要魔法包" forState:UIControlStateNormal];
    [oneBtn setTag:10000+1];
    [oneBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            theBlock(sender);
        }
    }];
    [theView addSubview:oneBtn];
    
    ALButton *twoBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [twoBtn setFrame:CGRectMake(40,
                                oneBtn.bottom+10,
                                240,
                                30)];
//    [twoBtn setBackgroundImage:[ALImage imageNamed:@"btn_magic_room"] forState:UIControlStateNormal];
    [twoBtn setTitle:@"去衣橱看看" forState:UIControlStateNormal];
    [twoBtn setTitleColor:AL_RGB(161, 114, 61) forState:UIControlStateNormal];
    twoBtn.layer.cornerRadius = 4;
    twoBtn.layer.masksToBounds = YES;
    twoBtn.layer.borderWidth = 1;
    UIColor *borderColor = AL_RGB(186, 161, 142);
    twoBtn.layer.borderColor = borderColor.CGColor;
    [twoBtn setTag:10000+2];
    [twoBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            theBlock(sender);
        }
    }];
    [theView addSubview:twoBtn];
    
    _orginY=twoBtn.bottom;
    
    ALComView *theProgressView=[self _createProgressViewAndBlock:NO theBLock:^{
        ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [theView addSubview:theProgressView];
    
    [theView setHeight:theProgressView.bottom+10];
    
    return theView;
}

#pragma mark 已付费，已启动
#pragma mark --
-(ALComView *)_createHasPayHasRunAndBlock:(void(^)(id sender))theBlock{
   ALComView *theView=[[ALComView alloc]
                       initWithFrame:CGRectMake(0,
                                                _orginY,
                                                kScreenWidth,
                                                0)];
    theView.backgroundColor = AL_RGB(240, 236, 233);
    
    array_IMGURL = [[NSMutableArray alloc]init];
    
   
    if (_enterMagicBackDic[@"fashions"] != [NSNull null])
    {
        if (([[_enterMagicBackDic[@"fashions"] class] isSubclassOfClass:[NSArray class]] && [_enterMagicBackDic[@"expressState"] isEqualToString:@"送达完成"]) ||[_enterMagicBackDic[@"expressState"] isEqualToString:@"使用中"] ||[_enterMagicBackDic[@"expressState"] isEqualToString:@"启动归还"]||[_enterMagicBackDic[@"expressState"] isEqualToString:@"取货中"]    )
        {
            array_IMGURL = _enterMagicBackDic[@"fashions"];
        }
        else
        {
            [array_IMGURL addObject:@"loadPlaceHolder.png"];
            [array_IMGURL addObject:@"loadPlaceHolder.png"];
            [array_IMGURL addObject:@"loadPlaceHolder.png"];
        }
    
    }
    [array_IMGURL enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        ALImageView *theImgView=[[ALImageView alloc]
                                 initWithFrame:CGRectMake(10 + idx * 98 + 4 * idx,
                                                          10,
                                                          96,
                                                          108)];
        if ([obj isKindOfClass:[NSDictionary class]])
        {
                 [theImgView setImageWithURL:[NSURL URLWithString:obj[@"mainImage"]] placeholderImage:LoadIngImg];
        }
        else
        {
            [theImgView setImage:[ALImage imageNamed:obj]];
        }
   
        [theView addSubview:theImgView];
        
    }];
    [theView setHeight:125 - _orginY];

    _orginY=theView.bottom+10;

    return theView;
}

#pragma mark 已付费，已启动
#pragma mark --  1启动魔法包-确认地址
-(ALComView *)_createOneViewAndBlock:(void(^)(id sender,NSDictionary *theViewDic))theBlock{
    ALComView *theView=[[ALComView alloc]
                        initWithFrame:CGRectMake(0,
                                                 _orginY,
                                                 kScreenWidth,
                                                 0)];
    
    CGSize size=[ALComAction
                 getSizeByStr:_enterMagicBackDic[@"message"]
                 andFont:[UIFont systemFontOfSize:14]];
   __block ALLabel *msgLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(20,
                                              -10,
                                              280,
                                              size.height)
                     andColor:colorByStr(@"#6f6D69")
                     andFontNum:14];
    [msgLbl setText:filterStr(_enterMagicBackDic[@"message"])];
    [msgLbl setNumberOfLines:0];
    [msgLbl sizeToFit];
    [theView addSubview:msgLbl];
    
    UIImageView *line=[[UIImageView alloc]
                       initWithFrame:CGRectMake(0,
                                                msgLbl.bottom+10,
                                                kScreenWidth,
                                                0.5f)];
    [theView addSubview:line];
    line.backgroundColor = AL_RGB(209, 197, 183);
    
    linkMan=[[ALLabel alloc]
             initWithFrame:CGRectMake(20,
                                      line.bottom + 10,
                                      125,
                                      15)
             andColor:colorByStr(@"#6f6D69")
             andFontNum:15];

    NSString *linkManTxt = _enterMagicBackDic[@"linkMan"];
    if (linkManTxt.length <= 0)
    {
        linkManTxt = @"";
    }
    else
    {
    if (_linkManTxt.length > 0)
    {
        linkManTxt = _linkManTxt;
    }}
    [linkMan setText:[NSString stringWithFormat:@"联系人:%@",linkManTxt]];
    linkMan.textAlignment = NSTextAlignmentLeft;
    [theView addSubview:linkMan];
    
    
    
    NSString *telTxt = _enterMagicBackDic[@"tel"];
    if (telTxt.length <= 0)
    {
        telTxt = @"";
    }
    else
    {
        if (_telTxt.length > 0)
        {
        telTxt = _telTxt;
        }
    }
    
    telLbl=[[ALLabel alloc]
            initWithFrame:CGRectMake(150, linkMan.top, 160, linkMan.height)
            andColor:colorByStr(@"#6f6D69")
            andFontNum:15];
    [telLbl setText:[NSString stringWithFormat:@"电话:%@",telTxt]];
    telLbl.textAlignment = NSTextAlignmentLeft;
    [theView addSubview:telLbl];
    
    NSString *addressTxt = _enterMagicBackDic[@"address"];
    if (addressTxt.length <= 0)
    {
        addressTxt = @"";
    }
    else
    {
        if (_addressText.length > 0)
        {
        addressTxt = _addressText;
        }
    }
    NSString *address = [NSString stringWithFormat:@"地址：%@",addressTxt];
    
    
    CGSize addReSize=[ALComAction
                      getSizeByStr:address
                      andFont:[UIFont systemFontOfSize:15] andRect:CGSizeMake(280, 0)];
    addressLbl=[[ALLabel alloc]
                initWithFrame:CGRectMake(20, telLbl.bottom + 10, 280, addReSize.height)
                andColor:colorByStr(@"#6f6D69")
                andFontNum:addReSize.height];
    [addressLbl setText:address];
    addressLbl.font = [UIFont systemFontOfSize:15];
    addressLbl.textAlignment = NSTextAlignmentLeft;
    addressLbl.numberOfLines = 0;
    [theView addSubview:addressLbl];
    
    _orginY=addressLbl.bottom;
    
  
    
    
    ALButton *leftBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(40,
                                 addressLbl.bottom+10,
                                 240,
                                 30)];
    [leftBtn setTitle:@"确认收货地址" forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg"]
                       forState:UIControlStateNormal];
    [leftBtn setTag:10000+1];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    if (btn_SendMG)
    {
        leftBtn.userInteractionEnabled = btn_SendMG.userInteractionEnabled;
      //  NSLog(@"不能用了啊");
    }
   
    [leftBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            theBlock(sender,nil);
        }
    }];
    [theView addSubview:leftBtn];
    
    ALButton *rightBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(40, leftBtn.bottom+10,240, 30)];
    [rightBtn setTitle:@"修改收货地址" forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[ALImage imageNamed:@"btn_wardrobe"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:colorByStr(@"#9C7E57") forState:UIControlStateNormal];
    [rightBtn setTag:10000+2];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            NSDictionary *dic=@{
                                @"linkMan":linkMan,
                                @"telLbl":telLbl,
                                @"addressLbl":addressLbl
                                };
            theBlock(sender,dic);
        }
    }];
    [theView addSubview:rightBtn];
    
    _orginY=rightBtn.bottom;
    if (_orginY < 200)
    {
        _orginY = 200;
    }
    
    ALComView *theProgressView=[self _createProgressViewAndBlock:NO theBLock:^{
        ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [theView addSubview:theProgressView];
    
    [theView setHeight:theProgressView.bottom];
    
    return theView;
}
#pragma mark 已付费，已启动
#pragma mark --  2魔法包状态-生成
-(ALComView *)_createTwoViewAndBlock:(void(^)(id sender))theBlock{
    ALComView *theView=[[ALComView alloc]
                        initWithFrame:CGRectMake(0, _orginY, kScreenWidth, 0)];
    CGSize size=[ALComAction
                 getSizeByStr:_enterMagicBackDic[@"message"]
                 andFont:[UIFont systemFontOfSize:14]];
    ALLabel *msgLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(20,
                                              -10,
                                              theView.width-40,
                                              size.height)
                     andColor:colorByStr(@"#6f6D69")
                     andFontNum:14];
    [msgLbl setText:filterStr(_enterMagicBackDic[@"message"])];
    [msgLbl setNumberOfLines:0];
    [msgLbl sizeToFit];
    [theView addSubview:msgLbl];
    
    UIImageView *line=[[UIImageView alloc]
                  initWithFrame:CGRectMake(0,
                                           msgLbl.bottom+10,
                                           kScreenWidth,
                                           0.5f)];
    [theView addSubview:line];
    line.backgroundColor = AL_RGB(209, 197, 183);
    
    linkMan=[[ALLabel alloc]
                      initWithFrame:CGRectMake(20,
                                               line.bottom + 10,
                                               125,
                                               15)
                      andColor:colorByStr(@"#6f6D69")
                      andFontNum:15];
    [linkMan setText:[NSString stringWithFormat:@"联系人:%@",_enterMagicBackDic[@"linkMan"]]];
    linkMan.textAlignment = NSTextAlignmentLeft;
    [theView addSubview:linkMan];
    
    telLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(150, linkMan.top, 160, linkMan.height)
                     andColor:colorByStr(@"#6f6D69")
                     andFontNum:15];
    [telLbl setText:[NSString stringWithFormat:@"电话:%@",_enterMagicBackDic[@"tel"]]];
    telLbl.textAlignment = NSTextAlignmentLeft;
    [theView addSubview:telLbl];
    
    
    NSString *address = [NSString stringWithFormat:@"地址：%@",_enterMagicBackDic[@"address"]];
    
    CGSize addReSize=[ALComAction
                 getSizeByStr:address
                      andFont:[UIFont systemFontOfSize:15] andRect:CGSizeMake(280, 0)];
    addressLbl=[[ALLabel alloc]
                         initWithFrame:CGRectMake(20, telLbl.bottom + 10, 280, addReSize.height)
                         andColor:colorByStr(@"#6f6D69")
                         andFontNum:addReSize.height];
    [addressLbl setText:address];
    addressLbl.font = [UIFont systemFontOfSize:15];
    addressLbl.textAlignment = NSTextAlignmentLeft;
    addressLbl.numberOfLines = 0.f;
    [theView addSubview:addressLbl];
    
    _orginY=addressLbl.bottom;
    if (_orginY < 200)
    {
        _orginY = 200;
    }
    
    ALComView *theProgressView=[self _createProgressViewAndBlock:NO theBLock:^{
        ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [theView addSubview:theProgressView];
    
    [theView setHeight:theProgressView.bottom];
    
    return theView;
}

#pragma mark 已付费，已启动
#pragma mark --  3派送中
-(ALComView *)_createThreeViewAndBlock:(void(^)(id sender))theBlock
{
    ALComView *theView=[[ALComView alloc] initWithFrame:CGRectMake(0, _orginY, kScreenWidth, 0)];
    CGSize size=[ALComAction
                 getSizeByStr:_enterMagicBackDic[@"message"]
                 andFont:[UIFont systemFontOfSize:14]];
    ALLabel *msgLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(20,
                                              -10,
                                              theView.width-40,
                                              size.height)
                     andColor:colorByStr(@"#6f6D69")
                     andFontNum:14];
   
    [msgLbl setText:filterStr(_enterMagicBackDic[@"message"])];
      [msgLbl setNumberOfLines:0];
     [msgLbl sizeToFit];
  
    [theView addSubview:msgLbl];
    
    UIImageView *line=[[UIImageView alloc]
                       initWithFrame:CGRectMake(0,
                                                msgLbl.bottom+10,
                                                kScreenWidth,
                                                0.5f)];
    [theView addSubview:line];
    line.backgroundColor = AL_RGB(209, 197, 183);
    
    _orginY=line.bottom;
    
    linkMan=[[ALLabel alloc]
             initWithFrame:CGRectMake(20,
                                      line.bottom + 10,
                                      125,
                                      15)
             andColor:colorByStr(@"#6f6D69")
             andFontNum:15];
    [linkMan setText:[NSString stringWithFormat:@"联系人:%@",_enterMagicBackDic[@"linkMan"]]];
    linkMan.textAlignment = NSTextAlignmentLeft;
    [theView addSubview:linkMan];
    
    telLbl=[[ALLabel alloc]
            initWithFrame:CGRectMake(150, linkMan.top, 160, linkMan.height)
            andColor:colorByStr(@"#6f6D69")
            andFontNum:15];
    [telLbl setText:[NSString stringWithFormat:@"电话:%@",_enterMagicBackDic[@"tel"]]];
    telLbl.textAlignment = NSTextAlignmentLeft;
    [theView addSubview:telLbl];
    
    
    NSString *address = [NSString stringWithFormat:@"地址：%@",_enterMagicBackDic[@"address"]];
    
    CGSize addReSize=[ALComAction
                      getSizeByStr:address
                      andFont:[UIFont systemFontOfSize:15] andRect:CGSizeMake(280, 0)];
    addressLbl=[[ALLabel alloc]
                initWithFrame:CGRectMake(20, telLbl.bottom + 10, 280, addReSize.height)
                andColor:colorByStr(@"#6f6D69")
                andFontNum:addReSize.height];
    [addressLbl setText:address];
    addressLbl.font = [UIFont systemFontOfSize:15];
    addressLbl.textAlignment = NSTextAlignmentLeft;
    addressLbl.numberOfLines = 0.f;
    [theView addSubview:addressLbl];
    
    _orginY=addressLbl.bottom;
    if (_orginY < 200)
    {
        _orginY = 200;
    }
    
    ALComView *theProgressView=[self _createProgressViewAndBlock:NO theBLock:^{
        ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [theView addSubview:theProgressView];
    
    [theView setHeight:theProgressView.bottom];
    
    return theView;
}

#pragma mark 已付费，已启动
#pragma mark --  4送达完成
-(ALComView *)_createFourViewAndBlock:(void(^)(id sender))theBlock{
    ALComView *theView=[[ALComView alloc] initWithFrame:CGRectMake(0, _orginY, kScreenWidth, 0)];
    
    ALLabel *nickLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(20,
                                              30,
                                              280,
                                              15)
                     andColor:AL_RGB(183, 142, 90)
                     andFontNum:14];
//    [nickLbl setText:filterStr(_enterMagicBackDic[@"message"])];
    [nickLbl setNumberOfLines:0];
    nickLbl.textAlignment = NSTextAlignmentCenter;
  //  [theView addSubview:nickLbl];
    if ([[ALLoginUserManager sharedInstance] loginCheck]) {
        [[ALLoginUserManager sharedInstance] getUserInfo:[[ALLoginUserManager sharedInstance] getUserId] andBack:^(ALUserDetailModel *theUserDetailInfo) {
            NSString *nickName = theUserDetailInfo.theUserModel.nickname;
            if (nickName.length > 0)
            {
                nickLbl.text = nickName;
            }
            else
            {
                nickLbl.text = theUserDetailInfo.theUserModel.usertel;
            }
            
        } andReLoad:NO];
    }
    
    
    CGSize size=[ALComAction
                 getSizeByStr:_enterMagicBackDic[@"message"]
                 andFont:[UIFont systemFontOfSize:14]];
    ALLabel *msgLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(20,
                                               20,
                                              280,
                                              size.height)
                     andColor:AL_RGB(183, 142, 90)
                     andFontNum:14];
    [msgLbl setText:filterStr(_enterMagicBackDic[@"message"])];
    [msgLbl setNumberOfLines:0];
    [msgLbl sizeToFit];
    [theView addSubview:msgLbl];
    msgLbl.textAlignment = NSTextAlignmentCenter;
    
    _orginY=msgLbl.bottom + 35;

    UIImageView *tipImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, _orginY, kScreenWidth, 20)];
    tipImage.image = [UIImage imageNamed:@"magicSendFinished.png"];
    [theView addSubview:tipImage];
    _orginY = tipImage.bottom;
    
    if (_orginY < 200)
    {
        _orginY = 200;
    }
    
    ALComView *theProgressView=[self _createProgressViewAndBlock:NO theBLock:^{
        ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [theView addSubview:theProgressView];
    
    [theView setHeight:theProgressView.bottom];
    
    return theView;
}

#pragma mark 已付费，已启动
#pragma mark -- 5魔法包状态-使用中
-(ALComView *)_createFiveViewAndBlock:(void(^)(id sender))theBlock{
    ALComView *theView=[[ALComView alloc]
                        initWithFrame:CGRectMake(0, _orginY, kScreenWidth,0)];
    CGSize size=[ALComAction
                 getSizeByStr:_enterMagicBackDic[@"message"]
                 andFont:[UIFont systemFontOfSize:14]];
    ALLabel *msgLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(20,
                                              20,
                                              280,
                                              size.height)
                     andColor:colorByStr(@"#6f6D69")
                     andFontNum:14];
    [msgLbl setText:filterStr(_enterMagicBackDic[@"message"])];
    [msgLbl setNumberOfLines:0];
    [msgLbl sizeToFit];
    [theView addSubview:msgLbl];
    
    ALButton *oneBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [oneBtn setFrame:CGRectMake(40, msgLbl.bottom+35,240, 30)];
    [oneBtn setTitle:@"咔嚓一下" forState:UIControlStateNormal];
    [oneBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg"]
                       forState:UIControlStateNormal];
    [oneBtn setTag:10000+1];
    oneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [oneBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            theBlock(sender);
        }
    }];
    [theView addSubview:oneBtn];
    
    ALButton *twoBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [twoBtn setFrame:CGRectMake(40, oneBtn.bottom+10,240, 30)];
    [twoBtn setTitle:@"归还魔法包" forState:UIControlStateNormal];
    [twoBtn setBackgroundImage:[ALImage imageNamed:@"btn_wardrobe"] forState:UIControlStateNormal];
    [twoBtn setTitleColor:colorByStr(@"#9C7E57") forState:UIControlStateNormal];
    [twoBtn setTag:10000+2];
    twoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [twoBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            theBlock(sender);
        }
    }];
    [theView addSubview:twoBtn];
    
    _orginY=twoBtn.bottom;
    if (_orginY < 200)
    {
        _orginY = 200;
    }
    ALComView *theProgressView=[self _createProgressViewAndBlock:NO theBLock:^{
        ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [theView addSubview:theProgressView];

    [theView setHeight:theProgressView.bottom+20];
    
    return theView;
}

#pragma mark 已付费，已启动
#pragma mark -- 6魔法包状态-启动归还
-(ALComView *)_createSixViewAndBlock:(void(^)(id sender,NSDictionary *theViewDic))theBlock{
    ALComView *theView=[[ALComView alloc] initWithFrame:CGRectMake(0, _orginY, kScreenWidth, 0)];
    NSString *str = _enterMagicBackDic[@"message2"];
    CGSize size=[ALComAction
                 getSizeByStr:_enterMagicBackDic[@"message2"]
                 andFont:[UIFont systemFontOfSize:14]];
    ALLabel *msgLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(20,
                                              -10,
                                              280,
                                              size.height)
                     andColor:colorByStr(@"#6f6D69")
                     andFontNum:14];
    
    NSMutableAttributedString *newStr=[[NSMutableAttributedString alloc] initWithString:str];
    [newStr addAttribute:NSForegroundColorAttributeName value: colorByStr(@"#a07845") range:NSMakeRange(str.length-13 , 13)];
    //[totalPriceLbl setAttributedText:newStr];
    msgLbl.attributedText = newStr;
  //  [msgLbl setText:filterStr(_enterMagicBackDic[@"message2"])];
    [msgLbl setNumberOfLines:0];
    [msgLbl sizeToFit];
    [theView addSubview:msgLbl];
    
    UIImageView *line=[[UIImageView alloc]
                       initWithFrame:CGRectMake(0,
                                                msgLbl.bottom+10,
                                                kScreenWidth,
                                                0.5f)];
    [theView addSubview:line];
    line.backgroundColor = AL_RGB(209, 197, 183);
    _orginY=line.bottom;
    linkMan=[[ALLabel alloc]
             initWithFrame:CGRectMake(20,
                                      line.bottom + 10,
                                      125,
                                      15)
             andColor:colorByStr(@"#6f6D69")
             andFontNum:15];
    [linkMan setText:[NSString stringWithFormat:@"联系人:%@",_enterMagicBackDic[@"mfyclinkMan"]]];
    linkMan.textAlignment = NSTextAlignmentLeft;
    [theView addSubview:linkMan];
    
    telLbl=[[ALLabel alloc]
            initWithFrame:CGRectMake(150, linkMan.top, 160, linkMan.height)
            andColor:colorByStr(@"#6f6D69")
            andFontNum:15];
    [telLbl setText:[NSString stringWithFormat:@"电话:%@",_enterMagicBackDic[@"mfyctel"]]];
    telLbl.textAlignment = NSTextAlignmentLeft;
    [theView addSubview:telLbl];
    NSString *address = [NSString stringWithFormat:@"地址：%@",_enterMagicBackDic[@"mfycaddress"]];
    
    CGSize addReSize=[ALComAction
                      getSizeByStr:address
                      andFont:[UIFont systemFontOfSize:15] andRect:CGSizeMake(280, 0)];
    addressLbl=[[ALLabel alloc]
                initWithFrame:CGRectMake(20, telLbl.bottom + 7, 280, addReSize.height)
                andColor:colorByStr(@"#6f6D69")
                andFontNum:addReSize.height];
    [addressLbl setText:address];
    addressLbl.font = [UIFont systemFontOfSize:15];
    addressLbl.textAlignment = NSTextAlignmentLeft;
    [theView addSubview:addressLbl];
    addressLbl.numberOfLines = 0;
    _orginY=addressLbl.bottom;
    lbl_ExpressCompany = [[UILabel alloc]init];
    lbl_ExpressCompany.frame = CGRectMake(20, addressLbl.bottom+15, 100, linkMan.height);
    lbl_ExpressCompany.font= [UIFont systemFontOfSize:15];
    lbl_ExpressCompany.textColor = colorByStr(@"#6f6D69");
    lbl_ExpressCompany.text = @"输入快递信息";
    btn_ChooseEx = [[UIButton alloc]init];
    btn_ChooseEx.backgroundColor = [UIColor whiteColor];
    [btn_ChooseEx setTitle:@"  选择快递" forState:0];
    btn_ChooseEx.frame = CGRectMake(20, lbl_ExpressCompany.bottom+10,120, 35);
//    btn_ChooseEx.layer.borderColor = AL_RGB(210,204,188).CGColor;
//    btn_ChooseEx.layer.borderWidth = .4f;
    btn_ChooseEx.titleLabel.font = [UIFont systemFontOfSize:15];
    btn_ChooseEx.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn_ChooseEx setTitleColor:colorByStr(@"#6f6D69") forState:0];
    [btn_ChooseEx addTarget:self action:@selector(chooseEx:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView* imgView_Ch = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_Ex"]];
    [btn_ChooseEx addSubview:imgView_Ch];
    imgView_Ch.frame = CGRectMake(btn_ChooseEx.width - 20,(35 -10)/2 , 15, 10);
    txt_ExId = [[ALTextField alloc]init];
    txt_ExId.backgroundColor = [UIColor whiteColor];
    txt_ExId.placeholder = @"输入单号";
    txt_ExId.frame = CGRectMake(btn_ChooseEx.left + btn_ChooseEx.width + 10, lbl_ExpressCompany.bottom+10,kScreenWidth - btn_ChooseEx.left - btn_ChooseEx.width - 20 - 10, 35);
//    txt_ExId.layer.borderColor = AL_RGB(210,204,188).CGColor;
//    txt_ExId.layer.borderWidth = .4f;
    txt_ExId.font = [UIFont systemFontOfSize:15];
    UIView* view_left = [[UIView alloc]init];
    view_left.frame = CGRectMake(0, 0, 10, 10);
    txt_ExId.leftView = view_left;
    txt_ExId.leftViewMode = UITextFieldViewModeAlways;
    
    view_Choose = [[UIView alloc]init];
    view_Choose.layer.cornerRadius = 3;
    view_Choose.backgroundColor = [UIColor whiteColor];
    view_Choose.layer.borderColor = AL_RGB(210,204,188).CGColor;
    view_Choose.layer.borderWidth = .4f;
    view_Choose.frame = CGRectMake(btn_ChooseEx.left,btn_ChooseEx.y - 10, btn_ChooseEx.width, 240);
    view_Choose.center = btn_ChooseEx.center;
    view_Choose.hidden = true;
    //顺丰、中通、圆通、百世汇通、申通、韵达
    [array_IMG removeAllObjects];
    [array_Btn removeAllObjects];
    for (int i = 0; i< 8; i++)
    {
        UIButton* btn = [[UIButton alloc]init];
        UIImageView* imgview_ = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image_Check"]];
        imgview_.frame = CGRectMake(10, (30 - 12)/2, 12, 12);
        [array_IMG addObject:imgview_];
        [array_Btn addObject:btn];
        [btn addSubview:imgview_];
        btn.tag = i*30 + 30;
        [btn addTarget:self action:@selector(chooseEx:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, i*30, btn_ChooseEx.width, 30);
        [btn setTitleColor:colorByStr(@"#4b4b4b") forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        NSString* string_Cp;
        switch (i)
        {
            case 0:
            {
              string_Cp =@"        顺丰";
            }
                break;
            case 1:
            {
               string_Cp =@"        中通";
            }
                break;
            case 2:
            {
                string_Cp =@"        圆通";
            }
                break;
            case 3:
            {
               string_Cp =@"        百世汇通";
            }
                break;
            case 4:
            {
                string_Cp =@"        申通";
            }
                break;
            case 5:
            {
                string_Cp =@"        韵达";
            }
                break;
            case 6:
            {
               string_Cp =@"        天天";
            }
                break;
            case 7:
            {
                string_Cp =@"        其他";
            }
                break;
        }
        [btn setTitle:string_Cp forState:0];
        [view_Choose addSubview:btn];
    }
    
    [theView addSubview:btn_ChooseEx];
    [theView addSubview:lbl_ExpressCompany];
    [theView addSubview:lbl_ExpressId];
    [theView addSubview:txt_ExId];
    
    
    
    ALButton *leftBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(40,btn_ChooseEx.bottom+20,240,30)];
    [leftBtn setTitle:@"OK,快递小哥拿走啦" forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg"]
                       forState:UIControlStateNormal];
    [leftBtn setTag:10000+1];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn setTheBtnClickBlock:^(id sender)
    {
        if ([txt_ExId.text isEqualToString:@""])
        {
            showWarn(@"请填写快递单号");
            return ;
        }
        if ([string_ExCompanyName isEqualToString:@""])
        {
            showWarn(@"请选择快递公司");
            return ;
        }
        if (theBlock) {
            theBlock(sender,nil);
        }
    }];
    [theView addSubview:leftBtn];
    
    ALButton *rightBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(40, leftBtn.bottom+8,240, 30)];
    [rightBtn setTitle:@"修改" forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[ALImage imageNamed:@"btn_wardrobe"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:colorByStr(@"#9C7E57") forState:UIControlStateNormal];
    [rightBtn setTag:10000+2];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            NSDictionary *dic=@{
                                @"linkMan":linkMan,
                                @"telLbl":telLbl,
                                @"addressLbl":addressLbl
                                };
            theBlock(sender,dic);
        }
    }];
   // [theView addSubview:rightBtn];
    
    _orginY=leftBtn.bottom;
    if (_orginY < 200)
    {
        _orginY = 200;
    }
    ALComView *theProgressView=[self _createProgressViewAndBlock:NO theBLock:^{
        ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [theView addSubview:theProgressView];
    
    [theView setHeight:theProgressView.bottom];
    [theView addSubview:view_Choose];
    return theView;
}

#pragma mark 已付费，已启动
#pragma mark -- 7魔法包状态-取货中
-(ALComView *)_createSevenViewAndBlock:(void(^)(id sender))theBlock
{
    ALComView *theView=[[ALComView alloc] initWithFrame:CGRectMake(0, _orginY, kScreenWidth, 0)];
    
    CGSize size=[ALComAction
                 getSizeByStr:_enterMagicBackDic[@"message3"]
                 andFont:[UIFont systemFontOfSize:14]];
    ALLabel *msgLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(20,
                                              -10,
                                              280,
                                              size.height)
                     andColor:colorByStr(@"#6f6D69")
                     andFontNum:14];
    [msgLbl setText:filterStr(_enterMagicBackDic[@"message3"])];
    [msgLbl setNumberOfLines:0];
    [msgLbl sizeToFit];
    [theView addSubview:msgLbl];
    
    UIImageView *line=[[UIImageView alloc]
                       initWithFrame:CGRectMake(0,
                                                msgLbl.bottom+10,
                                                kScreenWidth,
                                                0.5f)];
    [theView addSubview:line];
    line.backgroundColor = AL_RGB(209, 197, 183);
    
    _orginY=line.bottom;
    
    linkMan=[[ALLabel alloc]
             initWithFrame:CGRectMake(20,
                                      line.bottom + 10,
                                      280,
                                      15)
             andColor:colorByStr(@"#6f6D69")
             andFontNum:15];
    NSString* string_Cp = [[NSString alloc]init];
    string_Cp = [NSString stringWithFormat:@"快递公司 : %@",_enterMagicBackDic[@"expresspickcompany"]];
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc]initWithString:string_Cp];
    [attString addAttribute:NSForegroundColorAttributeName value:AL_RGB(149,105,62) range:NSMakeRange(7,string_Cp.length - 7)];
   // [linkMan setText:[NSString stringWithFormat:@"联系人:%@",_enterMagicBackDic[@"linkMan"]]];
    linkMan.attributedText = attString;
    linkMan.textAlignment = NSTextAlignmentLeft;
    [theView addSubview:linkMan];
    
    //expresspicknumber
//    telLbl=[[ALLabel alloc]
//            initWithFrame:CGRectMake(150, linkMan.top, 160, linkMan.height)
//            andColor:colorByStr(@"#6f6D69")
//            andFontNum:15];
//    [telLbl setText:[NSString stringWithFormat:@"电话:%@",_enterMagicBackDic[@"tel"]]];
//    telLbl.textAlignment = NSTextAlignmentLeft;
//    [theView addSubview:telLbl];
    
    
    NSString *address = [NSString stringWithFormat:@"快递单号 : %@",_enterMagicBackDic[@"expresspicknumber"]];
    NSMutableAttributedString* attString_address = [[NSMutableAttributedString alloc]initWithString:address];
    [attString_address addAttribute:NSForegroundColorAttributeName value:AL_RGB(149,105,62) range:NSMakeRange(7,address.length - 7)];
    CGSize addReSize=[ALComAction
                      getSizeByStr:address
                      andFont:[UIFont systemFontOfSize:15] andRect:CGSizeMake(280, 0)];
    addressLbl=[[ALLabel alloc]
                initWithFrame:CGRectMake(20, linkMan.bottom + 10, 280, addReSize.height)
                andColor:colorByStr(@"#6f6D69")
                andFontNum:addReSize.height];
    addressLbl.attributedText = attString_address;
//    [addressLbl setText:address];
    addressLbl.font = [UIFont systemFontOfSize:15];
    addressLbl.textAlignment = NSTextAlignmentLeft;
    addressLbl.numberOfLines = 0;
    [theView addSubview:addressLbl];
    
    _orginY=addressLbl.bottom;

    
    ALButton *oneBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [oneBtn setFrame:CGRectMake(40, _orginY+35,240, 30)];
    [oneBtn setTitle:@"评价本次魔法包" forState:UIControlStateNormal];
    [oneBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg"]
                       forState:UIControlStateNormal];
    [oneBtn setTag:10000+1];
    oneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [oneBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            theBlock(sender);
        }
    }];
    [theView addSubview:oneBtn];
    BOOL isAssess = [[_enterMagicBackDic valueForKey:@"isAssess"] boolValue];
    if (isAssess)
    {
        oneBtn.userInteractionEnabled = NO;
        [oneBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [oneBtn setTitle:@"已评价" forState:UIControlStateNormal];
        [oneBtn setBackgroundColor:AL_RGB(216, 216, 216)];
        [oneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    ALButton *twoBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [twoBtn setFrame:CGRectMake(40, oneBtn.bottom+10,240, 30)];
    [twoBtn setTitle:@"查看历史记录" forState:UIControlStateNormal];
    [twoBtn setBackgroundImage:[ALImage imageNamed:@"btn_wardrobe"] forState:UIControlStateNormal];
    [twoBtn setTitleColor:colorByStr(@"#9C7E57") forState:UIControlStateNormal];
    [twoBtn setTag:10000+2];
    twoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [twoBtn setTheBtnClickBlock:^(id sender){
        if (theBlock) {
            theBlock(sender);
        }
    }];
    [theView addSubview:twoBtn];
    
    _orginY=twoBtn.bottom;
    if (_orginY < 200)
    {
        _orginY = 200;
    }
    ALComView *theProgressView=[self _createProgressViewAndBlock:NO theBLock:^{
        ALMagicBagBuyViewController *theCtrl=[[ALMagicBagBuyViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [theView addSubview:theProgressView];
    
    [theView setHeight:theProgressView.bottom];
    
    return theView;
}

#pragma mark 照相
-(void)CutPicker{
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:@"选择图片"
                            delegate:self
                            cancelButtonTitle:@"取消"
                            destructiveButtonTitle:nil
                            otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}
- (void)cameraPhoto:(UIImage *)image  //选择完图片
{
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    [fitler setDelegate:self];
    fitler.currentImage = image;
    [self presentViewController:fitler animated:YES completion:nil];
}
- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    _showImg=image;
    [self _saveMirrorShowAndBlock:^{
        ALMagicShowViewController *theCtrl=[[ALMagicShowViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
}
- (void)cancelCamera{
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        CustomImagePickerController *picker = [[CustomImagePickerController alloc] init];
        //        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        //        }else{
        //            [picker setIsSingle:YES];
        //            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        //        }
        [picker setCustomDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
    }
    if (buttonIndex == 1) {
        CustomImagePickerController *picker = [[CustomImagePickerController alloc] init];
        [picker setIsSingle:YES];
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [picker setCustomDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
    }
}


#pragma mark loadData
#pragma mark -
#pragma mark 是否第一次购买
-(void)_loadDataMagicBagIsFirstBuyAndBlock:(void(^)())theBlock{
    
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    showRequest;
    [DataRequest requestApiName:@"magicBag_isFirstBuy"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       hideRequest;
                       //[@"isFirstBuy"][@"isFirstBuy"]
        _isFirstBuyBool=[sucContent[@"body"][@"result"] boolValue];
        if (theBlock) {
            theBlock();
        }
    } failedBlock:^(id failContent) {
        hideRequest;
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
        hideRequest;
        showFail(reloginContent);
    }];
}
#pragma mark 进入魔法包
-(void)_enterMagicBagAndBlock:(void(^)())theBlck{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    showRequest;
    [DataRequest requestApiName:@"magicBag_enterMagic"
                      andParams:sendDic andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       _enterMagicBackDic=sucContent[@"body"][@"result"];
                       hideRequest;
                       if (theBlck) {
                           theBlck();
                       }
    } failedBlock:^(id failContent) {
        hideRequest;
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
        hideRequest;
    } andShowLoad:YES];
}
#pragma mark 启动魔法包- 失败时提示去衣橱看看
-(void)_loadStartMagicPackageAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"magicPackageId":_enterMagicBackDic[@"id"],
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    showRequest;
    [DataRequest requestApiName:@"magicBag_startMagicPackage"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       _startMagicPackageBackDic=sucContent[@"body"][@"result"];
                       hideRequest;
                       if (theBlock) {
                           theBlock();
                       }
                   } failedBlock:^(id failContent)
    {
                       hideRequest;
                       [self buildFailView:failContent[@"body"][@"message"]];
                   } reloginBlock:^(id reloginContent) {
                       hideRequest;
                   }];
}

#pragma mark - 生成魔法包失败
- (void)buildFailView:(NSString *)failContent
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *bgView = [[UIView alloc] initWithFrame:window.bounds];
    bgView.backgroundColor = AL_RGB(85, 86, 81);
    bgView.alpha = 0.9;
    [window addSubview:bgView];
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(10, 164, 300, 165.f)];
    shadowView.backgroundColor = AL_RGB(6, 9, 8);
    [bgView addSubview:shadowView];
    
    UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 260, 60)];
    textLbl.text = failContent;
   
    textLbl.font =  [UIFont systemFontOfSize:14];
    textLbl.numberOfLines = 0.f;
    textLbl.textColor = [UIColor whiteColor];
    textLbl.backgroundColor = [UIColor clearColor];
    [shadowView addSubview:textLbl];
    
    ALButton *GotoYIchu=[ALButton buttonWithType:UIButtonTypeCustom];
    GotoYIchu.tag = InitTag;
    [GotoYIchu setFrame:CGRectMake(30,
                                   115,
                                   240,
                                   30)];
    [GotoYIchu setTitle:@"去衣橱看看" forState:UIControlStateNormal];
    [GotoYIchu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    GotoYIchu.layer.cornerRadius = 4;
    GotoYIchu.layer.masksToBounds = YES;
    GotoYIchu.backgroundColor = AL_RGB(163, 117, 80);
    [shadowView addSubview:GotoYIchu];
    [GotoYIchu addTarget:self action:@selector(buildBagFail:) forControlEvents:UIControlEventTouchUpInside];
    
    ALButton *disApper = [ALButton buttonWithType:UIButtonTypeCustom];
    disApper.tag = InitTag + 1;
    [disApper setFrame:CGRectMake(270,
                                  0.f,
                                  30,
                                  30)];
    [disApper setImage:[UIImage imageNamed:@"bagDisAppear.png"] forState:UIControlStateNormal];
    [disApper setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shadowView addSubview:disApper];
    [disApper addTarget:self action:@selector(buildBagFail:) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)buildBagFail:(UIButton *)btn
{
    UIButton *btnTmp = btn;
    NSInteger tag = btnTmp.tag;
    NSInteger index =tag - InitTag;
    if (index == 0) //去一处看看
    {
        [btn.superview.superview removeFromSuperview];
        if (self.theBlcokALToMyAL)
        {
            self.theBlcokALToMyAL();
        }
//        ALMyMagicWardrobeViewController *theCtrl=[[ALMyMagicWardrobeViewController alloc] init];
//        [self.navigationController pushViewController:theCtrl animated:YES];
        
    }
    else
    {
        [btn.superview.superview removeFromSuperview];
    }
}



#pragma mark 地址确定
-(void)_loadDataConfirmAddressAndBlock:(void(^)())theBlock{
    
   // NSLog(@"阿斯达大的阿迪阿斯顿啊");
    if(_isFrush == YES)
    {
        NSString *addressStr=_theAddressModel?filterStr(_theAddressModel.address):filterStr(_enterMagicBackDic[@"address"]);
        NSString *telStr=_theAddressModel?filterStr(_theAddressModel.tel):filterStr(_enterMagicBackDic[@"tel"]);
        NSString *linkmanStr=_theAddressModel?filterStr(_theAddressModel.linkman):filterStr(_enterMagicBackDic[@"linkMan"]);
        
        if (!addressStr.length>0&&!telStr.length>0&&!linkmanStr.length>0) {
            showWarn(@"请点击修改，完善地址信息");
            btn_SendMG.userInteractionEnabled = true;
            return;
        }
        NSDictionary *sendDic=@{
                                @"magicPackageId":filterStr(_enterMagicBackDic[@"id"]),
                                @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                                @"address":filterStr(addressStr),
                                @"tel":filterStr(telStr),
                                @"linkman":filterStr(linkmanStr)
                                };
        showRequest;
        [DataRequest requestApiName:@"magicBag_confirmAddress"
                          andParams:sendDic
                          andMethod:Post_type
                       successBlcok:^(id sucContent) {
                           if (theBlock) {
                               theBlock();
                           }
                           hideRequest;
                    
                       } failedBlock:^(id failContent) {
                           //        showFail(failContent);
                           //NSLog(@"%@",sendDic);
                           [self buildFailView:failContent[@"body"][@"message"]];
                           btn_SendMG.userInteractionEnabled = true;
                           hideRequest;
                           
                       } reloginBlock:^(id reloginContent) {
                           hideRequest;

                       }];

    }
    
}
#pragma mark 保存快递信息
-(void)_saveExInfo:(void(^)())theBlock
{
    
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"expressId":filterStr(_enterMagicBackDic[@"expressId"]),
                            @"expressNumber":filterStr(txt_ExId.text),
                            @"company":filterStr(string_ExCompanyName)
                            };
    string_ExCompanyName= @"";
    showRequest;
    [DataRequest requestApiName:@"magicBag_SaveEx"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       hideRequest;
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

#pragma mark 归还魔法包

-(void)_returnMagicPackageAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                           // @"magicPackageId":filterStr(_enterMagicBackDic[@"id"]),
                            @"expressId":filterStr(_enterMagicBackDic[@"expressId"]),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    showRequest;
    [DataRequest requestApiName:@"magicBag_returnMagicPackage"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       hideRequest;
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
#pragma mark 确认归还地址
-(void)_confirmReturnAddressAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"magicPackageId":filterStr(_enterMagicBackDic[@"id"]),
                            @"expressId":filterStr(_enterMagicBackDic[@"expressId"]),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"address":filterStr(_enterMagicBackDic[@"address"]),
                            @"tel":filterStr(_enterMagicBackDic[@"tel"]),
                            @"linkman":filterStr(_enterMagicBackDic[@"linkMan"])
                            };
    showRequest;
    [DataRequest requestApiName:@"magicBag_confirmReturnAddress"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       hideRequest;
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
#pragma mark 查询魔法包下面的三条服装
-(void)_getEvaluateListAndBlock:(void(^)())theBlock{
    if ([_enterMagicBackDic[@"expressState"] isEqualToString:@"送达完成"]||
        [_enterMagicBackDic[@"expressState"] isEqualToString:@"使用中"]||
        [_enterMagicBackDic[@"expressState"] isEqualToString:@"启动归还"]||
        [_enterMagicBackDic[@"expressState"] isEqualToString:@"取货中"]        ){
        NSDictionary *sendDic=@{
                                @"expressId":filterStr(_enterMagicBackDic[@"expressId"])
                                };
        showRequest;
        [DataRequest requestApiName:@"magicBag_getEvaluateList"
                          andParams:sendDic
                          andMethod:Post_type
                       successBlcok:^(id sucContent) {
                           hideRequest;
                           [_imgMulArr removeAllObjects];
                           NSArray *tempArr=sucContent[@"body"][@"result"];
                           [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                               [_imgMulArr addObject:obj];
                           }];
                           if (theBlock) {
                               theBlock();
                           }
                       } failedBlock:^(id failContent) {
                           hideRequest;
                           showFail(failContent);
                       } reloginBlock:^(id reloginContent) {
                           hideRequest;
                       }];

    }else{
        [_imgMulArr removeAllObjects];
        [_imgMulArr addObject:@"loadPlaceHolder.png"];
        [_imgMulArr addObject:@"loadPlaceHolder.png"];
        [_imgMulArr addObject:@"loadPlaceHolder.png"];
        if (theBlock) {
            theBlock();
        }
    }
}
#pragma mark 获得魔法包规则图片
-(void)_getStartImageAndBlock:(void(^)(NSString *imgUrl))theBlock{
    NSDictionary *sendDic=@{};
    showRequest;
    [DataRequest requestApiName:@"fashionSquare_getStartImage"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       hideRequest;
                       if (theBlock) {
                           theBlock(sucContent[@"body"][@"result"][1][@"image"]);
                       }
                   } failedBlock:^(id failContent) {
                       hideRequest;
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                       hideRequest;
                   } andShowLoad:YES];
}
#pragma mark 保存个人秀图片
-(void)_saveMirrorShowAndBlock:(void(^)())theBlock{
    //添加图片，并对其进行压缩（0.0为最大压缩率，1.0为最小压缩率）
    NSData *imageData = UIImageJPEGRepresentation(_showImg, 1.0);
    
    if (![[ALLoginUserManager sharedInstance] loginCheck]) {
        showWarn(@"请先登录");
        return;
    }
    
    NSDictionary *sendDic=@{
                            @"magicPackageId":filterStr(_enterMagicBackDic[@"id"]),
                            @"expressId":filterStr(_enterMagicBackDic[@"expressId"]),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    showRequest;
    [DataRequest requestApiName:@"magicBag_saveMirrorShow"
                      andParams:sendDic
                         andImg:imageData
                   successBlcok:^(id sucContent) {
                       hideRequest;
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
