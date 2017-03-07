//
//  ALNineProductView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALNineProductView.h"
#import "ALTestModel.h"
#import "ALLine.h"
#import "ALSelectView.h"

@implementation ALNineProductView{
    float _orginLineY;
    float _orginY;
    NSMutableArray *_oneMulBtnArr;
    NSMutableArray *_twoMulBtnArr;
    ALSelectView * _birthMonthSelectView;
    ALSelectView * _birthDaySelectView;
}

-(id)initWithFrame:(CGRect)frame andBackBlock:(BackBlock)theBlock{
    self=[super initWithFrame:frame];
    if (self) {
        self.theBlock=theBlock;
        self.backgroundColor = AL_RGB(240,236,233);
        ALTestModel *theChildModel=[[ALTestModel alloc] init];
        _oneMulBtnArr=[NSMutableArray array];
        _twoMulBtnArr=[NSMutableArray array];

        ALLabel *oneBigLeftTitLbl=[[ALLabel alloc]
                                   initWithFrame:CGRectMake(0.f, 15, 90.f, 15)
                                   andColor:colorByStr(@"#946E3A")
                                   andFontNum:15];
        [oneBigLeftTitLbl setText:@"III 我的心愿"];
        oneBigLeftTitLbl.textAlignment = NSTextAlignmentRight;
        [self addSubview:oneBigLeftTitLbl];
        oneBigLeftTitLbl.font = [UIFont boldSystemFontOfSize:15];
        
        ALLabel *oneBigContentLbl=[[ALLabel alloc]
                                   initWithFrame:CGRectMake(10, oneBigLeftTitLbl.bottom , self.width-10 * 2, 60)
                                   andColor:colorByStr(@"979591")
                                   andFontNum:15];
        [oneBigContentLbl setText:@"填写心愿目标，我们精心选择的服装能助你实现心愿哟！"];
        [oneBigContentLbl setNumberOfLines:0];
        oneBigContentLbl.textAlignment= NSTextAlignmentLeft;
        [self addSubview:oneBigContentLbl];
        
        _orginLineY=oneBigContentLbl.bottom;
        _orginY=oneBigContentLbl.bottom;

        ALLine *line=[[ALLine alloc] initWithFrame:CGRectMake(0, _orginLineY, self.width, 1)];
        [self addSubview:line];
        
        //1
        ALLabel *left1Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(15.f, line.bottom+20, 105, 15) andColor:colorByStr(@"6D6A6B")
                                              andFontNum:12];
        [left1Lbl setText:@"i   你的生日是"];
        [left1Lbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:left1Lbl];
        left1Lbl.textAlignment = NSTextAlignmentLeft;
        _orginY=left1Lbl.bottom;
        
        ALImageView *imageView = [[ALImageView alloc]initWithFrame:CGRectMake(110 + 25,
                                                                              left1Lbl.top - 5,
                                                                              130,
                                                                              25)];
        imageView.image = [UIImage imageNamed:@"input_box"];
        [self addSubview:imageView];
         UIColor *fontColor = AL_RGB(162, 162, 162);
        _birthMonthSelectView=[[ALSelectView alloc]
                                       initWithFrame:CGRectMake(
                                                                kLeftSpace+120,
                                                                left1Lbl.top,
                                                                40,
                                                                left1Lbl.height)];
        [_birthMonthSelectView setSelectType:OcnSelectTypeNormal];
        _birthMonthSelectView.isScrollUp = NO;
        [_birthMonthSelectView changeFont:[UIFont systemFontOfSize:15]];
        [_birthMonthSelectView addTarget:self forVauleChangedaction:@selector(checkTimeSelect:)];
        [_birthMonthSelectView setOptions:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
        [self addSubview:_birthMonthSelectView];
        [_birthMonthSelectView setValue:@" "];
        [_birthMonthSelectView setAlignment:UIControlContentHorizontalAlignmentCenter];
        [_birthMonthSelectView changeFont:[UIFont systemFontOfSize:15]];
        [_birthMonthSelectView titleColor:fontColor];
//        _birthMonthSelectView.backgroundColor = [UIColor redColor];


        ALLabel *yearLabel=[[ALLabel alloc] initWithFrame:CGRectMake(kLeftSpace+165, line.bottom+12, 25, 30)];
        [yearLabel setText:@"月"];
        [yearLabel setFont:[UIFont systemFontOfSize:15]];
        yearLabel.textColor = fontColor;
        [self addSubview:yearLabel];
//        yearLabel.backgroundColor = [UIColor greenColor];
        {
            _birthDaySelectView=[[ALSelectView alloc]
                                           initWithFrame:CGRectMake(
                                                                    kLeftSpace+190,
                                                                    left1Lbl.top,
                                                                    30,
                                                                    left1Lbl.height)];
            [_birthDaySelectView setSelectType:OcnSelectTypeNormal];
            _birthDaySelectView.isScrollUp = NO;
            [_birthDaySelectView changeFont:[UIFont systemFontOfSize:15]];
            [_birthDaySelectView setAlignment:UIControlContentHorizontalAlignmentCenter];
            [_birthDaySelectView setOptions:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",
                                          @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",
                                          @"25",@"26",@"27",@"28",@"29",@"30",@"31"]];
            [self addSubview:_birthDaySelectView];
            [_birthDaySelectView addTarget:self forVauleChangedaction:@selector(checkTimeSelect:)];
            [_birthDaySelectView setValue:@" "];
           
            [_birthDaySelectView titleColor:fontColor];
            
            ALLabel *yearLabel=[[ALLabel alloc] initWithFrame:CGRectMake(kLeftSpace+230, line.bottom+12, 30, 30)];
            [yearLabel setText:@"日"];
            yearLabel.textColor = fontColor;
            [yearLabel setFont:[UIFont systemFontOfSize:15]];
            [self addSubview:yearLabel];
        }
        
//        theChildModel.birthday = [NSString stringWithFormat:@"%@-%@",_birthMonthSelectView.value,_birthDaySelectView.value];
//        self.theBlock(theChildModel);

        NSArray *listArr=@[
                           @{@"你最近的状态":@[@"有喜欢的人",@"工作/学习目标明确",@"换了工作",@"放假",@"享受生活",@"保持常态"]},
                           @{@"你最近的心愿":@[@"开始恋爱",@"职场新星",@"结交新朋友",@"无所事事的放空",@"重新来过"]}
                           ];
        NSArray *indexArr=@[@"ii ",@"iii"];
        
        [listArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx1, BOOL *stop) {
            NSDictionary *dic=obj;
            NSString *key=[dic allKeys][0];
            
            ALLabel *leftLbl=[[ALLabel alloc]
                              initWithFrame:CGRectMake(kLeftSpace, _orginY+20, 110, 15) andColor:colorByStr(@"6D6A6B")
                              andFontNum:12];
            [leftLbl setText:[NSString stringWithFormat:@"%@ %@",indexArr[idx1],key]];
            [leftLbl setFont:[UIFont boldSystemFontOfSize:12]];
            leftLbl.textAlignment = NSTextAlignmentLeft;
            [self addSubview:leftLbl];
            _orginY=leftLbl.bottom;
            
            NSArray *valArr=dic[key];
            float width=(self.width-70)/2;
            [valArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx2, BOOL *stop) {
                ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(35+80*idx2, leftLbl.bottom+20, width, 20)];
                [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
                [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
                [btn setTitle:obj forState:UIControlStateNormal];
                [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTag:10000+idx2];
                [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
                [btn setTheBtnClickBlock:^(id sender){
                    ALButton *theBtn=sender;
                    if (idx1==0) {
                        [_oneMulBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            ALButton *childBtn=obj;
                            if (childBtn.tag==theBtn.tag) {
                                [childBtn setSelected:YES];
                                [theChildModel setStatus:childBtn.titleLabel.text];
                                self.theBlock(theChildModel);
                            }else{
                                [childBtn setSelected:NO];
                            }
                        }];
                    }else{
                        [_twoMulBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            ALButton *childBtn=obj;
                            if (childBtn.tag==theBtn.tag) {
                                [childBtn setSelected:YES];
                                [theChildModel setWish:childBtn.titleLabel.text];
                                self.theBlock(theChildModel);
                            }else{
                                [childBtn setSelected:NO];
                            }
                        }];
                    }
                }];
                
                [self addSubview:btn];
                
//                //设置默认选中
//                if (idx2==0) {
//                    if (idx1==0) {
//                        [btn setSelected:YES];
//                        [theChildModel setStatus:btn.titleLabel.text];
//                    }else if (idx1==1){
//                        [btn setSelected:YES];
//                        [theChildModel setWish:btn.titleLabel.text];
//                    }
//                }
                
                if (idx1==0) {
                    [_oneMulBtnArr addObject:btn];
                }else{
                    [_twoMulBtnArr addObject:btn];
                }
                
                if (idx2/2==0) {
                    if (idx2 == 0)
                    {
                        [btn setFrame:CGRectMake(35+width*idx2,leftLbl.bottom+20*1, width - 10, 20)];
                    }
                    else
                    {
                        [btn setFrame:CGRectMake(35+width*idx2 - 10,leftLbl.bottom+20*1, 15 + width, 20)];
                    }
                    
                }else if (idx2/2==1){
                    CGFloat tmpWidth = width - 10.f;
                    [btn setFrame:CGRectMake(35+tmpWidth*(idx2-2), leftLbl.bottom+20*2+10, tmpWidth + 20, 20)];
                }else{
                    CGFloat tmpWidth = width - 10.f;
                    [btn setFrame:CGRectMake(35+tmpWidth*(idx2-4), leftLbl.bottom+20*3+20, tmpWidth + 20, 20)];
                }
                _orginY=btn.bottom;

            }];
        }];

        ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(40, _orginY + 20, 240, 30)];
        [okBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg.png"] forState:UIControlStateNormal];
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        okBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [okBtn setTheBtnClickBlock:^(id sender){
            if (self.theComitBlock) {
                self.theComitBlock(sender);
            }
        }];
        [self addSubview:okBtn];
        
        ALComView *spaView=[[ALComView alloc]
                            initWithFrame:CGRectMake(0, okBtn.bottom, kScreenWidth, 20)];
        [spaView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:spaView];
        
    }
    return self;
}
-(void)checkTimeSelect:(ALSelectView*)select
{
//    if (_birthMonthSelectView.value.length > 0 || _birthDaySelectView.value.length <= 0) {
//        showWarn(@"请补全你的生日");
//        return;
//    }
    
    ALTestModel *theChildModel=[[ALTestModel alloc] init];
    theChildModel.birthday = [NSString stringWithFormat:@"%@-%@",_birthMonthSelectView.value,_birthDaySelectView.value];
    self.theBlock(theChildModel);

}

@end
