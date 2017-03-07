//
//  ALSixProductView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALSixProductView.h"

static const int InitTag = 100000;

@implementation ALSixProductView{
    float _orginY;
    ALTestModel *theChildModel;
    NSMutableArray *mulBtnArr;
    NSMutableArray *getOccuPationArray;
}
-(id)initWithFrame:(CGRect)frame andBackBlock:(BackBlock)theBlock{
    self=[super initWithFrame:frame];
    if (self) {
        self.theBlock=theBlock;
        theChildModel=[[ALTestModel alloc] init];
        self.backgroundColor = AL_RGB(240,236,233);
        //4
        ALLabel *left4Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(kLeftSpace, 15, kScreenWidth-kLeftSpace-kRightSpace, 12) andColor:colorByStr(@"6D6A6B")
                                              andFontNum:12];
        [left4Lbl setText:@"iv 你近期想尝试的风格（可多选）"];
        [left4Lbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:left4Lbl];
        _orginY=left4Lbl.bottom;
        
        NSArray *arr2=@[
                        @{@"女王大人":@"test_photo0001"},
                        @{@"甜美清新":@"test_photo0002"},
                        @{@"小小性感":@"test_photo0003"},
                        @{@"轻松休闲":@"test_photo0004"},
                        @{@"文艺小妞":@"test_photo0005"},
                        @{@"职场淑女":@"test_photo0006"}
                        
                        
                        ];
        
        getOccuPationArray = [NSMutableArray arrayWithCapacity:2];
        
        ALComView *contentView=[[ALComView alloc]
                                initWithFrame:CGRectMake((self.width-104*2-5)/2, _orginY+5, 104*2+5, (132+20+10)*(6/2)+50)];
        [self addSubview:contentView];
        mulBtnArr=[NSMutableArray array];
        [arr2 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dic=obj;
            ALImageView *imgView=[[ALImageView alloc]
                                  initWithFrame:CGRectZero];
            [imgView setImage:[ALImage imageNamed:[dic allValues][0]]];
            [contentView addSubview:imgView];
            imgView.tag = InitTag + idx;
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImgClick:)];
            [imgView addGestureRecognizer:tap];
            
            
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectZero];
            [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
            [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
            [btn setTitle:[dic allKeys][0] forState:UIControlStateNormal];
            [btn setTag:1000+idx];
            [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            [btn setTheBtnClickBlock:^(id sender){
                ALButton *childBtn=sender;
                [self btnClick:childBtn.tag - 1000];
//                if (childBtn.selected==NO) {
//                    [childBtn setSelected:YES];
//                    [getOccuPationArray addObject:childBtn.titleLabel.text];
//                }else{
//                    [childBtn setSelected:NO];
//                    [getOccuPationArray removeObject:childBtn.titleLabel.text];
//                }
//                [theChildModel setWish_style:[getOccuPationArray componentsJoinedByString:@","]];
//                self.theBlock(theChildModel);

            }];
            [contentView addSubview:btn];
            
//            if (idx==0) {
//                [btn setSelected:YES];
//                [getOccuPationArray addObject:btn.titleLabel.text];
////                [getOccuPationArray addObject:occupationArray[0]];
////                 [_theModel setWish_style:[getOccuPationArray componentsJoinedByString:@","]];
//            }
            
            if (idx/2==0) {
                [imgView setFrame:CGRectMake( 90*idx + 20, 15, 85, 110)];
                [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 18)];
            }else if (idx/2==1){
                [imgView setFrame:CGRectMake(90*(idx-2) + 20, (110+18 )*1+5 + 15, 85, 110)];
                [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 18)];
            }else{
                [imgView setFrame:CGRectMake(90*(idx-4) + 20, (110+18)*2+8+ 15, 85, 110)];
                [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 18)];
            }
            
            [mulBtnArr addObject:btn];
        }];
    }

    return self;
}

#pragma mark -设置图片点击
- (void)setImgClick:(UITapGestureRecognizer *)reco
{
    UIImageView *view = (UIImageView *)reco.view;
    NSInteger tag = view.tag;
    [self btnClick:tag - InitTag];
    
}


#pragma mark - 按钮的点击状态
- (void)btnClick:(NSInteger)tag
{
    
    [mulBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        ALButton *childBtn = obj;
        if (idx == tag)
        {
            if (childBtn.selected == NO) {
                [childBtn setSelected:YES];
                [getOccuPationArray addObject:childBtn.titleLabel.text];
                
            }else{
                [childBtn setSelected:NO];
                [getOccuPationArray removeObject:childBtn.titleLabel.text];
            }
            [theChildModel setWish_style:[getOccuPationArray componentsJoinedByString:@","]];
            self.theBlock(theChildModel);
        }
    }];
}


@end
