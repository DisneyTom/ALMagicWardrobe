//
//  ALPhoneBindViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALPhoneBindViewController.h"
#import "MBTimerButton.h"

@interface ALPhoneBindViewController ()

@end

@implementation ALPhoneBindViewController{
    ALTextField *phoneBindTextField;
    MBTimerButton *codeGetBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"手机号绑定"];
    
    [self.contentView setBackgroundColor:AL_RGB(236,236,236)];
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(5, 10, kScreenWidth-5-5, 40)];
    [back setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:back];
    
    phoneBindTextField=[[ALTextField alloc]
                                     initWithFrame:CGRectMake(13, 10, kScreenWidth-26, 40)];
    [phoneBindTextField setBackgroundColor:[UIColor whiteColor]];
    [phoneBindTextField setPlaceholder:@"请输入手机号"];
    [self.contentView addSubview:phoneBindTextField];
    [phoneBindTextField setKeyboardType:UIKeyboardTypePhonePad];

    //验证码背景
    UIView *codeback = [[UIView alloc] initWithFrame:CGRectMake(back.left, back.bottom+15, 150, 40)];
    [codeback setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:codeback];
    
    ALTextField *messageCodeTextField=[[ALTextField alloc]
                                       initWithFrame:CGRectMake(phoneBindTextField.left, phoneBindTextField.bottom+15, 150 - 16, 40)];
    [messageCodeTextField setBackgroundColor:[UIColor whiteColor]];
    [messageCodeTextField setPlaceholder:@"输入验证码"];
    [self.contentView addSubview:messageCodeTextField];
    
    codeGetBtn=[MBTimerButton buttonWithType:UIButtonTypeCustom];
    [codeGetBtn setFrame:CGRectMake(codeback.right+5, codeback.top, 177*4/5, 40)];
    [codeGetBtn setTitle:@"获得验证码" forState:UIControlStateNormal];
    [codeGetBtn setTitleColor:colorByStr(@"#917B61") forState:UIControlStateNormal];
    [codeGetBtn.layer setBorderWidth:.5f];
    [codeGetBtn.layer setBorderColor:colorByStr(@"#917B61").CGColor];
    [codeGetBtn addTarget:self action:@selector(codeGet:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:codeGetBtn];

    ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnY = self.view.frame.size.height - 140;
    [okBtn setFrame:CGRectMake(20, btnY, kScreenWidth-40, 40)];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setBackgroundColor:[UIColor grayColor]];
    [okBtn setBackgroundImage:[ALImage imageNamed:@"bg04"] forState:UIControlStateNormal];
    [okBtn setTheBtnClickBlock:^(id sender){
        __block ALUserDetailModel *theModel=nil;
        [[ALLoginUserManager sharedInstance] getUserInfo:[[ALLoginUserManager sharedInstance] getUserId] andBack:^(ALUserDetailModel *theUserDetailInfo) {
            theModel=theUserDetailInfo;
        } andReLoad:NO];
        NSDictionary *sendDic=@{
                                @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                                @"bindTel":filterStr(theModel.theUserModel.usertel),
                                @"verifyCode":filterStr(messageCodeTextField.text)
                                };
        [DataRequest requestApiName:@"userCenter_bindTel" andParams:sendDic andMethod:Get_type successBlcok:^(id sucContent) {
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
    if (!(phoneBindTextField.text&&phoneBindTextField.text.length>0)) {
        showWarn(phoneBindTextField.placeholder);
        return;
    }
    [codeGetBtn setStart];
    NSDictionary *dic=@{
                        @"userTel":filterStr(phoneBindTextField.text),
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
