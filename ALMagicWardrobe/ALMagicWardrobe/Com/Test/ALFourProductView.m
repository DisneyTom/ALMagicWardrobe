//
//  ALFourProductView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALFourProductView.h"
#import "ALLine.h"

static const int InitTag = 100000;

@implementation ALFourProductView{
    float _orginLineY;
    float _orginY;
    NSMutableArray *twoBtnArr;
    ALTestModel *theChildModel;
}
-(id)initWithFrame:(CGRect)frame andBackBlock:(BackBlock)theBlock{
    self=[super initWithFrame:frame];
    if (self) {
        self.theBlock=theBlock;
        self.backgroundColor = AL_RGB(240,236,233);
        theChildModel=[[ALTestModel alloc] init];

        ALLabel *oneBigLeftTitLbl=[[ALLabel alloc]
                                   initWithFrame:CGRectMake(10, 15, 85, 15)
                                   andColor:colorByStr(@"#946E3A")
                                   andFontNum:15];
        [oneBigLeftTitLbl setText:@"II 我的风格"];
        [oneBigLeftTitLbl setFont:[UIFont boldSystemFontOfSize:15]];
        oneBigLeftTitLbl.textAlignment = NSTextAlignmentLeft;
        [self addSubview:oneBigLeftTitLbl];
        
        ALLabel *oneBigContentLbl=[[ALLabel alloc]
                                   initWithFrame:CGRectMake(10, oneBigLeftTitLbl.bottom + 13, self.width-20, 35)
                                   andColor:colorByStr(@"979591")
                                   andFontNum:14];
        [oneBigContentLbl setText:@"风格测试是为你精选服装的重要参考依据,当然你也可以随时修改你想尝试的着装风格!"];
        [oneBigContentLbl setNumberOfLines:0];
        [self addSubview:oneBigContentLbl];
                oneBigContentLbl.textAlignment = NSTextAlignmentLeft;
        
        _orginLineY=oneBigContentLbl.bottom;
        _orginY=oneBigContentLbl.bottom;
        
        ALLine *line=[[ALLine alloc] initWithFrame:CGRectMake(0, _orginLineY + 8, self.width, .5)];
        [self addSubview:line];

        //1
        ALLabel *left1Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(10, line.bottom + 14, 75, 12) andColor:colorByStr(@"6D6A6B")
                                              andFontNum:12];
        [left1Lbl setText:@"i  你的年龄"];
        [left1Lbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:left1Lbl];
        left1Lbl.textAlignment = NSTextAlignmentLeft;
        _orginY=left1Lbl.bottom + 20;
        
        NSArray *radioArr=@[@"25以下",@"25~30",@" 30以上"];
        NSMutableArray *oneBtnArr=[NSMutableArray array];
//        [theChildModel setAge_group:@"25以下"];
//        self.theBlock(theChildModel);

        float width=(self.width-60)/radioArr.count;
        [radioArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn setFrame:CGRectMake(30+width*idx, _orginY, width, 20)];
            [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
            [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btn setTag:10000+idx];
            [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            [btn setTheBtnClickBlock:^(id sender){
                ALButton *theBtn=sender;
                [oneBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    ALButton *childBtn=obj;
                    if (childBtn.tag==theBtn.tag) {
                        [childBtn setSelected:YES];
                        [theChildModel setAge_group:childBtn.titleLabel.text];
                        self.theBlock(theChildModel);

                    }else{
                        [childBtn setSelected:NO];
                    }
                }];

            }];
            [self addSubview:btn];
            [oneBtnArr addObject:btn];
            
//            if (idx==1) {
//                [btn setSelected:YES];
//                [theChildModel setAge_group:btn.titleLabel.text];
//                self.theBlock(theChildModel);
//
//            }
        }];
        
        _orginY=_orginY+40;
        
        //2
        ALLabel *left2Lbl=[[ALLabel alloc]
                           initWithFrame:CGRectMake(10, _orginY, 75, 12) andColor:colorByStr(@"6D6A6B")
                           andFontNum:12];
        [left2Lbl setText:@"ii 你的职业"];
        [left2Lbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:left2Lbl];
        left2Lbl.textAlignment = NSTextAlignmentLeft;
        _orginY=left2Lbl.bottom;
        
        //104 × 132
        
        NSArray *arr2=@[
                        @{@"商业专业":@"test_photo01"},
                        @{@"文化创意":@"test_photo02"},
                        @{@"自由职业":@"test_photo03"},
                        @{@"艺术表演":@"test_photo04"}
                        ];
        ALComView *contentView=[[ALComView alloc] initWithFrame:CGRectMake((self.width-104*2-5)/2, _orginY+15, 104*2+5, (132+20)*2+50)];
        [self addSubview:contentView];
//        [theChildModel setOccupation:@"商业专业"];
//        self.theBlock(theChildModel);


        twoBtnArr=[NSMutableArray array];
        
        [arr2 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dic=obj;
            if (idx/2==0) {
                ALImageView *imgView=[[ALImageView alloc]
                                      initWithFrame:CGRectMake(24 + (80 + 5)*idx , 0, 80, 103)];
                [imgView setImage:[ALImage imageNamed:[dic allValues][0]]];
                [contentView addSubview:imgView];
                imgView.tag = InitTag + idx;
                imgView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImgClick:)];
                [imgView addGestureRecognizer:tap];
                
                ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 20)];
                [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
                [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
                [btn setTitle:[dic allKeys][0] forState:UIControlStateNormal];
                [btn setTag:4000+idx];
                [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
                [btn setTheBtnClickBlock:^(id sender){
                    ALButton *theBtn=sender;
                    [self btnClick:theBtn.tag - 4000];
//                    [twoBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                        ALButton *childBtn=obj;
//                        if (childBtn.tag==theBtn.tag) {
//                            [childBtn setSelected:YES];
//                            [theChildModel setOccupation:childBtn.titleLabel.text];
//                            self.theBlock(theChildModel);
//
//                        }else{
//                            [childBtn setSelected:NO];
//                        }
//                    }];
                }];
                [contentView addSubview:btn];
                [twoBtnArr addObject:btn];
            }else{
                int index = (idx - 2)%2;
                ALImageView *imgView=[[ALImageView alloc] initWithFrame:CGRectMake(24 + (80 + 5)*index, 103+20+13, 80, 103)];
                [imgView setImage:[ALImage imageNamed:[dic allValues][0]]];
                [contentView addSubview:imgView];
                imgView.tag = InitTag + idx;
                imgView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImgClick:)];
                [imgView addGestureRecognizer:tap];
                
                ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 20)];
                [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
                [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
                [btn setTitle:[dic allKeys][0] forState:UIControlStateNormal];
                [btn setTag:4000+idx];
                [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
                [btn setTheBtnClickBlock:^(id sender){
                    ALButton *theBtn=sender;
                    [self btnClick:theBtn.tag - 4000];
//                    [twoBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                        ALButton *childBtn=obj;
//                        if (childBtn.tag==theBtn.tag) {
//                            [childBtn setSelected:YES];
//                            [theChildModel setOccupation:childBtn.titleLabel.text];
//                            self.theBlock(theChildModel);
//
//                        }else{
//                            [childBtn setSelected:NO];
//                        }
//                    }];
                }];
                [contentView addSubview:btn];
                [twoBtnArr addObject:btn];
            }
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
    [twoBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALButton *childBtn=obj;
        NSInteger tagIndex = childBtn.tag - 4000;
        if (tagIndex ==tag) {
            [childBtn setSelected:YES];
            [theChildModel setOccupation:childBtn.titleLabel.text];
            self.theBlock(theChildModel);
            
        }else{
            [childBtn setSelected:NO];
        }
    }];
}


@end
