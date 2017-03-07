//
//  ALTestSetMyWishViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-23.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALTestSetMyWishViewController.h"

@interface ALTestSetMyWishViewController ()
{
    ALSelectView *_birthMonthSelectView;
    ALSelectView *_birthDaySelectView;
    ALSelectView *_statevalSelView;
    ALSelectView *_withvalSelView;
    
    //第一个tip Img
    UIImageView  *_firstTipImg;
    UIImageView  *_secTipImg;
}
@end

@implementation ALTestSetMyWishViewController{
    NSArray *_listWish;
    float _orginY;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"我的心愿"];
    
    [self _initData];
    
    [self _initView];
}

-(void)_initData{
    _orginY=0;
    _listWish=@[
                  @{@"leftTit":@"生日：",
                    @"rightValList":@[@"100",@"200",@"300"],
                    @"initVal":filterStr(self.theUserDetailTest[@"user"][@"birthday"])
                    },
                  @{@"leftTit":@"最近的状态：",
                    @"rightValList":@[@"有喜欢的人",@"工作/学习目标明确",@"换了工作",@"放假",@"享受生活",@"保持常态"],
                    @"initVal":filterStr(self.theUserDetailTest[@"user"][@"status"])
                    },
                  @{@"leftTit":@"最近的心愿：",
                    @"rightValList":@[@"开始恋爱",@"职场新星",@"结交新朋友",@"无所事事的放空",@"重新来过"],
                    @"initVal":filterStr(self.theUserDetailTest[@"user"][@"wish"])
                    }];
}

-(void)_initView{
    float height=140/4+10;
    float width=kScreenWidth-kLeftSpace-kRightSpace;
    
    [_listWish enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic=obj;
        
        
        ALComView *view=[[ALComView alloc]
                         initWithFrame:CGRectMake(kLeftSpace, height*idx, width, height)];
        [self.contentView addSubview:view];
        self.contentView.backgroundColor = AL_RGB(240, 236, 233);
        
        ALLabel *leftLbl=[[ALLabel alloc] initWithFrame:CGRectMake(kLeftSpace, 0, width/2, height)];
        [leftLbl setText:dic[@"leftTit"]];
        [leftLbl setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:leftLbl];
        
        if (idx==0) {
            
            _birthMonthSelectView=[[ALSelectView alloc]
                                   initWithFrame:CGRectMake(
                                                            kLeftSpace+50,
                                                            leftLbl.top,
                                                            70,
                                                            leftLbl.height)];
            [_birthMonthSelectView setSelectType:OcnSelectTypeNormal];
            _birthMonthSelectView.isScrollUp = NO;
            [_birthMonthSelectView setOptions:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
            [view addSubview:_birthMonthSelectView];
            [_birthMonthSelectView setValue:[self.theUserDetailTest[@"user"][@"birthday"] componentsSeparatedByString:@"-"][0]];
            [_birthMonthSelectView setSelectedFont:[UIFont systemFontOfSize:15]];
            
            
            ALLabel *yearLabel=[[ALLabel alloc] initWithFrame:CGRectMake(kLeftSpace+70, leftLbl.top+7, 30, 30)];
            [yearLabel setText:@"月"];
            yearLabel.font = [UIFont systemFontOfSize:15];
            [view addSubview:yearLabel];
            {
                _birthDaySelectView=[[ALSelectView alloc]
                                     initWithFrame:CGRectMake(
                                                              kLeftSpace+100,
                                                              leftLbl.top,
                                                              70,
                                                              leftLbl.height)];
                [_birthDaySelectView setSelectType:OcnSelectTypeNormal];
                _birthDaySelectView.isScrollUp = NO;
                
                [_birthDaySelectView setOptions:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",
                                                  @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",
                                                  @"25",@"26",@"27",@"28",@"29",@"30",@"31"]];
                [view addSubview:_birthDaySelectView];
                [_birthDaySelectView setSelectedFont:[UIFont systemFontOfSize:15]];
                
                NSArray *arr=[self.theUserDetailTest[@"user"][@"birthday"] componentsSeparatedByString:@"-"];
                if (arr.count>1) {
                     [_birthDaySelectView setValue:[self.theUserDetailTest[@"user"][@"birthday"] componentsSeparatedByString:@"-"][1]];
                }
                
                ALLabel *yearLabel=[[ALLabel alloc]
                                    initWithFrame:CGRectMake(kLeftSpace+120, leftLbl.top+7, 30, 30)];
                [yearLabel setText:@"日"];
                [view addSubview:yearLabel];
                yearLabel.font = [UIFont systemFontOfSize:15];
                
                ALImageView *line=[[ALImageView alloc]
                                   initWithFrame:CGRectMake(0, view.height-.5f, view.width, .5f)];
                [line setImage:[ALImage imageNamed:@"model_long_line"]];
                [view addSubview:line];
                _orginY=view.bottom;
            }

        }else{

        
            if (idx==1) {
                
                _statevalSelView=[[ALSelectView alloc]
                                  initWithFrame:CGRectMake(leftLbl.right - 60, 0, width/2, height)];
                [_statevalSelView setSelectType:OcnSelectTypeNormal];
                [view addSubview:_statevalSelView];

                [_statevalSelView changeFont:[UIFont systemFontOfSize:15]];
                [_statevalSelView setSelectedFont:[UIFont systemFontOfSize:14]];
                [_statevalSelView setValue:dic[@"initVal"]];
                _statevalSelView.isScrollUp = NO;
                [_statevalSelView setOptions:dic[@"rightValList"]];
                
                [_statevalSelView setAlignment:UIControlContentHorizontalAlignmentLeft];
//                _statevalSelView.backgroundColor = [UIColor redColor];
                
                _firstTipImg = [[UIImageView alloc] initWithFrame:CGRectMake(_statevalSelView.right + 10, _statevalSelView.top + 10, 20, 20)];
                _firstTipImg.image = [UIImage imageNamed:@"bottom_arrows.png"];
                [view addSubview:_firstTipImg];
                
                
//                _statevalSelView.backgroundColor = [UIColor redColor];
                
            }else if (idx==2){
            
                _withvalSelView=[[ALSelectView alloc]
                                 initWithFrame:CGRectMake(leftLbl.right - 60, 0, width/2, height)];
                [_withvalSelView setSelectType:OcnSelectTypeNormal];
                [view addSubview:_withvalSelView];
                _withvalSelView.selectedFont = [UIFont systemFontOfSize:15];
                [_withvalSelView setSelectedFont:[UIFont systemFontOfSize:14]];
                [_withvalSelView setAlignment:UIControlContentHorizontalAlignmentLeft];
                [_withvalSelView setValue:dic[@"initVal"]];
                _withvalSelView.isScrollUp = NO;
                [_withvalSelView setOptions:dic[@"rightValList"]];
                
                _secTipImg = [[UIImageView alloc] initWithFrame:CGRectMake(_withvalSelView.right + 10, _withvalSelView.top + 10, 20, 20)];
                _secTipImg.image = [UIImage imageNamed:@"bottom_arrows.png"];
                [view addSubview:_secTipImg];
            }
        
        ALImageView *line=[[ALImageView alloc]
                           initWithFrame:CGRectMake(0,
                                                    view.height-.5f,
                                                    view.width,
                                                    .5f)];
        [line setImage:[ALImage imageNamed:@"model_long_line"]];
        [view addSubview:line];
        _orginY=view.bottom;
        }
    }];
    
    __block ALTestSetMyWishViewController *blockSelf = self;
    ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake(40,self.view.size.height - 160, 240, 30)];
    [okBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg.png"]
                     forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [okBtn setTheBtnClickBlock:^(id sender){
        [blockSelf requestTestResult];
    }];
    [self.contentView addSubview:okBtn];
}
-(void)requestTestResult{
    __block ALTestSetMyWishViewController *blockSelf = self;

    NSDictionary *sendDic=@{
                            @"userId":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"id"])),
                            @"height":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"height"])),
                            @"weight":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"weight"])),
                            @"bar_size":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"barSize"])),
                            @"brassiere":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"brassiere"])),
                            @"yaobu":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"yaobu"])),
                            @"tunbu":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"tunbu"])),
                            @"jianbu":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"jianbu"])),
                            @"neck":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"neck"])),
                            @"buttocks":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"buttocks"])),
                            @"shank":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"shank"])),
                            @"thigh":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"thigh"])),
                            @"size":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"size"])),
                            @"habitus":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"habitus"])),
                            @"bust":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"bust"])),
                            @"waistline":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"waistline"])),
                            @"hipline":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"hipline"])),
                            @"shoulder":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"shoulder"])),
                            @"age_group":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"ageGroup"])),
                            @"occupation":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"occupation"])),
                            @"style":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"style"])),
                            @"wish_style":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"wishStyle"])),
                            @"avoid_colour":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"avoidColour"])),
                            @"avoid_pic":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"avoidPic"])),
                            @"avoid_tec":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"avoidTec"])),
                            @"birthday":MBNonEmptyStringNo_([NSString stringWithFormat:@"%@-%@",_birthMonthSelectView.value,_birthDaySelectView.value]),
                            @"status":MBNonEmptyStringNo_(filterStr(_statevalSelView.value)),
                            @"wish":MBNonEmptyStringNo_(filterStr(_withvalSelView.value))
                            };
    
    [DataRequest requestApiName:@"fashionSquare_saveTestResult"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       
                       if(!sucContent[@"body"]||![MBNonEmptyStringNo_(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                           showWarn(@"修改失败");
                           
                       }else{
                           showWarn(@"修改成功");
                           [blockSelf.navigationController popViewControllerAnimated:YES];
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}

@end
