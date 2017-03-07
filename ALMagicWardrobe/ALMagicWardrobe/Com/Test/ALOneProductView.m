//
//  ALOneProductView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALOneProductView.h"
#import "ALTestModel.h"
#import "ALLine.h"

@implementation ALOneProductView{
    float _orginLineY;
    float _orginY;
}
-(id)initWithFrame:(CGRect)frame andBackBlock:(BackBlock)theBlock{
    self=[super initWithFrame:frame];
    if (self) {
        self.theBlock=theBlock;
        self.backgroundColor = AL_RGB(240,236,233);
        ALTestModel *theChildModel=[[ALTestModel alloc] init];
                
        ALLabel *oneBigLeftTitLbl=[[ALLabel alloc]
                                   initWithFrame:CGRectMake(8,
                                                            15,
                                                            self.width-45,
                                                            14)
                                   andColor:colorByStr(@"#946E3A")
                                   andFontNum:15];
        [oneBigLeftTitLbl setText:@"I 我的模形"];
        [self addSubview:oneBigLeftTitLbl];
        oneBigLeftTitLbl.font = [UIFont boldSystemFontOfSize:15];
        
        ALLabel *oneBigContentLbl=[[ALLabel alloc]
                                   initWithFrame:CGRectMake(
                                                            10,
                                                            oneBigLeftTitLbl.bottom + 13,
                                                            self.width-10 * 2,
                                                            55)
                                   andColor:colorByStr(@"979591")
                                   andFontNum:14];
        [oneBigContentLbl setText:@"赶快填写你的体型数据吧，我们将为你精选适合你身材的服装，你可以在任何时候进行修改，所以不要有压力哦！"];
        [oneBigContentLbl setNumberOfLines:0];
        [self addSubview:oneBigContentLbl];
        
        _orginLineY=oneBigContentLbl.bottom+10;

        ALLine *line=[[ALLine alloc]
                      initWithFrame:CGRectMake(0, _orginLineY, self.width, .5f)];
        [self addSubview:line];
        
        //one
        ALLabel *oneLeftLbl=[[ALLabel alloc]
                             initWithFrame:CGRectMake(10.f,
                                                      _orginLineY+25,
                                                      75,
                                                      12)
                             andColor:colorByStr(@"6D6A6B")
                             andFontNum:12];
        [oneLeftLbl setText:@"i   你的身高"];
        [oneLeftLbl setTextAlignment:NSTextAlignmentLeft];
        [oneLeftLbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:oneLeftLbl];
        
        ALSelectView *oneRightSelView=[[ALSelectView alloc]
                                       initWithFrame:CGRectMake(
                                                                75+40,
                                                                oneLeftLbl.top - 5,
                                                                115,
                                                                25)];
        [oneRightSelView setSelectType:OcnSelectTypeNormal];
        oneRightSelView.isScrollUp = NO;
        NSMutableArray *cmArray = [NSMutableArray arrayWithCapacity:2];
        for(int i=150;i<=175;i++){
            [cmArray addObject:[NSString stringWithFormat:@"%dcm",i]];
        }
        [oneRightSelView setOptions:cmArray];
        [oneRightSelView setValue:@"cm"];
        [oneRightSelView setAlignment:UIControlContentHorizontalAlignmentCenter];
        [oneRightSelView setBackgroundColor:[UIColor whiteColor]];
        
        [oneRightSelView setEndDateBack:^(id sender){
            ALSelectView *theView=sender;
            NSString *str=[theView value];
            NSArray *arr= [str componentsSeparatedByString:@"cm"];
            [theChildModel setHeight:arr[0]];
            self.theBlock(theChildModel);
        }];
//        NSString *str=[oneRightSelView value];
//        NSArray *arr= [str componentsSeparatedByString:@"cm"];
//        [theChildModel setHeight:arr[0]];
//        self.theBlock(theChildModel);
        [self addSubview:oneRightSelView];
        
        //two
        ALLabel *twoLeftLbl=[[ALLabel alloc]
                             initWithFrame:CGRectMake(10.f, oneLeftLbl.bottom+20, 75, 12) andColor:colorByStr(@"6D6A6B")
                             andFontNum:12];
        [twoLeftLbl setText:@"ii  你的体重"];
        [twoLeftLbl setTextAlignment:NSTextAlignmentLeft];
        [twoLeftLbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:twoLeftLbl];
        
        ALSelectView *twoRightSelView=[[ALSelectView alloc] initWithFrame:CGRectMake(75+40, twoLeftLbl.top - 5, 115, 25)];
        [twoRightSelView setSelectType:OcnSelectTypeNormal];
        twoRightSelView.isScrollUp = NO;
        NSMutableArray *hiArray = [NSMutableArray arrayWithCapacity:2];
        for(int i=40;i<=65;i++){
            [hiArray addObject:[NSString stringWithFormat:@"%dkg",i]];
        }
        [twoRightSelView setOptions:hiArray];

        [twoRightSelView setValue:@"Kg"];
        [twoRightSelView setBackgroundColor:[UIColor whiteColor]];
        [twoRightSelView setAlignment:UIControlContentHorizontalAlignmentCenter];
        [twoRightSelView setEndDateBack:^(id sender){
            ALSelectView *theView=sender;
            NSString *str=[theView value];
            NSArray *arr= [str componentsSeparatedByString:@"kg"];
            [theChildModel setWeight:arr[0]];
            self.theBlock(theChildModel);
        }];
//        NSString *twoStr=[twoRightSelView value];
//        NSArray *twoArr= [twoStr componentsSeparatedByString:@"kg"];
//        [theChildModel setWeight:twoArr[0]];
//        self.theBlock(theChildModel);
        [self addSubview:twoRightSelView];
        
        //three
        ALLabel *threeLeftLbl=[[ALLabel alloc] initWithFrame:CGRectMake(10.f, twoLeftLbl.bottom+20, 103, 12) andColor:colorByStr(@"6D6A6B")
                                                  andFontNum:12];
        [threeLeftLbl setText:@"iii 你胸衣的尺寸"];
        [threeLeftLbl setFont:[UIFont boldSystemFontOfSize:12]];
        threeLeftLbl.textAlignment = NSTextAlignmentLeft;
        [self addSubview:threeLeftLbl];
        
        ALLabel *threeLeft1Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(10.f, threeLeftLbl.bottom + 20, 75,12) andColor:colorByStr(@"#9c9a96") andFontNum:12];
        [threeLeft1Lbl setText:@"     下胸围"];
        threeLeft1Lbl.textAlignment = NSTextAlignmentLeft;
        [self addSubview:threeLeft1Lbl];
        
        ALSelectView *threeRight1SelView=[[ALSelectView alloc] initWithFrame:CGRectMake(75+40, threeLeft1Lbl.top - 5, 115, 25)];
        [threeRight1SelView setSelectType:OcnSelectTypeNormal];
        {
            NSMutableArray *hiArray = [NSMutableArray arrayWithCapacity:2];
            for(int i=70;i<=105;i++){
                [hiArray addObject:[NSString stringWithFormat:@"%dcm",i]];
            }
            [threeRight1SelView setOptions:hiArray];
        }
        threeRight1SelView.isScrollUp = NO;
        [threeRight1SelView setBackgroundColor:[UIColor whiteColor]];
        [threeRight1SelView setValue:@"cm"];
        [threeRight1SelView setAlignment:UIControlContentHorizontalAlignmentCenter];
        [threeRight1SelView setEndDateBack:^(id sender){
            ALSelectView *theView=sender;
            NSString *str=[theView value];
            [theChildModel setBar_size:str];
            self.theBlock(theChildModel);
        }];
//        [theChildModel setBar_size:threeRight1SelView.value];
//        self.theBlock(theChildModel);
        [self addSubview:threeRight1SelView];
        
        ALLabel *threeLeft2Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(10.f, threeLeft1Lbl.bottom+20,  75, 12) andColor:colorByStr(@"#9c9a96") andFontNum:12];
        [threeLeft2Lbl setText:@"     罩杯"];
        threeLeft2Lbl.textAlignment = NSTextAlignmentLeft;
        [self addSubview:threeLeft2Lbl];
        
        ALSelectView *threeRight2SelView=[[ALSelectView alloc] initWithFrame:CGRectMake(75+40, threeLeft2Lbl.top - 5, 115, 25)];
        [threeRight2SelView setSelectType:OcnSelectTypeNormal];
        threeRight2SelView.isScrollUp = NO;
        [threeRight2SelView setOptions:@[@"AA",@"A",@"B",@"C",@"D",@"E"]];
        [threeRight2SelView setBackgroundColor:[UIColor whiteColor]];
        [threeRight2SelView setValue:@""];
        [threeRight2SelView setAlignment:UIControlContentHorizontalAlignmentCenter];
        [threeRight2SelView setEndDateBack:^(id sender){
            ALSelectView *theView=sender;
            NSString *str=[theView value];
            [theChildModel setBrassiere:str];
            self.theBlock(theChildModel);
        }];
//        [theChildModel setBrassiere:threeRight2SelView.value];
//        self.theBlock(theChildModel);
        [self addSubview:threeRight2SelView];
        [threeRight2SelView setValue:@" "];
        
        //four
        ALLabel *fourLeftLbl=[[ALLabel alloc] initWithFrame:CGRectMake(10, threeLeft2Lbl.bottom+20, 75, 12) andColor:colorByStr(@"6D6A6B")
                                                 andFontNum:12];
        [fourLeftLbl setText:@"iv 你的腰部"];
        [fourLeftLbl setFont:[UIFont boldSystemFontOfSize:12]];
        [fourLeftLbl setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:fourLeftLbl];
        
        NSArray *fourRadioArr=@[@"较细",@"适中",@"较粗"];
        float fourWidth=(self.width-25-25)/fourRadioArr.count;
        NSMutableArray *fourBtnArr=[NSMutableArray array];
        [fourRadioArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(25+fourWidth*idx, fourLeftLbl.bottom+10, fourWidth -10, 20)];
            [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
            [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
            [btn setTag:10000+idx];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [btn setTheBtnClickBlock:^(id sender){
                ALButton *theBtn=sender;
                [fourBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    ALButton *childBtn=obj;
                    if (childBtn.tag==theBtn.tag) {
                        [childBtn setSelected:YES];
                        [theChildModel setYaobu:childBtn.titleLabel.text];
                        self.theBlock(theChildModel);
                    }else{
                        [childBtn setSelected:NO];
                    }
                }];
            }];
            [self addSubview:btn];
//            if (idx==1) {
//                [btn setSelected:YES];
//                [theChildModel setYaobu:btn.titleLabel.text];
//                self.theBlock(theChildModel);
//            }
            _orginY=btn.bottom;
            [fourBtnArr addObject:btn];
        }];
        
        //five
        ALLabel *fiveLeftLbl=[[ALLabel alloc] initWithFrame:CGRectMake(10, _orginY+20, 75, 12) andColor:colorByStr(@"6D6A6B")
                                                 andFontNum:12];
        [fiveLeftLbl setText:@"v  你的臀部"];
        [fiveLeftLbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:fiveLeftLbl];
        [fiveLeftLbl setTextAlignment:NSTextAlignmentLeft];
        _orginY=fiveLeftLbl.bottom;
        
        NSArray *fiveRadioArr=@[@"窄小的",@"翘翘的",@"丰满的"];
        float fiveWidth=(self.width-25-25)/fiveRadioArr.count;
        NSMutableArray *fiveBtnArr=[NSMutableArray array];
        [fiveRadioArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(25+fiveWidth*idx, _orginY+12, fiveWidth, 20)];
            [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
            [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setTag:1000+idx];
             [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
             [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            [btn setTheBtnClickBlock:^(id sender){
                ALButton *theBtn=sender;
                [fiveBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    ALButton *childBtn=obj;
                    if (childBtn.tag==theBtn.tag) {
                        [childBtn setSelected:YES];
                        [theChildModel setTunbu:childBtn.titleLabel.text];
                        self.theBlock(theChildModel);
                    }else{
                        [childBtn setSelected:NO];
                    }
                }];
            }];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
            [self addSubview:btn];
//            if (idx==1) {
//                [btn setSelected:YES];
//                [theChildModel setTunbu:btn.titleLabel.text];
//                self.theBlock(theChildModel);
//            }
            [fiveBtnArr addObject:btn];
        }];
    }
    return self;
}

@end
