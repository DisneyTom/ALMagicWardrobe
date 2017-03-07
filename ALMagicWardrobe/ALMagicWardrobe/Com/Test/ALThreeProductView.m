//
//  ALThreeProductView.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALThreeProductView.h"
static const int InitTag = 100000;

@implementation ALThreeProductView{
    float _orginY;
    ALTestModel *theChildModel;
    NSMutableArray *btnMulArr;
}
-(id)initWithFrame:(CGRect)frame andBackBlock:(BackBlock)theBlock{
    self=[super initWithFrame:frame];
    if (self) {
        self.theBlock=theBlock;
        self.backgroundColor = AL_RGB(240,236,233);
        theChildModel=[[ALTestModel alloc] init];
        //12
        ALLabel *left12Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(10, 15, 160, 15) andColor:colorByStr(@"6D6A6B")
                                               andFontNum:12];
        [left12Lbl setText:@"xii 你的体型是（图示）"];
        [left12Lbl setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:left12Lbl];
        left12Lbl.textAlignment = NSTextAlignmentLeft;
        
        ALComView *contentView=[[ALComView alloc]
                                initWithFrame:CGRectMake(0, left12Lbl.bottom+10, self.width, 190)];
        [self addSubview:contentView];
        _orginY=contentView.bottom;
        
        NSArray *imgArr=@[@"figure_x",@"figure_a",@"figure_h",@"figure_y",@"figure_o"];
        float width=(contentView.width-76 -(imgArr.count-1)*5)/imgArr.count;
        btnMulArr=[NSMutableArray array];
        [imgArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALImageView *imgView=[[ALImageView alloc]
                                  initWithFrame:CGRectMake((width+5)*idx + 38, 0, width, contentView.height-15)];
            [imgView setImage:[ALImage imageNamed:obj]];
            [contentView addSubview:imgView];
            imgView.backgroundColor = [UIColor greenColor];
            imgView.tag = InitTag + idx;
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImgClick:)];
            [imgView addGestureRecognizer:tap];
            
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake((imgView.width-30)/2+imgView.left, imgView.bottom+5, 30, 20)];
            [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
            [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(2, 7, 2, 7)];
            btn.titleLabel.textColor = [UIColor clearColor];
            [btn setTag:10000+idx];
        
            [btn setTheBtnClickBlock:^(id sender){
                ALButton *theBtn=sender;
                [self btnClick:theBtn.tag-10000];
//                [btnMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                    ALButton *childBtn=obj;
//                    if (childBtn.tag==theBtn.tag) {
//                        [childBtn setSelected:YES];
//                        [self setIndex:childBtn.tag - 10000];
//                        if (childBtn.tag == 10000)
//                        {
//                            [theChildModel setHabitus:@"X体型"];
//                            self.theBlock(theChildModel);
//                        }
//                        if (childBtn.tag == 10001)
//                        {
//                            [theChildModel setHabitus:@"A体型"];
//                            self.theBlock(theChildModel);
//                        }
//                        if (childBtn.tag == 10002)
//                        {
//                            [theChildModel setHabitus:@"H体型"];
//                            self.theBlock(theChildModel);
//                        }
//                        if (childBtn.tag == 10003)
//                        {
//                            [theChildModel setHabitus:@"Y体型"];
//                            self.theBlock(theChildModel);
//                        }
//                        if (childBtn.tag == 10004)
//                        {
//                            [theChildModel setHabitus:@"O体型"];
//                            self.theBlock(theChildModel);
//                        }
//                        
//
//                    }else{
//                        [childBtn setSelected:NO];
//                    }
//                }];
            }];
            [contentView addSubview:btn];
            [btnMulArr addObject:btn];
        }];

        //13
        NSString *str=@"xiii 完整准确地填写以下数据，我们将为你精选更加合身的服装哦，一起量起来吧!";
        CGSize size=[ALComAction getSizeByStr:str andFont:[UIFont boldSystemFontOfSize:12] andRect:CGSizeMake(self.width-20, 0)];
        ALLabel *left13Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(10, _orginY+20, size.width, size.height) andColor:colorByStr(@"6D6A6B")
                                               andFontNum:12];
        [left13Lbl setText:str];
        [left13Lbl setFont:[UIFont boldSystemFontOfSize:12]];
        [left13Lbl setNumberOfLines:0];
        left13Lbl.textAlignment = NSTextAlignmentLeft;
        [self addSubview:left13Lbl];
        
        ALLabel *left1313Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(left13Lbl.left, left13Lbl.bottom + 6, left13Lbl.width, 12) andColor:colorByStr(@"6D6A6B") andFontNum:10];
        [left1313Lbl setText:@"(此题可跳过，但建议回答，让我们为你选得更好)"];
        [self addSubview:left1313Lbl];
        
        
            NSMutableArray *oneArray = [NSMutableArray arrayWithCapacity:2];
            for(int i=70;i<=105;i++){
                [oneArray addObject:[NSString stringWithFormat:@"%dcm",i]];
            }
        
        NSMutableArray *twoArray = [NSMutableArray arrayWithCapacity:2];
        for(int i=50;i<=85;i++){
            [twoArray addObject:[NSString stringWithFormat:@"%dcm",i]];
        }
        
        NSMutableArray *threeArray = [NSMutableArray arrayWithCapacity:2];
        for(int i=70;i<=105;i++){
            [threeArray addObject:[NSString stringWithFormat:@"%dcm",i]];
        }
        
        NSMutableArray *fourArray = [NSMutableArray arrayWithCapacity:2];
        for(int i=30;i<=50;i++){
            [fourArray addObject:[NSString stringWithFormat:@"%dcm",i]];
        }
        
        NSArray *arr=@[
                       @{@"胸围":oneArray},
                       @{@"腰围":twoArray},
                       @{@"臀围":threeArray},
                       @{@"肩宽":fourArray}
                       ];
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dic=obj;
            ALLabel *lbl=[[ALLabel alloc] initWithFrame:CGRectMake(0, left1313Lbl.bottom+20+(25 + 15)*idx, 65, 12)];
            [lbl setText:[dic allKeys][0]];
            [lbl setTextColor:colorByStr(@"#9c9a96")];
            [lbl setFont:[UIFont systemFontOfSize:15]];
            [self addSubview:lbl];
            lbl.textAlignment = NSTextAlignmentRight;
            
            __block ALButton *selBtn;
            
            ALSelectView *selView=[[ALSelectView alloc]
                                   initWithFrame:CGRectZero];
            [selView setSelectType:OcnSelectTypeNormal];
            [selView setOptions:[dic allValues][0]];
            if (idx==0) {
                [selView setValue:[dic allValues][0][12]];
            }else if (idx==1){
                [selView setValue:[dic allValues][0][15]];
            }else if (idx==2){
                [selView setValue:[dic allValues][0][15]];
            }else if (idx==3){
                [selView setValue:[dic allValues][0][8]];
            }else{
            }
            selView.isScrollUp = NO;
            [selView setBackgroundColor:[UIColor whiteColor]];
            [selView setAlignment:UIControlContentHorizontalAlignmentCenter];
            [selView setTintColor:colorByStr(@"#9c9a96")];
            [selView setTag:3000+idx];
            [selView setEndDateBack:^(id sender){
                ALSelectView *theView=sender;
                NSString *str=[theView value];
                [selBtn setTitle:str forState:UIControlStateNormal];
                NSString *valStr=[str componentsSeparatedByString:@"cm"][0];
                switch (theView.tag) {
                    case 3000+0:
                        [theChildModel setBust:valStr];
                        self.theBlock(theChildModel);

                        break;
                    case 3000+1:
                        [theChildModel setWaistline:valStr];
                        self.theBlock(theChildModel);

                        break;
                    case 3000+2:
                        [theChildModel setHipline:valStr];
                        self.theBlock(theChildModel);

                        break;
                    case 3000+3:
                        [theChildModel setShoulder:valStr];
                        self.theBlock(theChildModel);

                        break;
                    default:
                        break;
                }
                [theChildModel setBar_size:valStr];
                self.theBlock(theChildModel);

            }];
             
            [self addSubview:selView];
            
            selBtn=[ALButton buttonWithType:UIButtonTypeCustom];
            [selBtn setFrame:CGRectMake(lbl.right + 25, lbl.top - 5, 130, 28)];
            [selBtn setBackgroundColor:[UIColor whiteColor]];
            [selBtn setTitle:@"cm" forState:UIControlStateNormal];
            [selBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [selBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [selBtn setTheBtnClickBlock:^(id sender){
                [selView showPickerView];
            }];
            [self addSubview:selBtn];
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
    [btnMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALButton *childBtn=obj;
        NSInteger index = childBtn.tag - 10000;
        if (index == tag) {
            [childBtn setSelected:YES];
            if (index == 0)
            {
                [theChildModel setHabitus:@"X体型"];
                self.theBlock(theChildModel);
            }
            if (index == 1)
            {
                [theChildModel setHabitus:@"A体型"];
                self.theBlock(theChildModel);
            }
            if (index == 2)
            {
                [theChildModel setHabitus:@"H体型"];
                self.theBlock(theChildModel);
            }
            if (index == 3)
            {
                [theChildModel setHabitus:@"Y体型"];
                self.theBlock(theChildModel);
            }
            if (index == 4)
            {
                [theChildModel setHabitus:@"O体型"];
                self.theBlock(theChildModel);
            }
            
            
        }else{
            [childBtn setSelected:NO];
        }
    }];
}

@end
