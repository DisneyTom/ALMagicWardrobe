//
//  ALMagicWardrobeFirstEnterView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-23.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicWardrobeFirstEnterView.h"
#import "ALLine.h"

@interface ALMagicWardrobeListLbl : ALComView
-(void)setTit:(NSString *)tit;
@end
@implementation ALMagicWardrobeListLbl{
    ALLabel *_rightLbl;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _rightLbl=[[ALLabel alloc] initWithFrame:CGRectZero];
        [_rightLbl setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:_rightLbl];
    }
    return self;
}
-(void)layoutSubviews{
    [_rightLbl setFrame:CGRectMake(40, 0, self.width-40, self.height)];
}
-(void)setTit:(NSString *)tit{
    NSMutableAttributedString *newStr=[[NSMutableAttributedString alloc] initWithString:tit];
    [newStr addAttribute:NSForegroundColorAttributeName
                   value:AL_RGB(138,99,54)
                   range:NSMakeRange(0, 1)];
    [newStr addAttribute:NSFontAttributeName
                   value:[UIFont boldSystemFontOfSize:15]
                   range:NSMakeRange(0, 1)];
    [newStr addAttribute:NSForegroundColorAttributeName value:AL_RGB(53, 53, 53) range:NSMakeRange(1, newStr.length-1)];
    [newStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(1, newStr.length-1)];
//    [_rightLbl setText:tit];
    [_rightLbl setAttributedText:newStr];
}
@end
@implementation ALMagicWardrobeFirstEnterView
-(id)initWithFrame:(CGRect)frame andBackBlock:(void(^)(id sender))theBlock{
    self=[super initWithFrame:frame];
    if (self) {
        ALImageView *imgView=[[ALImageView alloc]
                              initWithFrame:CGRectMake(30/2,
                                                       77/2,
                                                       kScreenWidth-30/2*2,
                                                       570/2)];
        [imgView setImage:[ALImage imageNamed:@"finish_bg"]];
        [self setHeight:imgView.bottom];
        [self addSubview:imgView];
        
        ALLabel *titLbl=[[ALLabel alloc]
                         initWithFrame:CGRectMake(30, 20, imgView.width-30-30, 20)];
        [titLbl setText:@"你知道吗"];
        [titLbl setFont:[UIFont boldSystemFontOfSize:13]];
        //[titLbl setTextColor:AL_RGB(67,67,67)];
        [titLbl setTextColor:colorByStr(@"#9B7D56")];
        
        [imgView addSubview:titLbl];
        
        ALLabel *subTitLbl=[[ALLabel alloc]
                            initWithFrame:CGRectMake(30, titLbl.bottom+5, imgView.width-30-30, 20)];
        [subTitLbl setText:@"女孩子的身材一般有五种哦"];
        [subTitLbl setFont:[UIFont systemFontOfSize:13]];
//        [subTitLbl setTextColor:AL_RGB(53, 53, 53)];
        [subTitLbl setTextColor:colorByStr(@"#9B7D56")];
        [imgView addSubview:subTitLbl];
        
        ALImageView *lineImgView=[[ALImageView alloc]
                                  initWithFrame:CGRectMake(5, 160/2, imgView.width-5-5, 6)];
        [lineImgView setImage:[ALImage imageNamed:@"halving_line"]];
        [imgView addSubview:lineImgView];
        
        NSArray *arr=@[
                       @"X 型是最女神的性感身材",
                       @"H 型最能做出有范儿造型",
                       @"O 型分分钟变身日系萌妹子",
                       @"A 型穿上大摆裙就是赫本再造",
                       @"Y 型说一不二欧美风轻松搞定"
                       ];
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALMagicWardrobeListLbl *lbl=[[ALMagicWardrobeListLbl alloc] initWithFrame:CGRectMake(-8, lineImgView.bottom+30*idx, subTitLbl.width, 30)];
            [lbl setTit:obj];
            [imgView addSubview:lbl];
        }];
        
        ALLine *line=[[ALLine alloc] initWithFrame:CGRectMake(0, 476/2, imgView.width, 1)];
        [imgView addSubview:line];
        
        ALLabel *bottomLbl=[[ALLabel alloc] initWithFrame:CGRectMake(30, line.bottom+5, imgView.width - 30, 30) andColor:[UIColor grayColor] andFontNum:12];
        [bottomLbl setText:@"想知道你是哪一型？欢迎进入着装测试~"];
        [bottomLbl setTextAlignment:NSTextAlignmentLeft];
//        bottomLbl.backgroundColor = [UIColor redColor];
        [imgView addSubview:bottomLbl];
        
        ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
        okBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [okBtn setFrame:CGRectMake(40, 401, 240, 30)];
        [okBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [okBtn setTitle:@"测试" forState:UIControlStateNormal];
        [okBtn setTheBtnClickBlock:^(id sender){
            if (theBlock) {
                theBlock(sender);
            }
        }];
        [self addSubview:okBtn];
        
        [self setHeight:okBtn.bottom+10];
    }
    
    return self;
}

@end
