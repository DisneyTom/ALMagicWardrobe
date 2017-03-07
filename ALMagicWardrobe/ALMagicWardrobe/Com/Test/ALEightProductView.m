//
//  ALEightProductView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALEightProductView.h"

@implementation ALEightProductView{
    float _orginY;
    NSMutableArray *_mulArr;
    NSMutableString *_mulStr;
    
    NSMutableArray *_tecMulArr;
}
-(id)initWithFrame:(CGRect)frame andBackBlock:(BackBlock)theBlock{
    self=[super initWithFrame:frame];
    if (self) {
        self.theBlock=theBlock;
        self.backgroundColor = AL_RGB(240,236,233);
        ALTestModel *theChildModel=[[ALTestModel alloc] init];
        _mulArr=[NSMutableArray array];
        _mulStr=[[NSMutableString alloc] initWithCapacity:2];
        _tecMulArr=[[NSMutableArray alloc] initWithCapacity:2];
        _orginY=0;
        //7
        ALLabel *left7Lbl=[[ALLabel alloc]
                           initWithFrame:CGRectMake(10.f, 15, 255, 12) andColor:colorByStr(@"6D6A6B")
                           andFontNum:12];
        [left7Lbl setText:@"vii 你不能接受的服装工艺（可多选）"];
        [left7Lbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:left7Lbl];
        left7Lbl.textAlignment = NSTextAlignmentLeft;
        _orginY=left7Lbl.bottom + 15;
        
        ALComView *content2View=[[ALComView alloc] initWithFrame:CGRectMake(0.f, _orginY, self.width, 246)];
        [self addSubview:content2View];
        
        NSArray *radioArr=@[@"镂空",@"手绘",@"破洞",@"钉珠",
                            @"烫钻",@"绣花",@"印花",@"做旧",
                            @"铆钉",@"撞色",@"木耳边",@"流苏",
                            @"褶皱",@"拼接",@"不规则",@"蕾丝",
                            @"扎染",@"亮片", @"蝴蝶结",@"贴布绣",
                            @"无"];
        float width=(content2View.width - 50)/4;
//        [theChildModel setAvoid_tec:radioArr[0]];
//        self.theBlock(theChildModel);


        NSMutableArray *btnArr=[NSMutableArray array];
        [radioArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(30+width*idx, _orginY, width, 20)];
            [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
            [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
            [btn setTitle:obj forState:UIControlStateNormal];
            btn.titleLabel.adjustsFontSizeToFitWidth=YES;
            [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn setTag:10000+idx];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            [btn setTheBtnClickBlock:^(id sender){
                if ([obj isEqualToString:@"无"]) {
                    [_tecMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        ALButton *btn=obj;
                        [btn setSelected:NO];
                    }];
                    [_mulArr removeAllObjects];
                }else{
                    ALButton *btn=_tecMulArr[_tecMulArr.count-1];
                    [btn setSelected:NO];
                    [_mulArr removeObject:@"无"];
                }
                
                ALButton *theBtn=sender;
                [theBtn setSelected:!theBtn.selected];
                if (theBtn.selected) {
                    [_mulArr addObject:theBtn.titleLabel.text];
                }else{
                    [_mulArr removeObject:theBtn.titleLabel.text];
                }
                
                [_mulStr deleteCharactersInRange:NSMakeRange(0, _mulStr.length)];
                [_mulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [_mulStr appendFormat:@"%@,",obj];
                }];
                
                [theChildModel setAvoid_tec:_mulStr];
                self.theBlock(theChildModel);

            }];
            [content2View addSubview:btn];
            [btnArr addObject:btn];
            
//            if (idx/4==0) {
//                [btn setFrame:CGRectMake(width*idx + 30, 20*0, width, 20)];
//                _orginY=btn.bottom;
//            }else if (idx/4==1){
//                [btn setFrame:CGRectMake(width*(idx-4)  + 30, 20*1+10, width, 20)];
//                _orginY=btn.bottom;
//            }else if (idx/4==2){
//                [btn setFrame:CGRectMake(width*(idx-4*2)  + 30, 20*2+20, width, 20)];
//                _orginY=btn.bottom;
//            }else if (idx/4==3){
//                [btn setFrame:CGRectMake(width*(idx-4*3)  + 30, 20*3+30, width, 20)];
//                _orginY=btn.bottom;
//            }else if(idx/4==4){
//                [btn setFrame:CGRectMake(width*(idx-4*4)  + 30, 20*4+40, width, 20)];
//                _orginY=btn.bottom;
//            }else if(idx/4==5){
//                [btn setFrame:CGRectMake(width*(idx-4*5)  + 30, 20*5+50, width, 20)];
//                _orginY=btn.bottom;
//            }
            if (idx < 12)
            {
                if (idx/4==0) {
                    [btn setFrame:CGRectMake(width*idx + 30, 20*0, width, 20)];
                    _orginY=btn.bottom;
                }else if (idx/4==1){
                    [btn setFrame:CGRectMake(width*(idx-4) + 30, 20*1+10, width, 20)];
                    _orginY=btn.bottom;
                }else if (idx/4==2){
                    [btn setFrame:CGRectMake(width*(idx-4*2) + 30, 20*2+20, width, 20)];
                    _orginY=btn.bottom;
                }
            }
            else
            {
                NSInteger index = idx - 12;
                if (index/3==0){
                    [btn setFrame:CGRectMake(width*index + 30, 20*3+30, width, 20)];
                    _orginY=btn.bottom;
                }else if (index/3==1){
                    [btn setFrame:CGRectMake(width*(index-3) + 30, 20*4+40, width, 20)];
                    _orginY=btn.bottom;
                }
                else if (index/3 == 2)
                {
                    [btn setFrame:CGRectMake(width*(index-3*2)+ 30, 20*5+50, width, 20)];
                    _orginY=btn.bottom;
                }
            }
            
            [_tecMulArr addObject:btn];
            
//            //设置默认选中
//            if (idx==20) {
//                [btn setSelected:YES];
//                [_mulArr addObject:btn.titleLabel.text];
//               
//                [_mulStr deleteCharactersInRange:NSMakeRange(0, _mulStr.length)];
//                [_mulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                    [_mulStr appendFormat:@"%@,",obj];
//                }];
//                
//                [theChildModel setAvoid_tec:_mulStr];
//                self.theBlock(theChildModel);
//
//            }
        }];

    }

    return self;
}

@end
