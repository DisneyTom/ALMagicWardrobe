//
//  ALLoginViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALLoginViewController.h"
#import "ALRegistViewController.h"
#import "DataRequest.h"
#import "ALforgetPDViewController.h"

#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

//#import <ShareSDK/ShareSDK.h>

//#import "WeiboSDK.h"

//com.sina.weibo.SNWeiboSDKDemo
#define kAppKey         @"2045436852"
#define kRedirectURI    @"http://www.sina.com"

typedef enum {
WXLogin_type
}theSecondLoginType;

@interface ALLoginViewController ()
<UITextFieldDelegate,
UIAlertViewDelegate>
{
    UIView *_qqView;
    UIView *_weChatView;
    UIView *_alipayView;
    
    //蒙板数组
    NSArray *_thirdMaskArr;
    
    BOOL _isQQ;
    BOOL _isWeChat;
    BOOL _isAlipay;
}

@end
@implementation ALLoginViewController{
    NSArray *_thirdLoginArray;
}
-(void)_initData{
    _thirdLoginArray =@[
                        @{@"loginImg":@"icon020",@"loginName":@"微信"},
                        @{@"loginImg":@"icon021",@"loginName":@"QQ"},
                        @{@"loginImg":@"icon022",@"loginName":@"微博"}
                        ];
}
-(void)_initView{
    
    __block ALLoginViewController  *theCtrl=self;
    
    [self setTitle:@"登录"];
    
    [self.contentView setBackgroundColor:AL_RGB(235,234,229)];
    
    
    
    [self setViewWithType:backBtn_type
                  andView:^(id view) {
                  } andBackEvent:^(id sender) {
                      [theCtrl.navigationController popViewControllerAnimated:YES];
                  }];
    
    ALLabel *titLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(0, 80/2, kScreenWidth, 20) andColor:colorByStr(@"#8F8C89") andFontNum:18];
    [titLbl setText:@"欢迎来到魔法衣橱！"];
    [titLbl setTextAlignment:NSTextAlignmentCenter];
//    [titLbl setFont:[UIFont boldSystemFontOfSize:18]];
    [titLbl setTextColor:AL_RGB(124,122,118)];
    [self.contentView addSubview:titLbl];
    
    ALComView *phoneTextBg=[[ALComView alloc]
                            initWithFrame:CGRectMake(0,
                                                     202/2,
                                                     kScreenWidth,
                                                     79/2)];
    [phoneTextBg setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:phoneTextBg];
    
    ALImageView *phoneImgView=[[ALImageView alloc]
                               initWithFrame:CGRectMake(120/2.0f - 20,
                                                        (phoneTextBg.height-44/2.0)/2.0f,
                                                        44/2.0f,
                                                        44/2.0f)];
    [phoneImgView setImage:[UIImage imageNamed:@"icon018"]];
    [phoneTextBg addSubview:phoneImgView];
    
    ALTextField *phoneTextField = [[ALTextField alloc]
                                   initWithFrame:CGRectMake(phoneImgView.right+5,
                                                            0,
                                                            kScreenWidth-phoneImgView.right + 20,
                                                            phoneTextBg.height)];
    [phoneTextField setTag:101];
    [phoneTextField setDelegate:self];
    [phoneTextField setPlaceholder:@"请输入您的手机号"];
    [phoneTextField setFont:[UIFont systemFontOfSize:16]];
    [phoneTextField setKeyboardType:UIKeyboardTypePhonePad];
    [phoneTextField setBackgroundColor:[UIColor whiteColor]];
    [phoneTextBg addSubview:phoneTextField];
    
    ALComView *passwordTextBg=[[ALComView alloc]
                               initWithFrame:CGRectMake(0,
                                                        phoneTextBg.bottom+1,
                                                        kScreenWidth,
                                                        79/2)];
    [passwordTextBg setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:passwordTextBg];
    
    ALImageView *passwordImgView=[[ALImageView alloc]
                                  initWithFrame:CGRectMake(120/2.0f - 20,
                                                           (passwordTextBg.height-44/2.0)/2.0f,
                                                           44/2.0f,
                                                           44/2.0f)];
    [passwordImgView setImage:[UIImage imageNamed:@"icon019"]];
    [passwordTextBg addSubview:passwordImgView];
    
    ALTextField *passwordTextField = [[ALTextField alloc]
                                      initWithFrame:CGRectMake(passwordImgView.right+5,
                                                               0,
                                                               phoneTextField.width,
                                                               phoneTextField.height)];
    [passwordTextField setTag:102];
    [passwordTextField setDelegate:self];
    [passwordTextField setSecureTextEntry:YES];
    [passwordTextField setPlaceholder:@"请输入密码"];
    [passwordTextField setFont:[UIFont systemFontOfSize:16]];
    [passwordTextField setBackgroundColor:[UIColor whiteColor]];
    [passwordTextBg addSubview:passwordTextField];
    
    ALButton *registBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [registBtn setFrame:CGRectMake(40, passwordTextBg.bottom, 100, 45)];
    [registBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:AL_RGB(63,61,56) forState:UIControlStateNormal];
    [registBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [registBtn setTheBtnClickBlock:^(id sender){
        ALRegistViewController *theCtrl=[[ALRegistViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [self.contentView addSubview:registBtn];
    
    ALButton *fogateBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [fogateBtn setFrame:CGRectMake(kScreenWidth-100-40, registBtn.top, 100, registBtn.height)];
    [fogateBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [fogateBtn setTitleColor:AL_RGB(63,61,56) forState:UIControlStateNormal];
    [fogateBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [fogateBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    [fogateBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [fogateBtn setTheBtnClickBlock:^(id sender){
        ALforgetPDViewController *theCtrl=[[ALforgetPDViewController alloc] init];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }];
    [self.contentView addSubview:fogateBtn];
    
    //登录
    ALButton *loginBtn = [ALButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setFrame:CGRectMake((kScreenWidth-476/2.0f)/2.0f,
                                  passwordTextBg.bottom+108/2, 476/2.0f, 60/2.0f)];
    [loginBtn setTitle:@"登录" forState:0];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"bg04"] forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [loginBtn.layer setCornerRadius:3];
    [loginBtn setTheBtnClickBlock:^(id sender){
        if (!(phoneTextField.text&&phoneTextField.text.length>0)) {
            showWarn(phoneTextField.placeholder);
            return;
 
        }
        if (!(passwordTextField.text&&passwordTextField.text.length>0)) {
            showWarn(passwordTextField.placeholder);
            return;
        }
        NSDictionary *sendDic=@{
                                @"userTel":phoneTextField.text,
                                @"userPwd":passwordTextField.text
                                };
        [DataRequest requestApiName:@"userCenter_login"
                          andParams:sendDic
                          andMethod:Get_type
                       successBlcok:^(id sucContent) {
            if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                showWarn(@"登录失败");
                
            }else{
                showWarn(@"登录成功");
                ALLoginUserManager *userManger = [ALLoginUserManager sharedInstance];
                [userManger setUserId:[sucContent[@"body"][@"result"] stringValue]];
                [userManger setUserBieMing];
                if (self.theBlock) {
                    self.theBlock(nil);
                }
                if (!self.theUpCtrl)
                {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
            
                [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if (self.theUpCtrl==obj) {
                        [self.navigationController popToViewController:self.theUpCtrl animated:YES];
                    }
                }];
            }
        } failedBlock:^(id failContent) {
            showFail(failContent);
        } reloginBlock:^(id reloginContent) {
        }];
    }];
    [self.contentView addSubview:loginBtn];
    
//    UIView *leftLine = [[UIView alloc]
//                             initWithFrame:CGRectMake(0.f,
//                                                      loginBtn.bottom+140/2,
//                                                      100,
//                                                      0.5)];
//    [leftLine setBackgroundColor:AL_RGB(211,196,179)];
//    [self.contentView addSubview:leftLine];
//    
//    ALLabel *otherLoginLabel = [[ALLabel alloc]
//                                initWithFrame:CGRectMake(100,
//                                                         loginBtn.bottom+140/2-24/2,
//                                                         120,
//                                                         24)
//                                Font:12 BGColor:AL_RGB(249, 249, 249)
//                                FontColor:RGB_Font_Second_Title];
//    [otherLoginLabel setTextAlignment:1];
//    [otherLoginLabel setText:@"使用第三方账号登录"];
//    [otherLoginLabel setTextColor:AL_RGB(63,61,56)];
//    [otherLoginLabel setBackgroundColor:[UIColor clearColor]];
//    [self.contentView addSubview:otherLoginLabel];
//    
//    UIView *rightLine = [[UIView alloc]
//                        initWithFrame:CGRectMake(220,
//                                                 loginBtn.bottom+140/2,
//                                                100,
//                                                 0.5)];
//    [rightLine setBackgroundColor:AL_RGB(211,196,179)];
//    [self.contentView addSubview:rightLine];
//    
//    //添加蒙板
//    _qqView = [[UIView alloc]init];
//    _qqView.alpha = 0.8;
//    _qqView.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:_qqView];
//    _qqView.hidden = NO;
//    
//    _weChatView = [[UIView alloc]init];
//    _weChatView.alpha = 0.8;
//    _weChatView.backgroundColor = [UIColor whiteColor];
//    _weChatView.layer.cornerRadius = 30;
//    _weChatView.layer.masksToBounds = YES;
//    [self.contentView addSubview:_weChatView];
//    _weChatView.hidden = NO;
//    
//    _alipayView = [[UIView alloc]init];
//    _alipayView.alpha = 0.8;
//    _alipayView.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:_alipayView];
//    _alipayView.hidden = NO;
//    
//    _isWeChat = [WXApi isWXAppInstalled];
//    _isQQ = [TencentOAuth iphoneQQInstalled];
//    
//    
//    
//    _thirdMaskArr = @[_qqView,_weChatView,_alipayView];
//    
//    for (NSInteger i = 0; i < [_thirdLoginArray count]; i ++) {
//        ALButton *thirdLoginBtn = [ALButton buttonWithType:UIButtonTypeCustom];
//        [thirdLoginBtn setTag:103+i];
//        CGFloat btnX = 130/2+(100/2+40/2)*i;
//        CGFloat btnY = otherLoginLabel.bottom+75/2;
//        [thirdLoginBtn setFrame:CGRectMake(btnX,
//                                          btnY,
//                                          100/2,
//                                           100/2+30)];
//        UIView *view  = _thirdMaskArr[i];
//        view.frame = CGRectMake(btnX, btnY + 5, 50, 45.f);
//        if (_isWeChat && i == 0)
//        {
//            _weChatView.hidden = YES;
//        }
//        if (_isQQ && i == 1)
//        {
//            _qqView.hidden = YES;
//        }
//        if (_isAlipay && i == 2)
//        {
//            _alipayView.hidden = YES;
//        }
////
//
//        [thirdLoginBtn setImage:IMG_WITH_NAME(_thirdLoginArray[i][@"loginImg"])
//                       forState:UIControlStateNormal];
//        [thirdLoginBtn setTitle:_thirdLoginArray[i][@"loginName"]
//                       forState:UIControlStateNormal];
//        [thirdLoginBtn setTitleColor:AL_RGB(63,61,56)
//                            forState:UIControlStateNormal];
//        [thirdLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
//        [thirdLoginBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//        [thirdLoginBtn setAlignment];
//        [thirdLoginBtn setTheBtnClickBlock:^(id sender){
//            UIButton *theBtn=(UIButton *)sender;
//            switch (theBtn.tag) {
//                    //微信登录
//                case 103:
//                {
//                    [self wxLoginAndBlock:^(id sender)
//                     {
//                        [self secondLoginRequest:sender];
//                    }];
//                    break;
//                }
//                    //QQ登录
//                case 104: {
//                    [self qqLoginAndBlock:^(id sender) {
//                        [self secondLoginRequest:sender];
//                    }];
//                    break;
//                }
//                    //微博登录
//                case 105: {
//                    [self wbLoginAndBlock:^(id sender) {
//                        [self secondLoginRequest:sender];
//                    }];
//                    break;
//                }
//                default:
//                    break;
//            }
//        }];
//        [self.contentView addSubview:thirdLoginBtn];
 //   }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initData];
    
    [self _initView];
}

#pragma mark - text view delegate
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag==101) {
        NSMutableString *text = [textField.text mutableCopy];
        [text replaceCharactersInRange:range withString:string];
        return [text length] <= 11;
    }
    else{
        return YES;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITextField *phoneTextField = (UITextField *)[self.view viewWithTag:101];
    UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:102];
    if (phoneTextField.isEditing || passwordTextField.isEditing) {
        [phoneTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];
    }
}
-(void)secondLoginRequest:(NSDictionary *)dic{
    [DataRequest requestApiName:@"userCenter_thirdRegister"
                      andParams:dic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
        if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
            showWarn(@"登录失败");
        }else{
            showWarn(@"登录成功");
            [[ALLoginUserManager sharedInstance]
             setUserId:[sucContent[@"body"][@"result"] stringValue]];
            
            if (!self.theUpCtrl) {
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (self.theUpCtrl==obj) {
                    [self.navigationController popToViewController:self.theUpCtrl animated:YES];
                }
            }];
        }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}
@end

