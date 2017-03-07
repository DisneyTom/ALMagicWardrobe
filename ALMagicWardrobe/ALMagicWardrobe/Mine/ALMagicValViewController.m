//
//  ALMagicValViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-14.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicValViewController.h"

#import "ALRuleExplainViewController.h"
#import "ALMagicRecordViewController.h"
#import "ALLine.h"

@interface ALMagicValViewController ()
{
    ALUserDetailModel *_theUserDetailInfo;
    NSDictionary *_showDataInfo;
}
@end

@implementation ALMagicValViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"魔法值";
    [self _initData];
}

-(void)_initData{
    if ([[ALLoginUserManager sharedInstance] loginCheck]) {
        [[ALLoginUserManager sharedInstance] getUserInfo:[[ALLoginUserManager sharedInstance] getUserId] andBack:^(ALUserDetailModel *theUserDetailInfo) {
            _theUserDetailInfo = theUserDetailInfo;
            [self _loaduserCenter_magicPageDataDataAndBlock:^{
                [self _initView];

            }];
        } andReLoad:NO];
    }
}
-(void)_loaduserCenter_magicPageDataDataAndBlock:(void(^)())theBlock{
    
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            };
    [DataRequest requestApiName:@"userCenter_magicPageData"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       
                       @try {
                           _showDataInfo = sucContent[@"body"][@"result"];
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

-(void)_initView{
    
    
    ALComView *View = [[ALComView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 330)];
    View.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:View];
    
    ALButton *imgBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setFrame:CGRectMake((kScreenWidth-99)/2, 20, 99, 99)];
    [imgBtn setImage:[ALImage imageNamed:@"magic_point_icon"] forState:UIControlStateNormal];
    [imgBtn setTheBtnClickBlock:^(id sender){
        ALRuleExplainViewController *theCtrl=[[ALRuleExplainViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [View addSubview:imgBtn];
    
   __block float orginy=0;
    
    NSArray *contentArr=@[@"积累魔法值,提升会员等级",
                          @"能够获取更多优惠特权",
                          @"也许你不舍得归还的那条美貌裙子，就真的属于你了哦",
                          @"^_^"];
    
    [contentArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALLabel *lbl=[[ALLabel alloc]
                      initWithFrame:CGRectMake(0,
                                               125+20*idx,
                                               kScreenWidth,
                                               20)
                      andColor:colorByStr(@"#606060")
                      andFontNum:12];
        [lbl setText:contentArr[idx]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [View addSubview:lbl];
        orginy=lbl.bottom;
    }];

    ALLine *line=[[ALLine alloc] initWithFrame:CGRectMake(0, orginy+5, kScreenWidth, .5f)];
    [self.contentView addSubview:line];
    
    ALLabel *lbl=[[ALLabel alloc]
                  initWithFrame:CGRectMake(0,
                                           line.bottom+5,
                                           kScreenWidth,
                                           25)];
    [lbl setText:_theUserDetailInfo.theUserModel.nickname];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    lbl.font =[UIFont systemFontOfSize:13];
    [lbl setTextColor:colorByStr(@"#9C7B45")];
    [View addSubview:lbl];
    orginy=lbl.bottom;
    
    NSArray *txtArray = @[@"会员等级",@"魔法值",@"会员等级"];
    for (int i=0; i<3; i++) {
        ALLabel *lbl=[[ALLabel alloc]
                      initWithFrame:CGRectMake(kScreenWidth/3*i,
                                               orginy+20,
                                               kScreenWidth/3,
                                               30)
                      andColor:colorByStr(@"#9C7B45")
                      andFontNum:16];
        if (i==0) {
            lbl.text = MBNonEmptyString(_showDataInfo[@"magicLeavel"]);
        }
        if (i==1) {
            lbl.text = MBNonEmptyString(_showDataInfo[@"totalMagicValue"]);
        }
        if (i==2) {
            lbl.text = MBNonEmptyString(_showDataInfo[@"nextGrade"]);
        }
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [View addSubview:lbl];
        {
            ALLabel *lbl=[[ALLabel alloc]
                          initWithFrame:CGRectMake(kScreenWidth/3*i,
                                                   295,
                                                   kScreenWidth/3,
                                                   30)];
            [lbl setText:txtArray[i]];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            lbl.font =[UIFont systemFontOfSize:12];
            [View addSubview:lbl];
        
            
        }
        if (i<2) {
            ALImageView *imageViewSpect = [[ALImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3*(i+1), 265, .5f, 57)];
            imageViewSpect.image = [UIImage imageNamed:@"vertical_brown_line.png"];
            [View addSubview:imageViewSpect];
        }
        if (i==2) {
            ALImageView *imageViewSpect = [[ALImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3*(i+1)-50, 245, 49, 21)];
            imageViewSpect.image = [UIImage imageNamed:@"vip_grow_up.png"];
            [View addSubview:imageViewSpect];
            
            ALLabel *lbl=[[ALLabel alloc]
                          initWithFrame:CGRectMake(0,
                                                   0,
                                                   49,
                                                   21)];
            lbl.text = [NSString stringWithFormat:@"再加%@",MBNonEmptyString(_showDataInfo[@"add"])];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            lbl.font =[UIFont systemFontOfSize:10];
            lbl.textColor = [UIColor whiteColor];
            [imageViewSpect addSubview:lbl];
        }
        
    }
    
    ALButton *lookMagicHistoryBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [lookMagicHistoryBtn setFrame:CGRectMake((kScreenWidth-470/2)/2, 380, 470/2, 60/2)];
    [lookMagicHistoryBtn setTitle:@"查看魔法值记录" forState:UIControlStateNormal];
//    [lookMagicHistoryBtn setBackgroundColor:[UIColor redColor]];
    [lookMagicHistoryBtn setBackgroundImage:[UIImage imageNamed:@"bg04"] forState:UIControlStateNormal];

    [lookMagicHistoryBtn setTheBtnClickBlock:^(id sender){
        ALMagicRecordViewController *theCtrl=[[ALMagicRecordViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [self.contentView addSubview:lookMagicHistoryBtn];
}

@end
