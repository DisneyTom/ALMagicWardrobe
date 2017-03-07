//
//  ALRegistViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-27.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALforgetPDViewController.h"
#import "DataRequest.h"
#import "MBTimerButton.h"
@interface ALforgetPDViewController ()
<UITextFieldDelegate>
@end

@implementation ALforgetPDViewController
{
    ALTextField *phoneTxt;
    MBTimerButton *codeGetBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"找回密码"];
    
    [self _initData];
    
    [self _initView];
}
-(void)_initData{

}
-(void)_initView{
    
    UIView *phoneBackTxt = [[UIView alloc] initWithFrame:CGRectMake(kLeftSpace, 50/2,
                                                                    kScreenWidth-kLeftSpace-kRightSpace, 70/2)];
    [phoneBackTxt setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:phoneBackTxt];
    
    phoneTxt=[[ALTextField alloc]
                           initWithFrame:CGRectMake(kLeftSpace + 8, 50/2,
                                                    kScreenWidth-kLeftSpace-kRightSpace - 16, 70/2)];
    [phoneTxt setPlaceholder:@"请输入你的手机号"];
    [phoneTxt setBackgroundColor:[UIColor whiteColor]];
    [phoneTxt setTag:111];
    [phoneTxt setDelegate:self];
    [self.contentView addSubview:phoneTxt];
    
    
    //输入验证码
    UIView *invalidateBackTxt = [[UIView alloc] initWithFrame:CGRectMake(kLeftSpace, phoneTxt.bottom+32/2,
                                                                         phoneTxt.width/2, phoneTxt.height)];
    [invalidateBackTxt setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:invalidateBackTxt];
    
    ALTextField *codeTxt=[[ALTextField alloc]
                          initWithFrame:CGRectMake(kLeftSpace + 8, phoneTxt.bottom+32/2,
                                                   phoneTxt.width/2 - 16, phoneTxt.height)];
    [codeTxt setPlaceholder:@"输入验证码"];
    [codeTxt setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:codeTxt];
    
    codeGetBtn=[MBTimerButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnX = codeTxt.right+21;
    CGFloat btnWidth = kScreenWidth-btnX-kRightSpace;
    [codeGetBtn setFrame:CGRectMake(btnX, codeTxt.top,
                                    btnWidth, codeTxt.height)];
    [codeGetBtn setTitle:@"获得验证码" forState:UIControlStateNormal];
    [codeGetBtn setTitleColor:colorByStr(@"#917B61") forState:UIControlStateNormal];
    [codeGetBtn.layer setBorderWidth:.5f];
    [codeGetBtn.layer setBorderColor:colorByStr(@"#917B61").CGColor];
    [codeGetBtn addTarget:self action:@selector(codeGet:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:codeGetBtn];
    
    //重新输入密码
    
    UIView *inpoutAgain = [[UIView alloc] initWithFrame:CGRectMake(kLeftSpace, codeGetBtn.bottom+32/2,
                                                                   kScreenWidth-kLeftSpace-kRightSpace, codeTxt.height)];
    [inpoutAgain setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:inpoutAgain];
    
    ALTextField *psdTxt=[[ALTextField alloc]
                         initWithFrame:CGRectMake(kLeftSpace + 8, codeGetBtn.bottom+32/2,
                                                  phoneTxt.width - 16, codeTxt.height)];
    [psdTxt setPlaceholder:@"请输入新密码"];
    [psdTxt setBackgroundColor:[UIColor whiteColor]];
    [psdTxt setSecureTextEntry:YES];
    [self.contentView addSubview:psdTxt];
    
    ALLabel *lbl=[[ALLabel alloc]
                  initWithFrame:CGRectMake(psdTxt.left, psdTxt.bottom, psdTxt.width, 20) andColor:colorByStr(@"#B2B2B2") andFontNum:12];
    [lbl setText:@"(密码由6-16位英文字母，数字或者符号组成)"];
    [self.contentView addSubview:lbl];
    //307,38
    ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake((kScreenWidth-500/2)/2, self.contentView.height-300/4, 500/2, 60/2)];
    [btn setBackgroundImage:[ALImage imageNamed:@"bg04.png"] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTheBtnClickBlock:^(id sender){
        if (!(phoneTxt.text&&phoneTxt.text.length>0)) {
            showWarn(phoneTxt.placeholder);
            return;
        }
        if (!(psdTxt.text&&psdTxt.text.length>0)) {
            showWarn(psdTxt.placeholder);
            return;
        }
        if (!(codeTxt.text&&codeTxt.text.length>0)) {
            showWarn(codeTxt.placeholder);
            return;
        }
        NSDictionary *dic=@{
                            @"userTel":filterStr(phoneTxt.text),
                            @"userPwd":filterStr(psdTxt.text),
                            @"verifyCode":filterStr(codeTxt.text)
                            };
        [DataRequest requestApiName:@"userCenter_fogetPwd"
                          andParams:dic
                          andMethod:Get_type
                       successBlcok:^(id sucContent) {
                           showWarn(@"修改成功");
                           [self.navigationController popViewControllerAnimated:YES];
        } failedBlock:^(id failContent) {
            showFail(failContent);
        } reloginBlock:^(id reloginContent) {
        }];
    }];
    [self.contentView addSubview:btn];
}
#pragma mark 获取手机验证码
-(void)codeGet:(id)sender{
    if (!(phoneTxt.text&&phoneTxt.text.length>0)) {
        showWarn(phoneTxt.placeholder);
        return;
    }
    [codeGetBtn setStart];
    NSDictionary *dic=@{
                        @"userTel":filterStr(phoneTxt.text),
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
