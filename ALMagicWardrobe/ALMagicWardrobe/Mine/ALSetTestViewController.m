//
//  ALSetTestViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-23.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALSetTestViewController.h"
#import "ALLine.h"
#import "ALTestSetModelViewController.h"
#import "ALTestSetCustomViewController.h"
#import "ALTestSetMyWishViewController.h"

@interface ALSetTestViewController ()

@end

@implementation ALSetTestViewController{
    ALLabel *headLbl;
    ALImageView *nextGoImgView;
    ALButton *clickBtn;
    UIImageView *oneLine;
    
    NSMutableAttributedString *_mulAttStr;

    ALImageView *contentImgView;
    ALLabel *upContentLbl;
    ALLabel *towContentLbl;
    ALLine *twoLine;
    ALLabel *downContentLbl;
    ALButton *upBtn;
    ALButton *downBtn;
}
-(void)_reloadLocation{
    
    NSAttributedString *head = headLbl.attributedText;
    
    CGSize size1=[ALComAction adjustSizeWithAttributedString:head maxWidth:260 numberLine:200];
    
//    CGSize headSize = [ALComAction getSizeByStr:head.string andFont:[UIFont systemFontOfSize:12] andRect:CGSizeMake(260, 0.f)];
    headLbl.frame = CGRectMake(15,
                               15,
                               260,size1.height);
    nextGoImgView.frame = CGRectMake(headLbl.right, size1.height /2, 24, 24);
    clickBtn.frame = CGRectMake(15,
                                15,
                                260,size1.height);
    CGFloat lineY = CGRectGetMaxY(headLbl.frame) + 10;
    oneLine.frame = CGRectMake(15, lineY, 290, 1);
    
    contentImgView.frame = CGRectMake(15, oneLine.bottom+10, kScreenWidth-30, 532/2);
    
    CGFloat lablWidth = contentImgView.width - 10;
    CGSize size=[ALComAction adjustSizeWithAttributedString:_mulAttStr maxWidth:lablWidth numberLine:200];

    
    [upContentLbl setFrame:CGRectMake(5, 10, lablWidth, size.height + 15)];
    DLog(@"upContentText is %@",upContentLbl.text);
//    [upContentLbl setVerticalAlignment:VerticalAlignmentTop];
    [twoLine setFrame:CGRectMake(5, upContentLbl.bottom+10, lablWidth, 1.f)];
    
    NSAttributedString *down = downContentLbl.attributedText;
    
    CGSize downSize =[ALComAction adjustSizeWithAttributedString:down maxWidth:260 numberLine:200];
    [downContentLbl setFrame:CGRectMake(5, twoLine.bottom+10, lablWidth, downSize.height + 15)];
    DLog(@"upContentText is %@",downContentLbl.text);
    DLog(@"downSize is %f",downSize.height);
    
    CGFloat downImageY = downContentLbl.bottom;
    if (downContentLbl.attributedText.length <= 0) {
        downImageY = downImageY + 50;
    }
    
    [contentImgView setHeight:downImageY];

    CGFloat upY = contentImgView.bottom+50/2;
    if (upY < 375) {
        upY = 375.f;
    }
    [upBtn setFrame:CGRectMake((kScreenWidth-470/2)/2, upY, 470/2, 60/2)];
    [downBtn setFrame:CGRectMake((kScreenWidth-470/2)/2, upBtn.bottom+10, 470/2, 60/2)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"着装测试"];
    
    [self _initView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self _loadTestDetailAndBlock:^{
        //
        NSString *str=[NSString stringWithFormat:@"%@,希望%@,想要尝试%@",_theUserDetailModel.theUserModel.nickname,MBNonEmptyStringNo_(_theUserDetailTest[@"user"][@"wish"]),MBNonEmptyStringNo_(_theUserDetailTest[@"user"][@"wishStyle"])];
        NSMutableAttributedString *newStr=[[NSMutableAttributedString alloc] initWithString:str];
        [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, newStr.length)];
        [newStr addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#C4915F") range:NSMakeRange(0, _theUserDetailModel.theUserModel.nickname.length)];
        [newStr addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#616161") range:NSMakeRange(_theUserDetailModel.theUserModel.nickname.length, newStr.length-_theUserDetailModel.theUserModel.nickname.length)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:5];
        [newStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, newStr.length)];
        [headLbl setAttributedText:newStr];
        [self.contentView addSubview:headLbl];
        
        //
        NSArray *arrayTest = [MBNonEmptyStringNo_(_theUserDetailTest[@"user"][@"testResult"]) componentsSeparatedByString:@";"];
        if (arrayTest.count>=1&&[arrayTest[0] length]>4) {
            NSString *str=[NSString stringWithFormat:@"你知道吗，%@\n\n%@",MBNonEmptyStringEXPNull(arrayTest[0]),MBNonEmptyStringEXPNull(arrayTest[1])];
            _mulAttStr=[[NSMutableAttributedString alloc] initWithString:str];
            [_mulAttStr addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#686868") range:NSMakeRange(0, 4)];
            [_mulAttStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 4)];
             [_mulAttStr addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#676767") range:NSMakeRange(4, _mulAttStr.length-4)];
            [_mulAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4, _mulAttStr.length-4)];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:5];
            [_mulAttStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _mulAttStr.length)];
            
            [upContentLbl setAttributedText:_mulAttStr];
        }
        
        //
        if (arrayTest.count>=2&&[arrayTest[2] length]>4) {
            NSString *str=[NSString stringWithFormat:@"扬长避短的细节：%@",MBNonEmptyStringEXPNull(arrayTest[2])];
            NSMutableAttributedString *newStr=[[NSMutableAttributedString alloc] initWithString:str];
            
            [newStr addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#686868") range:NSMakeRange(0, 8)];
            [newStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 8)];
            [newStr addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#676767") range:NSMakeRange(8, [arrayTest[2] length]-8)];
            [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(8, newStr.length -8)];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:5];
            [newStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, newStr.length)];
            [downContentLbl setAttributedText:newStr];
        }
        else
        {
            [downContentLbl setAttributedText:[[NSMutableAttributedString alloc] initWithString:@""]];
        }
        
        [self _reloadLocation];
    }];
}
-(void)_initView{
    headLbl=[[ALLabel alloc]
                      initWithFrame:CGRectMake(15,
                                               15,
                                               260,
                                               120/2)];
    [headLbl setNumberOfLines:0];
    [headLbl setFont:[UIFont systemFontOfSize:12]];
    
    nextGoImgView=[[ALImageView alloc]
                                initWithFrame:CGRectMake(headLbl.right, (120/2-27)/2, 26, 27)];
    [nextGoImgView setImage:[ALImage imageNamed:@"icon_next"]];
    [self.contentView addSubview:nextGoImgView];
    
    __weak typeof(self) _self = self;
    clickBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [clickBtn setFrame:CGRectMake(15, 15,260, 120/2)];
    [clickBtn setTheBtnClickBlock:^(id sender){
        [_self _loadTestDetailAndBlock:^{
            ALTestSetMyWishViewController *theCtrl=[[ALTestSetMyWishViewController alloc] init];
            theCtrl.theUserDetailTest = _theUserDetailTest;
            [self.navigationController pushViewController:theCtrl animated:YES];
        }];
    }];
    [self.contentView addSubview:clickBtn];
    
    oneLine=[[UIImageView alloc]
                   initWithFrame:CGRectMake(15, 120/2, kScreenWidth-30, 1.f)];
    oneLine.image = [UIImage imageNamed:@"oneLineSperate.png"];
    [self.contentView addSubview:oneLine];
    
    contentImgView=[[ALImageView alloc]
                                 initWithFrame:CGRectMake(15, oneLine.bottom+10, kScreenWidth-30, 532/2)];
    [contentImgView setImage:[ALImage imageNamed:@"finish_bg"]];
    [self.contentView addSubview:contentImgView];
    
    upContentLbl=[[ALLabel alloc]
                           initWithFrame:CGRectMake(5, 10, contentImgView.width-5-5, 640/4) andColor:[UIColor grayColor] andFontNum:14];
    [upContentLbl setNumberOfLines:25];
    [contentImgView addSubview:upContentLbl];
    
    twoLine=[[ALLine alloc]
                     initWithFrame:CGRectMake(5, 328/2+20, contentImgView.width-5-5, .5)];
    [contentImgView addSubview:twoLine];
    
    downContentLbl=[[ALLabel alloc]
                    initWithFrame:CGRectMake(5, twoLine.bottom+5, contentImgView.width-5-5, 380/4)
                    andColor:[UIColor grayColor]
                    andFontNum:14];
    [downContentLbl setVerticalAlignment:VerticalAlignmentTop];
    [downContentLbl setNumberOfLines:0];
    [contentImgView addSubview:downContentLbl];
    
    upBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [upBtn setFrame:CGRectMake((kScreenWidth-470/2)/2, contentImgView.bottom+50/2, 470/2, 60/2)];
    [upBtn setTitle:@"修改我的模形" forState:UIControlStateNormal];
//    [upBtn setBackgroundImage:[ALImage imageNamed:@"btn_magic_room"] forState:UIControlStateHighlighted];
    [upBtn setBackgroundImage:[ALImage imageNamed:@"btn_magic_room"] forState:UIControlStateNormal];
    [upBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    upBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    __weak typeof(self) _self = self;
    [upBtn setTheBtnClickBlock:^(id sender){
        [_self _loadTestDetailAndBlock:^{
            ALTestSetModelViewController *theCtrl=[[ALTestSetModelViewController alloc] init];
            theCtrl.theUserDetailTest = _theUserDetailTest;
            [self.navigationController pushViewController:theCtrl animated:YES];
        }];
    }];
    [self.contentView addSubview:upBtn];
    
    downBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [downBtn setFrame:CGRectMake((kScreenWidth-470/2)/2, upBtn.bottom+10, 470/2, 60/2)];
    [downBtn setTitle:@"修改我的风格" forState:UIControlStateNormal];
//    [downBtn setBackgroundImage:[ALImage imageNamed:@"btn_magic_room"] forState:UIControlStateHighlighted];
    [downBtn setBackgroundImage:[ALImage imageNamed:@"btn_wardrobe"] forState:UIControlStateNormal];
    [downBtn setTitleColor:colorByStr(@"#A98160") forState:UIControlStateNormal];
    downBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [downBtn setTheBtnClickBlock:^(id sender){
        [_self _loadTestDetailAndBlock:^{
            ALTestSetCustomViewController *theCtrl=[[ALTestSetCustomViewController alloc] init];
            theCtrl.theUserDetailTest = _theUserDetailTest;
            
            [self.navigationController pushViewController:theCtrl animated:YES];
        }];
    }];
    [self.contentView addSubview:downBtn];
}
-(void)_loadTestDetailAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr(_theUserDetailModel.theUserModel.userId)
                            };
    [DataRequest requestApiName:@"userCenter_getUserCenterData"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       if (sucContent[@"body"][@"result"][@"user"][@"testResult"]&&[sucContent[@"body"][@"result"][@"user"][@"testResult"] length]>0) { //已经测试
                           if (sucContent[@"body"][@"result"]) {
                               self.theUserDetailTest = sucContent[@"body"][@"result"];
                           }
                           if (theBlock) {
                               theBlock();
                           }
                       }else{ //没有测试
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                       if (theBlock) {
                           theBlock();
                       }
                   } reloginBlock:^(id reloginContent) {
                       if (theBlock) {
                           theBlock();
                       }
                   }];
}
@end
