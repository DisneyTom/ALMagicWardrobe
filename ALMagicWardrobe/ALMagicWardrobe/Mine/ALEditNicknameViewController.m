//
//  ALEditNicknameViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALEditNicknameViewController.h"

@interface ALEditNicknameViewController ()
<UITextFieldDelegate,UIAlertViewDelegate>

@end

@implementation ALEditNicknameViewController{
    NSString *_nickNameStr;
    ALTextField * _nicknameTextField;
    BackNewNickname _theNewNickNameBack;
}

-(void)editName:(NSString *)name andBack:(BackNewNickname)theBack{
    _theNewNickNameBack=theBack;
    _nickNameStr=name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView setBackgroundColor:AL_RGB(235,233,229)];
    
    __weak ALEditNicknameViewController *theCtrl=self;
    
    [self setTitle:@"修改昵称"];
    
    [self setViewWithType:rightBtn1_type
                  andView:^(id view) {
                      ALButton *theBtn=view;
                      [theBtn setTitle:@"保存" forState:UIControlStateNormal];
                      [theBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                      [theBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                  } andBackEvent:^(id sender) {
                      [theCtrl save];
                  }];
    
    ALLabel*_leftLbl=[[ALLabel alloc]
                      initWithFrame:CGRectMake(5, 47/2, 150/2, 40)];
    [_leftLbl setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:_leftLbl];
    _leftLbl.font = [UIFont systemFontOfSize:12.f];
    _leftLbl.text = @"昵称";
    
    //保存
    ALButton *loginBtn = [ALButton buttonWithType:UIButtonTypeCustom];
    CGFloat leftX = (kScreenWidth-500/2.0f)/2.0f;
    CGFloat btnWidth = kScreenWidth - leftX * 2;
    CGFloat btnY = self.view.size.height - 130;
    [loginBtn setFrame:CGRectMake(leftX, btnY, btnWidth, 30.f)];
    [loginBtn setTitle:@"确定" forState:0];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"bg04"] forState:UIControlStateNormal];
    [loginBtn.layer setCornerRadius:3];
    [loginBtn setTheBtnClickBlock:^(id sender){
        
        [theCtrl save];
        
    }];
    [self.contentView addSubview:loginBtn];
    
    UIView *nickNameBack = [[UIView alloc] initWithFrame:CGRectMake(_leftLbl.right+5,
                                                                    _leftLbl.top + 5,
                                                                    330/2,
                                                                    65/2)];
    [nickNameBack setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:nickNameBack];
    
    _nicknameTextField = [[ALTextField alloc]
                          initWithFrame:CGRectMake(_leftLbl.right+13,
                                                   _leftLbl.top + 5,
                                                   330/2 - 16,
                                                   65/2)];
    [_nicknameTextField setDelegate:self];
    [_nicknameTextField setBackgroundColor:[UIColor whiteColor]];
//    [_nicknameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [_nicknameTextField setFont:[UIFont systemFontOfSize:13]];
//    [_nicknameTextField setText:_nickNameStr];
    _nicknameTextField.placeholder = @"请输入你的新昵称";
    [self.contentView addSubview:_nicknameTextField];
    
}

#pragma mark - event
- (void)save {
    if ((_nicknameTextField.text.length <= 0)) {
        showWarn(@"昵称不能为空");
        return;
    }
    NSDictionary *sendDic=@{
                            @"userId":[[ALLoginUserManager sharedInstance] getUserId],
                            @"nickName":filterStr(_nicknameTextField.text)
                            };
    [DataRequest requestApiName:@"userCenter_updateNickName"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
        
        if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
            showWarn(@"修改失败");
            
        }else{
            showWarn(@"修改成功");
            if (_theNewNickNameBack) {
                _theNewNickNameBack(_nicknameTextField.text);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}

#pragma mark - text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITextField *nicknameTextField = (UITextField *)[self.view viewWithTag:101];
    [nicknameTextField resignFirstResponder];
}


@end
