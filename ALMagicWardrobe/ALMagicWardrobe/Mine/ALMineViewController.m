//
//  ALMineViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMineViewController.h"
#import "DBManage.h"
#import "DBManage+OcnUser.h"
#import "ALPersonalDataCell.h"
#import "ALLabel.h"

#import "ALLoginViewController.h"
#import "ALPersonalDataViewController.h"
#import "ALSystemMessageViewController.h"
#import "ALSettingViewController.h"

#import "ALMagicValViewController.h"
#import "ALMoneyViewController.h"
#import "ALFashionDiaryViewController.h"
#import "ALCollectViewController.h"
#import "ALProductGuideViewController.h"
#import "ALImageView.h"
#import "UIImageView+AFNetworking.h"
//#import "ALProductActionViewController.h"
#import "ALTestControlViewController.h"
#import "AlServiceGuildViewController.h"
#import "ALSetTestViewController.h"

#import "ALMagicBagBuyViewController.h"
#import "ALUserDetailModel.h"
#import "ALMagicDailyViewController.h"

@interface ALMineViewController ()
<UITableViewDataSource,
UITableViewDelegate>
@end

@implementation ALMineViewController{
    ALComView *_headView;
    ALTableView *_userMainTable;
    NSArray *_leftTitArr;
    NSMutableArray *_lineHeightArr;
    ALUserDetailModel *_theUserDetailModel;
    UIImageView* imgView_;
}
@synthesize tb_Ctrl;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tb_Ctrl getMessage];
    //用户是否登录
    if ([[ALLoginUserManager sharedInstance] loginCheck]) {
        [[ALLoginUserManager sharedInstance]
         getUserInfo:[[ALLoginUserManager sharedInstance] getUserId]
         andBack:^(ALUserDetailModel *theUserDetailInfo) {
             _theUserDetailModel=theUserDetailInfo;
            [self setViewAboutHeadViewWithLoginStatue:YES];
        } andReLoad:YES];
//        ALLoginUserManager *userManger = [ALLoginUserManager sharedInstance];
//        [userManger setUserBieMing];
    }
    else{
        _theUserDetailModel=nil;
        [self setViewAboutHeadViewWithLoginStatue:NO];
        [_userMainTable reloadData];
    }
    NSArray* ar = self.navigationController.viewControllers;
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if ([_userMainTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [_userMainTable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_userMainTable respondsToSelector:@selector(setLayoutMargins:)])  {
        [_userMainTable setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

//查看消息
-(void)gotoSeeDetaiMessage
{
    ALSystemMessageViewController *systemVC = [[ALSystemMessageViewController alloc]init];
    [self.navigationController pushViewController:systemVC animated:YES];
}

//查看设置
-(void)gotoSeeDetaiseeting
{
    ALSettingViewController *personSetingInfo = [[ALSettingViewController alloc]init];
    [self.navigationController pushViewController:personSetingInfo animated:YES];
}
-(void)setViewAboutHeadViewWithLoginStatue:(BOOL)userInorNOt{
    if (userInorNOt) {
        ALImageView * headImageView = [[ALImageView alloc]
                                       initWithFrame:CGRectMake(
                                                                (kScreenWidth-96)/2,
                                                                71/2-15,
                                                                96,
                                                                96)];
        [headImageView.layer setCornerRadius:(headImageView.frame.size.height/2)];
        [headImageView.layer setMasksToBounds:YES];

         ALUserDetailModel *theDetailModel=nil;
         ALUserModel *theModel=nil;
        theDetailModel=_theUserDetailModel;
        theModel=_theUserDetailModel.theUserModel;
        [headImageView setImageWithURL:[NSURL URLWithString:theModel.userpic]
                      placeholderImage:[UIImage imageNamed:@"weidenglu.png"]];
        [self setLeftBtnHidOrNot:NO];
        if (_headView) {
            [_headView removeFromSuperview];
            _headView = nil;
            [self initHeadView];
        }
        
        ALLabel *showNameLabel = [[ALLabel alloc]
                                 initWithFrame:CGRectMake(0,
                                                          headImageView.bottom+5,
                                                          kScreenWidth,
                                                          24)
                                 Font:16 BGColor:AL_RGB(249, 249, 249)
                                 FontColor:RGB_Font_Second_Title];
        [showNameLabel setTextAlignment:NSTextAlignmentCenter];
        [showNameLabel setBackgroundColor:[UIColor clearColor]];
        showNameLabel.textColor = HEX(@"#ae8e63");
        [showNameLabel setText:theModel.nickname];
        [_headView addSubview:showNameLabel];
        
        [_headView addSubview:headImageView];


//        [_headView addSubview:showTitLabel];
        [_headView addSubview:headImageView];

        __block ALMineViewController *selfBlocke = self;
        
        [self setViewWithType:rightBtn1_type
                      andView:^(id view) {
                          ALButton *btn=view;
                          [btn setHidden:NO];
                          [btn setImage:[ALImage imageNamed:@"icon02in"] forState:UIControlStateNormal];
                      } andBackEvent:^(id sender) {
                          [selfBlocke gotoSeeDetaiseeting];
                      }];
        
        [self setViewWithType:backBtn_type
                      andView:^(id view) {
                          ALButton *btn=view;
                         
                          if ([[NSUserDefaults standardUserDefaults]objectForKey:@"messageStatu"] && [[[NSUserDefaults standardUserDefaults]objectForKey:@"messageStatu"]  isEqualToString:@"1"])
                          {
                              
                              imgView_.hidden = false;
                              [btn addSubview:imgView_];
                          }
                          else
                          {
                              imgView_.hidden = true;
                          }
                          
                          [btn setHidden:NO];
                          [btn setImage:[ALImage imageNamed:@"icon01in"] forState:UIControlStateNormal];
                      } andBackEvent:^(id sender) {
                          [selfBlocke gotoSeeDetaiMessage];
                      }];
        
        ALButton* _seeDetaiBtn = [ALButton buttonWithType:UIButtonTypeCustom];
        [_seeDetaiBtn setFrame:CGRectMake(kScreenWidth-68, 131/2, 49, 50)];
        [_seeDetaiBtn setImage:[ALImage imageNamed:@"icon03in"]
                      forState:UIControlStateNormal];
        [_seeDetaiBtn setTheBtnClickBlock:^(id sender){
            [selfBlocke goToTheViewAboutPersonInfoView:theDetailModel];
        }];
        [_headView addSubview:_seeDetaiBtn];
        [_userMainTable reloadData];
    }else{
        [self setLeftBtnHidOrNot:YES];
        
        if (_headView) {
            [_headView removeFromSuperview];
            _headView = nil;
            [self initHeadView];
        }
        
        [self setViewWithType:rightBtn1_type
                      andView:^(id view) {
                          ALButton *btn=view;
                          [btn setHidden:YES];
                      } andBackEvent:^(id sender) {
                      }];
        
        [self setViewWithType:backBtn_type
                      andView:^(id view) {
                          ALButton *btn=view;
                          [btn setHidden:YES];
                      } andBackEvent:^(id sender) {
                      }];

        ALImageView * headImageView = [[ALImageView alloc]
                                       initWithFrame:CGRectMake((kScreenWidth-96)/2, 71/2, 96, 96)];
        [headImageView.layer setCornerRadius:(headImageView.frame.size.height/2)];
        [headImageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"weidenglu.png"]];
        headImageView.userInteractionEnabled = YES;
        __block ALMineViewController *selfBlock = self;
        [headImageView setTheImageVimageTouchuBlock:^(id sender){
            [selfBlock goToLoginView];
        }];
        
        ALLabel *showTitLabel = [[ALLabel alloc]
                                    initWithFrame:CGRectMake(0,
                                                             71/2+96,
                                                             kScreenWidth,
                                                             24)
                                    Font:16 BGColor:AL_RGB(249, 249, 249)
                                    FontColor:RGB_Font_Second_Title];
        [showTitLabel setTextAlignment:NSTextAlignmentCenter];
        [showTitLabel setText:@"未登录"];
        [showTitLabel setBackgroundColor:[UIColor clearColor]];
        showTitLabel.textColor = HEX(@"#936c38");
        [_headView addSubview:showTitLabel];
        [_headView addSubview:headImageView];
    }
}

//用户登录
-(void)goToLoginView{
    ALLoginViewController *loginView = [[ALLoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}

//查看个人详细资料
-(void)goToTheViewAboutPersonInfoView:(ALUserDetailModel *)theModel{
    ALPersonalDataViewController *personInfo = [[ALPersonalDataViewController alloc]init];
    [personInfo setTheUserDetailModel:theModel];
    [self.navigationController pushViewController:personInfo animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我"];
    [self initTableView];
    [self initHeadView];
    self.contentView.backgroundColor =  HEX(@"#efebe8");
    imgView_ = [[UIImageView alloc]init];
    imgView_.layer.cornerRadius = 4;
    imgView_.backgroundColor = [UIColor redColor];
    imgView_.frame = CGRectMake(25,11, 8, 8);
    imgView_.hidden = true;
}
-(void)initHeadView{
    if (_headView) {
        return;
    }
    _headView = [[ALComView alloc]
                 initWithFrame:CGRectMake(0, 0, kScreenWidth, 359/2)];
    [_headView setCustemViewWithType:BothLine_type
                           andTopLineColor:RGB_Line_Gray
                        andBottomLineColor:RGB_Line_Gray];
    _headView.userInteractionEnabled = YES;
    _headView.backgroundColor = HEX(@"#e6c69f");
    __block ALMineViewController * selfBlock  = self;
    __block ALUserDetailModel *_theUserDetailModelBlocke = _theUserDetailModel;
    [_headView setTheViewTouchuBlock:^(id sender){
        //用户是否登录
        if ([[ALLoginUserManager sharedInstance] loginCheck]) {
            [[ALLoginUserManager sharedInstance] getUserInfo:[[ALLoginUserManager sharedInstance] getUserId] andBack:^(ALUserDetailModel *theUserDetailInfo) {
                [selfBlock goToTheViewAboutPersonInfoView:_theUserDetailModelBlocke];
            } andReLoad:NO];
        }
        else{
            [selfBlock goToLoginView];
        }
    }];
    [self.contentView addSubview:_headView];
}
-(void)initTableView{
    _userMainTable=[[ALTableView alloc]
                    initWithFrame:CGRectMake(0, 359/2, kScreenWidth, 91/2*7)];
    _userMainTable.delegate = self;
    _userMainTable.dataSource = self;
    _userMainTable.showsVerticalScrollIndicator = NO;
    _userMainTable.backgroundView = nil;
    _userMainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (IOS7_OR_LATER) {
        [_userMainTable setSeparatorInset:UIEdgeInsetsZero];
    }
    _userMainTable.backgroundColor = [UIColor clearColor];
    
    [self setExtraCellLineHidden:_userMainTable];
    [self.contentView addSubview:_userMainTable];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellInde = @"cellTwo";
    UILabel* lbl_Time;
    MBSetingPersonSubCell *cell= [tableView dequeueReusableCellWithIdentifier:cellInde];
    if (cell == nil) {
        cell = [[MBSetingPersonSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInde];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor =  HEX(@"#efebe8");
        lbl_Time = [[UILabel alloc]init];
        lbl_Time.hidden = true;
        lbl_Time.tag = 10;
        lbl_Time.font = [UIFont systemFontOfSize:10];
        lbl_Time.textAlignment = NSTextAlignmentRight;
        lbl_Time.textColor = HEX(@"#91908e");
        [cell addSubview:lbl_Time];
        lbl_Time.frame = CGRectMake(60, 7, kScreenWidth-70, 30);
    }
    
    lbl_Time = (UILabel*)[cell viewWithTag:10];
    lbl_Time.hidden = true;
    cell.rightImage.hidden = NO;
    cell.rightLabel.text = @"";
    cell.frame = CGRectMake(60, 7, kScreenWidth-70, 30);
    UILabel *view1 = (UILabel *)[cell.contentView viewWithTag:1000000];
    view1.hidden = YES;
    UILabel *view2 = (UILabel *)[cell.contentView viewWithTag:1000001];
    view2.hidden = YES;
    if (indexPath.row==0) {
        cell.leftLabel.text = @"我的钱包";
        if (![[ALLoginUserManager sharedInstance] loginCheck]) {
            cell.rightLabel.text = @"";

  
            cell.rightImage.hidden = NO;
        }else{
            
            
            NSString *tmp = _theUserDetailModel.surplusDays;
            if (tmp.length > 0)
            {
                lbl_Time.hidden = false;
                
                NSString *string = [NSString stringWithFormat:@"%@%@天",@"距离本次服务到期还有",tmp];
               
                NSMutableAttributedString *newStr=[[NSMutableAttributedString alloc] initWithString:string];
                [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(10, tmp.length)];
                lbl_Time.attributedText = newStr;
                cell.rightImage.hidden = YES;
            }
            else
            {
                 lbl_Time.hidden = true;
            }

        }
        
    }
    cell.leftLabel.font = [UIFont systemFontOfSize:12.f];
    cell.rightLabel.font = [UIFont systemFontOfSize:10];
    if (indexPath.row==1)
    {
        cell.leftLabel.text = @"魔法等级";
        if (_theUserDetailModel)
        {
            NSString *level = _theUserDetailModel.magicLeavel;
            if (level.length <= 0)
            {
                level = @"普通会员";
            }
            
            cell.rightImage.hidden = true;
            cell.rightLabel.text = [NSString stringWithFormat:@"%@：%@",level,_theUserDetailModel.magic];
        }

    }
    if (indexPath.row==2) {
        cell.leftLabel.text = @"着装测试";
        cell.rightLabel.text = @"";
    }
    if (indexPath.row==3) {
        cell.leftLabel.text = @"魔法日志";
        cell.rightLabel.text = @"";
    }

    if (indexPath.row==4) {
        cell.leftLabel.text = @"服务指南";
        cell.rightLabel.text = @"";
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        if (![[ALLoginUserManager sharedInstance] loginCheck]) {
            [self goToLoginView];
            return;
        }
        ALMagicBagBuyViewController *myMoney =[[ALMagicBagBuyViewController alloc]init];
        [self.navigationController pushViewController:myMoney animated:YES];
    }
    if (indexPath.row==1) {
        if (![[ALLoginUserManager sharedInstance] loginCheck]) {
            [self goToLoginView];
            return;
        }
        ALMagicValViewController *sysTemDetail = [[ALMagicValViewController alloc]init];
        //        sysTemDetail.messageDataInfoModel = _sysmessageArr[indexPath.row];
        [self.navigationController pushViewController:sysTemDetail animated:YES];
    }
    if (indexPath.row==2) {
        if (![[ALLoginUserManager sharedInstance] loginCheck]) {
           __block ALMineViewController *theBlockCtrl=self;
            ALTestControlViewController *theChildCtrl=[[ALTestControlViewController alloc] init];
            [self.navigationController pushViewController:theChildCtrl animated:YES];
            
            __block ALTestControlViewController * selfBlock = theChildCtrl;
            [theChildCtrl setTheBackBlock:^(id sender){
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

            return;
        }
            NSDictionary *sendDic=@{
                                    @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                                    };
            [DataRequest requestApiName:@"userCenter_getUserCenterData"
                              andParams:sendDic
                              andMethod:Post_type
                           successBlcok:^(id sucContent) {
                               if (sucContent[@"body"][@"result"][@"user"][@"testResult"]&&[sucContent[@"body"][@"result"][@"user"][@"testResult"] length]>0) { //已经测试
                                   ALSetTestViewController *ctrl=[[ALSetTestViewController alloc] init];
                                   ctrl.theUserDetailModel = _theUserDetailModel;
                                   if (sucContent[@"body"][@"result"]) {
                                       ctrl.theUserDetailTest = sucContent[@"body"][@"result"];
                                   }
                                   [self.navigationController pushViewController:ctrl animated:YES];
                               }else{ //没有测试
                                   ALTestControlViewController *theChildCtrl=[[ALTestControlViewController alloc] init];
                                   [self.navigationController pushViewController:theChildCtrl animated:YES];
                               }
                           } failedBlock:^(id failContent) {
                               showFail(failContent);
                           } reloginBlock:^(id reloginContent) {
                           }];
    }
    
    if (indexPath.row==3) {
        if (![[ALLoginUserManager sharedInstance] loginCheck]) {
            [self goToLoginView];
            return;
        }
        ALMagicDailyViewController *ctrl=[[ALMagicDailyViewController alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    if (indexPath.row==4) {
        AlServiceGuildViewController *myGuid =[[AlServiceGuildViewController alloc]init];
        [self.navigationController pushViewController:myGuid animated:YES];
    }
}

#pragma mark loadData
#pragma mark -

@end
