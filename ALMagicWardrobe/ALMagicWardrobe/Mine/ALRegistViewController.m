//
//  ALRegistViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-27.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALRegistViewController.h"
#import "DataRequest.h"
#import "MBTimerButton.h"
#import "ALLoginViewController.h"
#import "ALAgreementViewController.h"
#import "UIHyperlinksButton.h"
@interface ALRegistViewController ()

@end

@implementation ALRegistViewController{
    ALTextField *phoneTxt;
    BOOL _hasReadArgenn;
    MBTimerButton *codeGetBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"注册"];
    
    [self _initData];
    
    [self _initView];
}
-(void)_initData{
    _hasReadArgenn=NO;
}
-(void)_initView{
    
    UILabel *phoneBack = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, 50/2, kScreenWidth-kLeftSpace-kRightSpace, 70/2)];
    [phoneBack setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:phoneBack];
    
    phoneTxt=[[ALTextField alloc]
              initWithFrame:CGRectMake(kLeftSpace + 8, 50/2, kScreenWidth-kLeftSpace-kRightSpace - 16, 70/2)];
    [phoneTxt setPlaceholder:@"请输入你的手机号"];
    [phoneTxt setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:phoneTxt];
    
    UILabel *codeBack = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, phoneTxt.bottom+32/2, phoneTxt.width/2, phoneTxt.height)];
    [codeBack setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:codeBack];
    
    ALTextField *codeTxt=[[ALTextField alloc] initWithFrame:CGRectMake(kLeftSpace + 8, phoneTxt.bottom+32/2, phoneTxt.width/2  - 16, phoneTxt.height)];
    [codeTxt setPlaceholder:@"输入验证码"];
    [codeTxt setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:codeTxt];
    
    codeGetBtn=[MBTimerButton buttonWithType:UIButtonTypeCustom];
    CGFloat beginX = codeTxt.right+ 21;
    CGFloat btnWidth = kScreenWidth-beginX-kRightSpace;
    [codeGetBtn setFrame:CGRectMake(beginX, codeTxt.top, btnWidth, codeTxt.height)];
    [codeGetBtn setTitle:@"获得验证码" forState:UIControlStateNormal];
    [codeGetBtn setTitleColor:colorByStr(@"#917B61") forState:UIControlStateNormal];
    [codeGetBtn.layer setBorderWidth:.5f];
    [codeGetBtn.layer setBorderColor:colorByStr(@"#917B61").CGColor];
    [codeGetBtn addTarget:self action:@selector(codeGet:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:codeGetBtn];
    
    UILabel *psdBack = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, codeGetBtn.bottom+32/2, kScreenWidth-kLeftSpace-kRightSpace, codeTxt.height)];
    [psdBack setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:psdBack];
    
    ALTextField *psdTxt=[[ALTextField alloc] initWithFrame:CGRectMake(kLeftSpace +8, codeGetBtn.bottom+32/2, phoneTxt.width - 16, codeTxt.height)];
    [psdTxt setPlaceholder:@"请输入密码"];
    [psdTxt setBackgroundColor:[UIColor whiteColor]];
    [psdTxt setSecureTextEntry:YES];
    [self.contentView addSubview:psdTxt];
    
    ALLabel *lbl=[[ALLabel alloc] initWithFrame:CGRectMake(psdTxt.left, psdTxt.bottom, psdTxt.width, 20) andColor:colorByStr(@"#B2B2B2") andFontNum:12];
    [lbl setText:@"(密码由6-16位英文字母，数字或者符号组成)"];
    [self.contentView addSubview:lbl];
    //307,38
    ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake((kScreenWidth-500/2)/2, self.contentView.height-300/4-30, 500/2, 60/2)];
    [btn setBackgroundImage:[ALImage imageNamed:@"bg04.png"] forState:UIControlStateNormal];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn setTheBtnClickBlock:^(id sender){
        if (!_hasReadArgenn) {
            showWarn(@"请先阅读用户协议");
            return;
        }
        btn.userInteractionEnabled  = NO;
        showRequest;
        NSDictionary *dic=@{
                            @"userTel":phoneTxt.text,
                            @"userPwd":psdTxt.text,
                            @"verifyCode":codeTxt.text
                            };
        
        [DataRequest requestApiName:@"userCenter_register"
                          andParams:dic
                          andMethod:Get_type
                       successBlcok:^(id sucContent) {
                           hideRequest;
                           showWarn(@"注册成功");
                           
                           ALLoginUserManager *userManager = [ALLoginUserManager sharedInstance];
                           [userManager setUserId:[sucContent[@"body"][@"result"] stringValue]];
                           [userManager setUserBieMing];
                           [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                               if ([obj isKindOfClass:[ALLoginViewController class]]) {
                                   [self.navigationController popToViewController:obj animated:YES];
                               }
                           }];
                           [[NSNotificationCenter defaultCenter] postNotificationName:SIGNUPBACKNOTI object:nil];
                           btn.userInteractionEnabled = YES;
        } failedBlock:^(id failContent) {
            showFail(failContent);
            btn.userInteractionEnabled = YES;
            hideRequest;
        } reloginBlock:^(id reloginContent) {
            btn.userInteractionEnabled = YES;
            hideRequest;
        }];
    }];
    [self.contentView addSubview:btn];
    
    ALButton *selBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [selBtn setFrame:CGRectMake(btn.left, btn.bottom+10, 20, 20)];
    [selBtn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
    [selBtn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
    [selBtn setTheBtnClickBlock:^(id sender){
        ALButton *theBtn=sender;
        theBtn.selected=!theBtn.selected;
        _hasReadArgenn=theBtn.selected;
    }];
    [selBtn setSelected:YES];
    _hasReadArgenn=selBtn.selected;
    [self.contentView addSubview:selBtn];
    
    NSString *str1=@"我已阅读并接受";
    NSString *str2=@"用户协议";
    CGSize size1=[ALComAction getSizeByStr:str1
                                  andFont:[UIFont systemFontOfSize:28/2]];
    CGSize size2=[ALComAction getSizeByStr:str2
                                   andFont:[UIFont systemFontOfSize:28/2]];
    ALLabel *leftLbl=[[ALLabel alloc] initWithFrame:CGRectMake(selBtn.right+5, btn.bottom+10, size1.width, 20)];
    [leftLbl setText:str1];
    [leftLbl setFont:[UIFont systemFontOfSize:28/2]];
    [self.contentView addSubview:leftLbl];
    
//    UIHyperlinksButton *registLinkBtn=[UIHyperlinksButton buttonWithType:UIButtonTypeCustom];
    

    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:str2];
    NSRange contentRange = {0,[str2 length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    UILabel *registLinkBtn = [[UILabel alloc] initWithFrame:CGRectZero];
    [registLinkBtn setFrame:CGRectMake(leftLbl.right, btn.bottom+10, size2.width, 20)];
    [registLinkBtn setTextColor:leftLbl.textColor];
    [registLinkBtn setFont:[UIFont systemFontOfSize:14]];
    [registLinkBtn setUserInteractionEnabled:YES];
    registLinkBtn.attributedText = content;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_agreement)];
    [registLinkBtn addGestureRecognizer:tap];
    [self.contentView addSubview:registLinkBtn];

}
-(void)_agreement{
    ALAgreementViewController *theCtrl=[[ALAgreementViewController alloc] init];
    [self.navigationController pushViewController:theCtrl animated:YES];

}
#pragma mark 获取手机验证码
-(void)codeGet:(id)sender{
    if (!(phoneTxt.text&&[phoneTxt.text length]>0)) {
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
