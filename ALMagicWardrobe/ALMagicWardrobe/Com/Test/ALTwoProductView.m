//
//  ALTwoProductView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALTwoProductView.h"

@implementation ALTwoProductView{
    float _orginY;
    NSMutableArray *_oneMulArr;
    NSMutableArray *_twoMulArr;
    NSMutableArray *_threeMulArr;
    NSMutableArray *_fourMulArr;
    NSMutableArray *_fiveMulArr;
    NSMutableArray *_sixMulArr;
}
-(id)initWithFrame:(CGRect)frame andBackBlock:(BackBlock)theBlock{
    self=[super initWithFrame:frame];
    if (self) {
        self.theBlock=theBlock;
        self.backgroundColor = AL_RGB(240,236,233);
        _oneMulArr=[NSMutableArray array];
        _twoMulArr=[NSMutableArray array];
        _threeMulArr=[NSMutableArray array];
        _fourMulArr=[NSMutableArray array];
        _fiveMulArr=[NSMutableArray array];
        _sixMulArr=[NSMutableArray array];

        ALTestModel *theChildModel=[[ALTestModel alloc] init];

        NSArray *listArr=@[
                           @{@"你的肩部":@[@"较窄",@"适中",@"较宽"]},
                           @{@"你的颈部":@[@"适中",@"修长",@"略粗"]},
                           @{@"你的上臂":@[@"适中",@"修长",@"略粗"]},
                           @{@"你的小腿":@[@"适中",@"修长",@"略粗"]},
                           @{@"你的大腿":@[@"适中",@"修长",@"略粗"]},
                           @{@"你常穿的衣服尺码":@[@"XS",@"S",@"M",@"L",@"XL"]},
                           ];
        NSArray *indexArr=@[@"vi ",@"vii ",@"viii",@"ix ",@"x  ",@"xi "];

        [listArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx1, BOOL *stop) {
            NSDictionary *dic=obj;
            NSString *key=[dic allKeys][0];
            
            CGFloat lblWidth = 85 + 2 * idx1;
            if (idx1 == listArr.count - 1)
            {
                lblWidth = 145.f;
            }
            if (idx1 == 3 || idx1 == 4) {
                lblWidth = 85.f;
            }
            ALLabel *leftLbl=[[ALLabel alloc]
                              initWithFrame:CGRectMake(10.f, _orginY+15, lblWidth, 15) andColor:colorByStr(@"6D6A6B")
                              andFontNum:16];
            [leftLbl setText:[NSString stringWithFormat:@"%@ %@",indexArr[idx1],key]];
//            [leftLbl setFont:[UIFont boldSystemFontOfSize:15]];
            [leftLbl setFont:[UIFont boldSystemFontOfSize:12]];
            [self addSubview:leftLbl];
            leftLbl.textAlignment = NSTextAlignmentLeft;
            _orginY=leftLbl.bottom;

            NSArray *valArr=dic[key];
            float width=(self.width-60)/valArr.count;
            [valArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx2, BOOL *stop) {
                ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(30+width*idx2, leftLbl.bottom+20, width, 20)];
                [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
                [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
                [btn setTitle:obj forState:UIControlStateNormal];
                [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
                [btn setTag:10000+idx2];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];

                [btn setTheBtnClickBlock:^(id sender){
                    ALButton *theBtn=sender;
                    if (idx1==0) {
                        [_oneMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            ALButton *childBtn=obj;
                            if (childBtn.tag==theBtn.tag) {
                                [childBtn setSelected:YES];
                                [theChildModel setJianbu:childBtn.titleLabel.text];
                                self.theBlock(theChildModel);
                            }else{
                                [childBtn setSelected:NO];
                            }
                        }];
                    }else if (idx1==1){
                        [_twoMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            ALButton *childBtn=obj;
                            if (childBtn.tag==theBtn.tag) {
                                [childBtn setSelected:YES];
                                NSString *str=childBtn.titleLabel.text;
                                [theChildModel setNeck:str];
                                self.theBlock(theChildModel);
                            }else{
                                [childBtn setSelected:NO];
                            }
                        }];
                    }else if (idx1==2){
                        [_threeMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            ALButton *childBtn=obj;
                            if (childBtn.tag==theBtn.tag) {
                                [childBtn setSelected:YES];
                                NSString *str=childBtn.titleLabel.text;
                                [theChildModel setButtocks:str];
                                self.theBlock(theChildModel);
                           }else{
                                [childBtn setSelected:NO];
                            }
                        }];
                    }else if (idx1==3){
                        [_fourMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            ALButton *childBtn=obj;
                            if (childBtn.tag==theBtn.tag) {
                                [childBtn setSelected:YES];
                                NSString *str=childBtn.titleLabel.text;
                                [theChildModel setShank:str];
                                self.theBlock(theChildModel);
                            }else{
                                [childBtn setSelected:NO];
                            }
                        }];
                    }else if (idx1==4){
                        [_fiveMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            ALButton *childBtn=obj;
                            if (childBtn.tag==theBtn.tag) {
                                [childBtn setSelected:YES];
                                NSString *str=childBtn.titleLabel.text;
                                [theChildModel setThigh:str];
                                self.theBlock(theChildModel);
                            }else{
                                [childBtn setSelected:NO];
                            }
                        }];
                    }else if (idx1==5){
                        [_sixMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            ALButton *childBtn=obj;
                            if (childBtn.tag==theBtn.tag) {
                                [childBtn setSelected:YES];
                                NSString *str=childBtn.titleLabel.text;
                                [theChildModel setSize:str];
                                self.theBlock(theChildModel);
                            }else{
                                [childBtn setSelected:NO];
                            }
                        }];
                    }else{
                    }
                }];
                [self addSubview:btn];
                //默认值
//                if (idx1==0&&idx2==1) {
//                    [btn setSelected:YES];
//                    NSString *str=btn.titleLabel.text;
//                    [theChildModel setJianbu:str];
//                }else if (idx1==1&&idx2==0){
//                    [btn setSelected:YES];
//                    NSString *str=btn.titleLabel.text;
//                    [theChildModel setNeck:str];
//                }else if (idx1==2&&idx2==0){
//                    [btn setSelected:YES];
//                    NSString *str=btn.titleLabel.text;
//                    [theChildModel setButtocks:str];
//                }else if (idx1==3&&idx2==0){
//                    [btn setSelected:YES];
//                    NSString *str=btn.titleLabel.text;
//                    [theChildModel setShank:str];
//                }else if (idx1==4&&idx2==0){
//                    [btn setSelected:YES];
//                    NSString *str=btn.titleLabel.text;
//                    [theChildModel setThigh:str];
//                }else if (idx1==5&&idx2==2){
//                    [btn setSelected:YES];
//                    NSString *str=btn.titleLabel.text;
//                    [theChildModel setSize:str];
//                }else{
//                }
//                self.theBlock(theChildModel);
               
                if (idx1==0) {
                    [_oneMulArr addObject:btn];
                }else if (idx1==1){
                    [_twoMulArr addObject:btn];
                }else if (idx1==2){
                    [_threeMulArr addObject:btn];
                }else if (idx1==3){
                    [_fourMulArr addObject:btn];
                }else if (idx1==4){
                    [_fiveMulArr addObject:btn];
                }else if (idx1==5){
                    [_sixMulArr addObject:btn];
                }else{
                }
                _orginY=btn.bottom;
            }];
        }];
    }
    return self;
}
@end
