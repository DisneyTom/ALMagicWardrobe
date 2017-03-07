//
//  ALSevenProductView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALSevenProductView.h"

@implementation ALSevenProductView
{
    float _orginY;
    NSMutableArray *_mulColorArr;
    NSMutableString *_mulColorStr;
    NSMutableArray *_mulPicArr;
    NSMutableString *_mulPicStr;
    
    NSMutableArray *_colorBtnArr;
    NSMutableArray *_picBtnArr;
}
-(id)initWithFrame:(CGRect)frame andBackBlock:(BackBlock)theBlock{
    self=[super initWithFrame:frame];
    if (self) {
        self.theBlock=theBlock;
        self.backgroundColor = AL_RGB(240,236,233);
        ALTestModel *theChildModel=[[ALTestModel alloc] init];
        _mulColorArr=[NSMutableArray array];
        _mulColorStr=[[NSMutableString alloc] initWithCapacity:2];
        _colorBtnArr=[[NSMutableArray alloc] initWithCapacity:2];

        _mulPicArr=[NSMutableArray array];
        _mulPicStr=[[NSMutableString alloc] initWithCapacity:2];
        _picBtnArr=[[NSMutableArray alloc] initWithCapacity:2];
        //4
        ALLabel *left4Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(10, 15, 250, 12) andColor:colorByStr(@"6D6A6B")
                                              andFontNum:12];
        [left4Lbl setText:@"v  你不能接受的服装颜色（可多选）"];
        [left4Lbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:left4Lbl];
        left4Lbl.textAlignment = NSTextAlignmentLeft;
        _orginY=left4Lbl.bottom;
        
        NSArray *arr2=@[
                        @{@"黑色":@"choose_black"},
                        @{@"灰色":@"choose_gray"},
                        @{@"白色":@"choose_white"},
                        @{@"奶油色":@"choose_cream"},
                        @{@"棕色":@"choose_brown"},
                        @{@"绿色":@"choose_green"},
                        @{@"紫色":@"choose_purple"},
                        @{@"蓝色":@"choose_blue"},
                        @{@"橙色":@"choose_orange"},
                        @{@"黄色":@"choose_yellow"},
                        @{@"红色":@"choose_red"},
                        @{@"粉色":@"choose_pink"},
                        @{@"无":@"choose_none"}
                        ];
        ALComView *contentView=[[ALComView alloc]
                                initWithFrame:CGRectMake(30, _orginY+15, 275, 240)];
        [self addSubview:contentView];
        _orginY=contentView.bottom;
        
        [arr2 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dic=obj;
            ALImageView *imgView=[[ALImageView alloc]
                                  initWithFrame:CGRectZero];
            [imgView setImage:[ALImage imageNamed:[dic allValues][0]]];
            [imgView setUserInteractionEnabled:YES];
            [contentView addSubview:imgView];
            
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectZero];
            [btn setImage:nil forState:UIControlStateNormal];
            [btn setImage:[ALImage imageNamed:@"icon_option_on"] forState:UIControlStateSelected];
            [btn setTheBtnClickBlock:^(id sender){
                if ([[dic allKeys][0] isEqualToString:@"无"]) {
                    [_colorBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        ALButton *btn=obj;
                        [btn setSelected:NO];
                    }];
                    [_mulColorArr removeAllObjects];
                }else{
                    ALButton *btn=_colorBtnArr[_colorBtnArr.count-1];
                    [btn setSelected:NO];
                    [_mulColorArr removeObject:@"无"];
                }
                ALButton *theBtn=sender;
                [theBtn setSelected:!theBtn.selected];
                
                if (theBtn.selected) {
                    [_mulColorArr addObject:[dic allKeys][0]];
                }else{
                    [_mulColorArr removeObject:[dic allKeys][0]];
                }
                
                [_mulColorStr deleteCharactersInRange:NSMakeRange(0, _mulColorStr.length)];
                [_mulColorArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [_mulColorStr appendFormat:@"%@,",obj];
                }];
                
                [theChildModel setAvoid_colour:_mulColorStr];
                self.theBlock(theChildModel);

            }];
            [imgView addSubview:btn];
            
            ALLabel *lbl=[[ALLabel alloc] initWithFrame:CGRectZero andColor:colorByStr(@"#949192") andFontNum:14];
            [lbl setText:[dic allKeys][0]];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            [contentView addSubview:lbl];
            lbl.font = [UIFont systemFontOfSize:10];
            
            if (idx/5==0) {
                [imgView setFrame:CGRectMake((3+50)*idx, 0, 50, 50)];
                [btn setFrame:CGRectMake(0,0, imgView.width, imgView.height)];
                [lbl setFrame:CGRectMake(imgView.left,imgView.bottom + 5, imgView.width, 10)];
            }else if (idx/5==1){
                [imgView setFrame:CGRectMake((3+50)*(idx-5), (50+20)*1+10, 50, 50)];
                [btn setFrame:CGRectMake(0,0, imgView.width, imgView.height)];
                [lbl setFrame:CGRectMake(imgView.left,imgView.bottom + 5, imgView.width, 10)];
            }else{
                [imgView setFrame:CGRectMake((3+50)*(idx-10), (50+20)*2+20, 50, 50)];
                [btn setFrame:CGRectMake(0,0, imgView.width, imgView.height)];
                [lbl setFrame:CGRectMake(imgView.left,imgView.bottom + 5, imgView.width, 10)];
            }
            [_colorBtnArr addObject:btn];
            
//            //设置默认选中
//            if (idx==12) {
//                [btn setSelected:YES];
//                [_mulColorArr addObject:[dic allKeys][0]];
//                
//                [_mulColorStr deleteCharactersInRange:NSMakeRange(0, _mulColorStr.length)];
//                [_mulColorArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                    [_mulColorStr appendFormat:@"%@,",obj];
//                }];
//                
//                [theChildModel setAvoid_colour:_mulColorStr];
//                self.theBlock(theChildModel);
//
//            }
        }];

        //6
        ALLabel *left5Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(10, _orginY+5, 250, 15) andColor:colorByStr(@"6D6A6B")
                                              andFontNum:12];
        [left5Lbl setText:@"vi 你不能接受的服装图案（可多选）"];
        [left5Lbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:left5Lbl];
        left5Lbl.textAlignment = NSTextAlignmentLeft;
        _orginY=left5Lbl.bottom + 20;
        
        ALComView *content2View=[[ALComView alloc] initWithFrame:CGRectMake(0, _orginY, self.width, 85)];
        [self addSubview:content2View];
        
        NSArray *radioArr=@[@"动物人物",@"植物花卉",@"几何形状",@"格纹条纹",@"字母数字",@"波点",@"抽象",@"无"];
//        [theChildModel setAvoid_pic:radioArr[0]];
//        self.theBlock(theChildModel);


        float width= (content2View.width - 60)/3;
        NSMutableArray *btnArr=[NSMutableArray array];
        [radioArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(30+width*idx, _orginY, width, 20)];
            [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
            [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn setTag:10000+idx];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            [btn setTheBtnClickBlock:^(id sender){
                if ([obj isEqualToString:@"无"]) {
                    [_picBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        ALButton *btn=obj;
                        [btn setSelected:NO];
                    }];
                    [_mulPicArr removeAllObjects];
                }else{
                    ALButton *btn=_picBtnArr[_picBtnArr.count-1];
                    [btn setSelected:NO];
                    [_mulColorArr removeObject:@"无"];
                }

                ALButton *theBtn=sender;
                [theBtn setSelected:!theBtn.selected];
                if (theBtn.selected) {
                    [_mulPicArr addObject:theBtn.titleLabel.text];
                }else{
                    [_mulPicArr removeObject:theBtn.titleLabel.text];
                }
                [_mulPicStr deleteCharactersInRange:NSMakeRange(0, _mulPicStr.length)];
                [_mulPicArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [_mulPicStr appendFormat:@"%@,",obj];
                }];
                
                [theChildModel setAvoid_pic:_mulPicStr];
                self.theBlock(theChildModel);


            }];

            [content2View addSubview:btn];
            [btnArr addObject:btn];
            
            if (idx/3==0) {
                [btn setFrame:CGRectMake(width*idx + 30, 20*0, width, 20)];
                _orginY=btn.bottom;
            }else if (idx/3==1){
                [btn setFrame:CGRectMake(width*(idx-3) + 30, 20*1+10, width, 20)];
                _orginY=btn.bottom;
            }else{
                [btn setFrame:CGRectMake(width*(idx-6) + 30, 20*2+20, width, 20)];
                _orginY=btn.bottom;
            }

            [_picBtnArr addObject:btn];
            
            //设置默认选中
//            if (idx==7) {
//                [btn setSelected:YES];
//                [_mulPicArr addObject:btn.titleLabel.text];
//                [_mulPicStr deleteCharactersInRange:NSMakeRange(0, _mulPicStr.length)];
//                [_mulPicArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                    [_mulPicStr appendFormat:@"%@,",obj];
//                }];
//                
//                [theChildModel setAvoid_pic:_mulPicStr];
//                self.theBlock(theChildModel);
//
//            }
        }];

    }

    return self;
}

@end
