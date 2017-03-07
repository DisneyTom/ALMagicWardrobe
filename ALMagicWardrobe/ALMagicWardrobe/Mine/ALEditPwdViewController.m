//
//  ALEditPwdViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALEditPwdViewController.h"
#import "MBTimerButton.h"
@interface ALEditPwdViewController ()

@end

@implementation ALEditPwdViewController{
    MBTimerButton *codeGetBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"修改密码"];
    
    UIView *oldBack = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-576/2)/2, 47/2, 576/2, 70/2)];
    oldBack.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:oldBack];
    
    
    CGFloat textX = CGRectGetMinX(oldBack.frame) + 8.f;
    CGFloat txtWidth = kScreenWidth - textX * 2;
    ALTextField *oldPwdTextField=[[ALTextField alloc]
                                  initWithFrame:CGRectMake(textX, 47/2, txtWidth, 70/2)];
    [oldPwdTextField setPlaceholder:@" 请输入你的旧密码"];
    [oldPwdTextField setBackgroundColor:[UIColor whiteColor]];
    [oldPwdTextField setSecureTextEntry:YES];
    [self.contentView addSubview:oldPwdTextField];
    
    
    UIView *newPwdBack = [[UIView alloc] initWithFrame:CGRectMake(oldBack.left,
                                                                  oldBack.bottom+35/2,
                                                                  oldBack.width,
                                                                  oldBack.height)];
    newPwdBack.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:newPwdBack];
    
    ALTextField *newPwdTextField=[[ALTextField alloc]
                                  initWithFrame:CGRectMake(textX,  oldBack.bottom+35/2, txtWidth, 70/2)];
    [newPwdTextField setPlaceholder:@" 请输入你的新密码"];
    [newPwdTextField setBackgroundColor:[UIColor whiteColor]];
    [newPwdTextField setSecureTextEntry:YES];
    [self.contentView addSubview:newPwdTextField];
    
    UIView *rePwdBack = [[UIView alloc] initWithFrame:CGRectMake(newPwdBack.left,
                                                                  newPwdBack.bottom+35/2,
                                                                  newPwdBack.width,
                                                                  newPwdBack.height)];
    rePwdBack.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:rePwdBack];
    
    ALTextField *reNewPwdTextField=[[ALTextField alloc]
                                    initWithFrame:CGRectMake(textX,  newPwdBack.bottom+35/2, txtWidth, 70/2)];
    [reNewPwdTextField setPlaceholder:@" 重复你的新密码"];
    [reNewPwdTextField setBackgroundColor:[UIColor whiteColor]];
    [reNewPwdTextField setSecureTextEntry:YES];
    [self.contentView addSubview:reNewPwdTextField];
    
    
    UIView *msgCodeBack = [[UIView alloc] initWithFrame:CGRectMake(rePwdBack.left, rePwdBack.bottom+35/2, 150, rePwdBack.height)];
    msgCodeBack.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:msgCodeBack];
    
    ALTextField *messageCodeTextField=[[ALTextField alloc]
                                       initWithFrame:CGRectMake(rePwdBack.left + 8 , rePwdBack.bottom+35/2, 150 - 8 * 2, rePwdBack.height)];
    [messageCodeTextField setBackgroundColor:[UIColor whiteColor]];
    [messageCodeTextField setPlaceholder:@" 输入验证码"];
    [self.contentView addSubview:messageCodeTextField];
    
    codeGetBtn=[MBTimerButton buttonWithType:UIButtonTypeCustom];
    CGFloat msgCodeX = msgCodeBack.right+5;
    [codeGetBtn setFrame:CGRectMake(msgCodeX, msgCodeBack.top, kScreenWidth - msgCodeX - textX + 8, msgCodeBack.height)];
    [codeGetBtn setTitle:@"获得验证码" forState:UIControlStateNormal];
    [codeGetBtn setTitleColor:colorByStr(@"#917B61") forState:UIControlStateNormal];
    [codeGetBtn.layer setBorderWidth:.5f];
    [codeGetBtn.layer setBorderColor:colorByStr(@"#917B61").CGColor];
    [codeGetBtn addTarget:self action:@selector(codeGet:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:codeGetBtn];
    
    ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake((kScreenWidth-496/2)/2, codeGetBtn.bottom+396/2, 496/2, 56/2)];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setBackgroundColor:[UIColor grayColor]];
    [okBtn setBackgroundImage:[ALImage imageNamed:@"bg04"] forState:UIControlStateNormal];
    [okBtn setTheBtnClickBlock:^(id sender){
        __block ALUserDetailModel *theModel=nil;
        [[ALLoginUserManager sharedInstance]
         getUserInfo:[[ALLoginUserManager sharedInstance] getUserId]
         andBack:^(ALUserDetailModel *theUserDetailInfo) {
             theModel=theUserDetailInfo;
        } andReLoad:NO];
        NSDictionary *sendDic=@{
                                @"userTel":theModel.theUserModel.usertel,
                                @"userPwd":newPwdTextField.text,
                                @"verifyCode":messageCodeTextField.text
                                };
        [DataRequest requestApiName:@"userCenter_fogetPwd" andParams:sendDic andMethod:Get_type successBlcok:^(id sucContent) {
            showWarn(@"修改成功");
            [self.navigationController popViewControllerAnimated:YES];
        } failedBlock:^(id failContent) {
            showFail(failContent);
        } reloginBlock:^(id reloginContent) {
        }];
    }];
    
    [self.contentView addSubview:okBtn];
}
#pragma mark 获取手机验证码
-(void)codeGet:(id)sender{
    [codeGetBtn setStart];
    __block ALUserDetailModel *theModel=nil;
    [[ALLoginUserManager sharedInstance] getUserInfo:[[ALLoginUserManager sharedInstance] getUserId] andBack:^(ALUserDetailModel *theUserDetailInfo) {
        theModel=theUserDetailInfo;
    } andReLoad:NO];
    NSDictionary *dic=@{
                        @"userTel":filterStr(theModel.theUserModel.usertel),
                        @"verType":@"1"
                        };
    [DataRequest requestApiName:@"userCenter_sendSms"
                      andParams:dic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}

@end
