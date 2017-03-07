//
//  ALFashionSquareHeadView.m
//  ALMagicWardrobe
//
//  Created by OCN on 15-4-2.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALFashionSquareHeadView.h"
#import "FFScrollView.h"
#import "ALBaseViewController.h"

@implementation ALFashionSquareHeadView{
    FFScrollView *topScrollView;
    ALComView *_theComView;
    ALButton *chesiBtn;
    UILabel*    lbl_Line;
    UIButton *magicBtn;
}
-(id)initWithFrame:(CGRect)frame andDelegate:(id <FFScrollViewDelegate>)theCtrl{
    self=[super initWithFrame:frame];
    if (self) {
       // self.backgroundColor = AL_RGB(240,236,233);
        _theComView=[[ALComView alloc] initWithFrame:CGRectMake(0, 0, self.width, 35)];
        topScrollView=[[FFScrollView alloc]
                       initWithFrame:CGRectMake(0,
                                                0,
                                                kScreenWidth,
                                                308)];
        [topScrollView setPageViewDelegate:theCtrl];
        [topScrollView setSelectionType:FFScrollViewSelecttionTypeTap];
        [self addSubview:topScrollView];
        lbl_Line = [[UILabel alloc]init];
        lbl_Line.backgroundColor = ALUIColorFromHex(0xe9e6e6);
        
        magicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        magicBtn.frame = CGRectMake(49, 308 - 68, kScreenWidth - 98, 33);
        magicBtn.backgroundColor = [UIColor clearColor];
        magicBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [magicBtn setBackgroundImage:[UIImage imageNamed:@"btn_lqmfb"] forState:(UIControlStateNormal)];
        //[magicBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [magicBtn setTitle:@"领一个魔法包" forState:UIControlStateNormal];
        [magicBtn setTitleColor:ALUIColorFromHex(0xa07845) forState:UIControlStateNormal];
        [magicBtn addTarget:self action:@selector(doclickMagicButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:magicBtn];
        
        UIImageView *periodicalView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 323, kScreenWidth - 20, 308)];
        [periodicalView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        [self addSubview:periodicalView];
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    
}

- (void)doclickMagicButtonAction:(id)sender
{
    NSLog(@"领一个魔法包");
    if (self.delegate&&[self.delegate respondsToSelector:@selector(doclickMagicButtonAction)]) {
        [self.delegate doclickMagicButtonAction];
    }
}

-(void)setTopScrollViews:(NSArray *)topDatas andActionImgs:(NSDictionary *)actionImgs{
    [topScrollView setViews:topDatas];
    [_theComView removeAllSubviews];
    NSArray* array_Btn =  [NSArray arrayWithObjects:@"上新",@"人气",@"精选",@"分类",@"魔橱",nil];
    [array_Btn enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnSpaceWidth = (self.bounds.size.width - 5*6) /5;
        [btn setFrame:CGRectMake(5 + idx * (btnSpaceWidth+5) ,0,btnSpaceWidth,35)];
        [btn setTitle:array_Btn[idx] forState:UIControlStateNormal];
        [btn setTitleColor:ALUIColorFromHex(0x92887c) forState:UIControlStateNormal];
        if (idx == 0)
        {
            [btn setTitleColor:ALUIColorFromHex(0xa07845) forState:UIControlStateNormal];
        }
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        btn.index = idx;
        [btn setTag:idx+10000];
        [btn setTheBtnClickBlock:^(id sender){
            ALButton *theBtn=sender;
            if (theBtn.tag==0+10000)
            {
               // lbl_Line.frame = CGRectMake(0,_theComView.bounds.size.height + 14 , self.bounds.size.width, 0.5);
                if (self.theBlock) {
                    self.theBlock(FSCtrlAction_type,1);
                }
            }else if (theBtn.tag==1+10000)
            {
                if (self.theBlock) {
                    self.theBlock(FSCtrlAction_type,2);
                }
            }else if (theBtn.tag==2+10000){
                if (self.theBlock) {
                    self.theBlock(FSCtrlAction_type,3);
                }
            }else if (theBtn.tag==3+10000){
                if (self.theBlock) {
                    self.theBlock(FSCtrlAction_type,4);
                }
            }
            else{
                if (self.theBlock) {
                    self.theBlock(FSCtrlAction_type,5);
                }
            }
        }];
        [_theComView addSubview:btn];
    }];
    
    [_theComView addSubview:lbl_Line];
}
-(void)hideTestBtn:(BOOL)hide{
    [chesiBtn setHidden:hide];
    [self setHeight:FSHeadViewHeight-20];
}
@end
