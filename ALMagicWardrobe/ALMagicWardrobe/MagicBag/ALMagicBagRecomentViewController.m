//
//  ALMagicBagRecomentViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicBagRecomentViewController.h"
#import "UIKit+AFNetworking.h"

static float cellHight=125;

#pragma mark ALMagicBagRecomentView
#pragma mark ---
@interface ALMagicBagRecomentView:ALComView
@property(nonatomic,strong) ALTextField *recommentTxt;
@property(nonatomic,strong) NSString *preseStr;
@end
@implementation ALMagicBagRecomentView{
    float _orginY;
    
    ALImageView *_imgView;
        NSMutableArray *_btnMulArr;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:colorByStr(@"#F0EEEA")];
        _imgView=[[ALImageView alloc]
                  initWithFrame:CGRectMake(5,
                                           8,
                                           96,
                                           108)];
        [self addSubview:_imgView];
        _orginY=_imgView.bottom;
        
                NSArray *btnTitArr=@[
                                     @"赞",
                                     @"一般",
                                     @"不好"
                                     ];
                _btnMulArr=[NSMutableArray array];
                [btnTitArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
                    [btn setFrame:CGRectMake(_imgView.right+5+(100/2+20)*idx, _imgView.top+10, 100/2, 37/2)];
                    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                    [btn setTitleColor:colorByStr(@"B0916F") forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                    [btn setBackgroundImage:[ALImage imageNamed:@"praise_bg"] forState:UIControlStateSelected];
                    [btn setBackgroundImage:[ALImage imageNamed:@"nopraise_bg"] forState:UIControlStateNormal];
                    [btn setTitle:obj forState:UIControlStateNormal];
                    [btn setTag:10000+idx];
                    [btn setTheBtnClickBlock:^(id sender){
                        ALButton *theBtn=sender;
                        [_btnMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            ALButton *childBtn=obj;
                            if (childBtn.tag==theBtn.tag) {
                                [childBtn setSelected:YES];
                                self.preseStr=childBtn.titleLabel.text;
                            }else{
                                [childBtn setSelected:NO];
                            }
                        }];
                    }];
                    [self addSubview:btn];
                    _orginY=btn.bottom;
                    [_btnMulArr addObject:btn];
                }];
        _orginY=_imgView.top+10+37/2;
        _recommentTxt=[[ALTextField alloc]
                       initWithFrame:CGRectMake(_imgView.right+5, _orginY+20, 200, 37/2+5)];
        [_recommentTxt setBackgroundColor:[UIColor whiteColor]];
        [_recommentTxt setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:_recommentTxt];
        
        ALLabel *line=[[ALLabel alloc] initWithFrame:CGRectMake(0, self.height-.5f, self.width, .5f)];
        [line setBackgroundColor:[UIColor grayColor]];
        [self addSubview:line];
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic{
    self.preseStr=dic[@"grade"];
    NSString *recomment=dic[@"user_message"];
//
    if (dic[@"grade"])
    {
        [_btnMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            UIButton* btn = _btnMulArr[idx];
            btn.userInteractionEnabled = false;
        }];
    }
//    else
//    {
//        [_btnMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            
//            UIButton* btn = _btnMulArr[idx];
//            btn.userInteractionEnabled = true;
//        }];
//    }
    NSString* stringURL = dic[@"main_image"];
    if (!stringURL)
    {
        stringURL = dic[@"mainImage"];
    }
    [_imgView setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:nil];
        ALButton *theBtn;
        if ([self.preseStr isEqualToString:@"赞"]) {
            theBtn=_btnMulArr[0];
            [theBtn setSelected:YES];
            theBtn.backgroundColor = [UIColor lightGrayColor];
        }else if ([self.preseStr isEqualToString:@"一般"]){
            theBtn=_btnMulArr[1];
           
            [theBtn setSelected:YES];
            //  theBtn.backgroundColor = [UIColor lightGrayColor];
        }else if([self.preseStr isEqualToString:@"不好"]){ //不好
            theBtn=_btnMulArr[2];
            [theBtn setSelected:YES];
           //  theBtn.backgroundColor = [UIColor lightGrayColor];
        }else{
            theBtn.userInteractionEnabled =false;
        }
    
    if (recomment&&recomment.length>0) {
        [_recommentTxt setText:recomment];
        [_recommentTxt setBackgroundColor:[UIColor clearColor]];
        [_recommentTxt setEnabled:NO];
    }else{
        [_recommentTxt setPlaceholder:@"留下你的穿衣感受吧"];
    }
}
@end

#pragma mark ALMagicBagRecomentViewController
#pragma mark ---
@interface ALMagicBagRecomentViewController ()
@end

@implementation ALMagicBagRecomentViewController
{
    NSArray *_listRecommentArr;
    float _orginY;
    NSMutableArray *_recommentTxtArr;
    ALButton *okBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor = colorByStr(@"#F0EEEA");
    [self setTitle:@"评价"];
    
    [self _initData];
    
    [self _initView];
}
-(void)_initData{
    _listRecommentArr=self.arr;
    _orginY=0;
    _recommentTxtArr=[[NSMutableArray alloc] initWithCapacity:2];
}
-(void)_initView{
    [_listRecommentArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALMagicBagRecomentView *theView=[[ALMagicBagRecomentView alloc]
                                         initWithFrame:CGRectMake(0,
                                                                  _orginY,
                                                                  kScreenWidth,
                                                                  cellHight)];
        [theView setTag:1000+idx];
        [theView setDic:_listRecommentArr[idx]];
        [self.contentView addSubview:theView];
        _orginY=theView.bottom;
        [_recommentTxtArr addObject:theView];
    }];
    
    okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake(40, _orginY+20, 240, 30)];
    [okBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg.png"]
                     forState:UIControlStateNormal];
    [okBtn setTitle:@"提交" forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [okBtn setTheBtnClickBlock:^(id sender){
        [self _evaluateAndBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
    [self.contentView addSubview:okBtn];
}

#pragma mark loadData
#pragma mark -
#pragma mark 评价
-(void)_evaluateAndBlock:(void(^)())theBlock{
    ALTextField *oneTxt=[(ALMagicBagRecomentView *)_recommentTxtArr[0] recommentTxt];
    NSString *onePreseStr=[(ALMagicBagRecomentView *)_recommentTxtArr[0] preseStr];
    ALTextField *twoTxt=[(ALMagicBagRecomentView *)_recommentTxtArr[1] recommentTxt];
     NSString *twoPreseStr=[(ALMagicBagRecomentView *)_recommentTxtArr[1] preseStr];
    ALTextField *threeTxt=[(ALMagicBagRecomentView *)_recommentTxtArr[2] recommentTxt];
     NSString *threePreseStr=[(ALMagicBagRecomentView *)_recommentTxtArr[2] preseStr];
    
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"fashionOneId":filterStr(_listRecommentArr[0][@"fashion_id"]),
                            @"gradeOne":filterStr(onePreseStr),
                            @"messageOne":filterStr(oneTxt.text),
                            @"fashionTwoId":filterStr(_listRecommentArr[1][@"fashion_id"]),
                            @"gradeTwo":filterStr(twoPreseStr),
                            @"messageTwo":filterStr(twoTxt.text),
                            @"fashionThreeId":filterStr(_listRecommentArr[2][@"fashion_id"]),
                            @"gradeThree":filterStr(threePreseStr),
                            @"messageThree":filterStr(threeTxt.text),
                            @"expressId":filterStr(self.expressId)
                            };
    [DataRequest requestApiName:@"magicBag_evaluate"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       showWarn(@"评价成功");
                       if (oneTxt.text.length > 0 && twoTxt.text.length > 0 && threeTxt.text.length > 0)
                       {
                           [okBtn setBackgroundColor:AL_RGB(216, 216, 216)];
                           [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                           okBtn.userInteractionEnabled = NO;
                       }
                       if (theBlock) {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}

@end
