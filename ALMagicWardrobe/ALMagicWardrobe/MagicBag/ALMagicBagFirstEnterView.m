//
//  ALMagicBagFirstEnterView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-20.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicBagFirstEnterView.h"
#import "ALLoginUserManager.h"
#import "ALLine.h"

@implementation ALListLbl{
    ALImageView *_leftImgView;
    ALLabel *_rightLbl;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _leftImgView=[[ALImageView alloc] initWithFrame:CGRectZero];
        [_leftImgView setImage:[ALImage imageNamed:@"icon_brown_dot"]];
        [self addSubview:_leftImgView];
        
        _rightLbl=[[ALLabel alloc] initWithFrame:CGRectZero];
        [_rightLbl setFont:[UIFont systemFontOfSize:11]];
        [_rightLbl setNumberOfLines:0];
        [_rightLbl setTextColor:AL_RGB(64, 64, 64)];
        [self addSubview:_rightLbl];
    }
    return self;
}
-(void)layoutSubviews{
    [_leftImgView setFrame:CGRectMake(54/2, (self.height-13)/2, 13, 13)];
    [_rightLbl setFrame:CGRectMake(_leftImgView.right+5, 0, self.width-_leftImgView.right-54/2, self.height)];
}
-(void)setTit:(NSString *)tit{
    [_rightLbl setText:tit];
}
@end
@implementation ALMagicBagFirstEnterView
-(id)initWithFrame:(CGRect)frame andBackBlock:(void(^)(id sender))theBlock{
    self=[super initWithFrame:frame];
    if (self) {
        ALImageView *imgView=[[ALImageView alloc]
                              initWithFrame:CGRectMake(35/2,
                                                       82/2,
                                                       kScreenWidth-35/2-35/2,
                                                       620/2)];
        [imgView setImage:[ALImage imageNamed:@"finish_bg"]];
        [self addSubview:imgView];
        
        ALLabel *titLbl=[[ALLabel alloc]
                         initWithFrame:CGRectMake(54/2, 20, imgView.width-54/2*2, 20)
                         andColor:AL_RGB(124,84,1)
                         andFontNum:13];
        [titLbl setText:@"拥有全场所有衣物使用权"];
        [titLbl setFont:[UIFont systemFontOfSize:13]];
        [titLbl setTextColor:colorByStr(@"#9B7D56")];
        
        [imgView addSubview:titLbl];
        
        ALLabel *subTitLbl=[[ALLabel alloc]
                            initWithFrame:CGRectMake(titLbl.left, titLbl.bottom, titLbl.width, 20)
                            andColor:AL_RGB(124,84,1)
                            andFontNum:13];
        [subTitLbl setText:@"每月不限次不限时领取魔法包"];
        [subTitLbl setFont:[UIFont systemFontOfSize:13]];
        [subTitLbl setTextColor:colorByStr(@"#9B7D56")];
        [imgView addSubview:subTitLbl];
        
        ALImageView *lineImgView=[[ALImageView alloc]
                                  initWithFrame:CGRectMake(0,
                                                           164/2,
                                                           imgView.width,
                                                           6)];
        [lineImgView setImage:[ALImage imageNamed:@"halving_line"]];
        [imgView addSubview:lineImgView];
        
        NSArray *arr=@[
                       @"每个魔法包内有价值1000元以上的服装",
                       @"智能推荐，设计师搭配，符合你的身份，",
                       @"也不错过流行",
                       @"我们用五星级清洁来保证卫生和安全",
                       @"快递免费，清洗免费"
                       ];
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSUInteger index = idx;
            if (index == 2)
            {
                ALLabel *specailLbl=[[ALLabel alloc] initWithFrame:CGRectZero];
                [specailLbl setFont:[UIFont systemFontOfSize:11]];
                [specailLbl setNumberOfLines:0];
                [specailLbl setTextColor:AL_RGB(64, 64, 64)];
                specailLbl.textAlignment = NSTextAlignmentLeft;
                [imgView addSubview:specailLbl];
                specailLbl.frame = CGRectMake(45, lineImgView.bottom + 60, imgView.width - 20, 20);
                specailLbl.text = obj;
            }
            else
            {
                if (idx > 2)
                {
                    index = index - 1;
                }
                CGFloat space = 5.f;
                if (idx != 3)
                {
                    space = 1.f;
                }
                ALListLbl *lbl=[[ALListLbl alloc]
                                initWithFrame:CGRectMake(0, lineImgView.bottom+30*index+space*index, imgView.width, 50)];
                [lbl setTit:obj];
                [imgView addSubview:lbl];
            }

        }];
        
        ALLine *line=[[ALLine alloc]
                      initWithFrame:CGRectMake(0, 504/2, imgView.width, 1)];
        [imgView addSubview:line];
        
        ALLabel *bottomLbl=[[ALLabel alloc]
                            initWithFrame:CGRectMake(30,
                                                     line.bottom+5,
                                                     imgView.width - 30,
                                                     30)
                            andColor:[UIColor grayColor]
                            andFontNum:12];
        [bottomLbl setText:@"加入魔法衣橱，获得以上所有服务"];
        [bottomLbl setTextAlignment:NSTextAlignmentLeft];
        [imgView addSubview:bottomLbl];

        
        ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
        okBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        CGFloat btnY = imgView.bottom+100/2;
        [okBtn setFrame:CGRectMake(40,
                                   btnY, 240, 30)];
        [okBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        if ([[ALLoginUserManager sharedInstance] loginCheck]) {
            [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        }else{
            [okBtn setTitle:@"登录" forState:UIControlStateNormal];
        }
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
