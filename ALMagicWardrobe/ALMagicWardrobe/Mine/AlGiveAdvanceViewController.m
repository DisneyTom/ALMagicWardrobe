//
//  AlGiveAdvanceViewController.m
//  ALMagicWardrobe
//
//  Created by wang on 3/22/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import "AlGiveAdvanceViewController.h"
#import "UIPlaceTextView.h"

@interface AlGiveAdvanceViewController ()<UITextViewDelegate>
{
    UIPlaceTextView* _textView;
}
@end

@implementation AlGiveAdvanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self initViewAbout];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}
- (void)initViewAbout {
    _textView = [[UIPlaceTextView alloc]
                 initWithFrame:CGRectMake(20, 10, kScreenWidth-40, 200)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:14.0];
    _textView.textColor = [UIColor blackColor];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.placeholder = @"请输入您的宝贵意见";
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderColor = [UIColor whiteColor].CGColor;
    _textView.layer.borderWidth = 1;
    [self.contentView addSubview:_textView];
    
    ALLabel*_rightLbl=[[ALLabel alloc]
               initWithFrame:CGRectMake(10, 225, kScreenWidth-20, 40)];
    _rightLbl.text = @"没有你的意见和建议,就没有更好的我们,谢谢你的反馈";
    _rightLbl.adjustsFontSizeToFitWidth = YES;
    [_rightLbl setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_rightLbl];
    
    
    ALButton *sendBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setFrame:CGRectMake(10, 270, kScreenWidth-10-10, 30)];
    [sendBtn setBackgroundColor:[UIColor clearColor]];
    [sendBtn setTitle:@"提交" forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"bg04"] forState:UIControlStateNormal];
    [sendBtn setTheBtnClickBlock:^(id sender){
        [self _saveFeedbackAndBlock:^{
            
        }];
    }];
    [self.contentView addSubview:sendBtn];
}

#pragma mark loadData
#pragma mark -
-(void)_saveFeedbackAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"content":MBNonEmptyString(_textView.text)
                            };
    [DataRequest requestApiName:@"userCenter_saveFeedback" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
        showWarn(@"意见反馈成功");
        [self.navigationController popViewControllerAnimated:YES];
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}


@end
