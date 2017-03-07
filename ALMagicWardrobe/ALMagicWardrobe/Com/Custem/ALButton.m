//
//  ALButton.m
//  OcnO2O
//
//  Created by OCN on 14-12-26.
//  Copyright (c) 2014年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import "ALButton.h"

@implementation ALButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setFrame:(CGRect)frame andTit:(NSString *)tit andGoImgView:(NSString *)imgName{
    [super setFrame:frame];
    ALComView *vipDetailView_4=[[ALComView alloc]
                              initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [vipDetailView_4 setBackgroundColor:[UIColor whiteColor]];
    [vipDetailView_4 setCustemViewWithType:BothLine_type
                           andTopLineColor:RGB_Line_Gray
                        andBottomLineColor:RGB_Line_Gray];
    [vipDetailView_4 setTag:104];
    [self addSubview:vipDetailView_4];
    
    UIView *lineView = [[UIView alloc]
                        initWithFrame:CGRectMake(0, 40, kScreenWidth, 1)];
    [lineView setBackgroundColor:RGB_Line_Gray];
    [vipDetailView_4 addSubview:lineView];
    
    ALLabel *vipTitle_4 = [[ALLabel alloc]
                            initWithFrame:CGRectMake(10, 1, 150, 38)
                            BoldFont:14
                            BGColor:RGB_BG_Clear
                            FontColor:RGB_Font_First_Title];
    [vipTitle_4 setText:tit];
    [vipDetailView_4 addSubview:vipTitle_4];
    
    [self setImage:IMG_WITH_NAME(imgName) forState:UIControlStateNormal];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 285, 0, 0)];
    
    [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    OcnButton *vipGoBtn_4 = [OcnButton buttonWithType:UIButtonTypeCustom];
    //    [vipGoBtn_4 setTag:204];
    //    [vipGoBtn_4 setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    //    [vipGoBtn_4 setImage:Img(@"btn_next@2x", @"png") forState:UIControlStateNormal];
    //    [vipGoBtn_4 setImageEdgeInsets:UIEdgeInsetsMake(0, 285, 0, 0)];
    //    [vipGoBtn_4 setTheBtnClickBlock:^(id sender){
    //    }];
    //    [vipDetailView_4 addSubview:vipGoBtn_4];
}
-(void)click:(id)sender{
    if (self.theBtnClickBlock) {
        self.theBtnClickBlock(sender);
    }
}

-(void)setAlignment{
    
    //    [self setBackgroundColor:[UIColor grayColor]];
    //    [self.titleLabel setBackgroundColor:[UIColor greenColor]];
    
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
    
    float width=0;
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(2,
                                              (self.width-self.imageView.width)/2.0f,
                                              self.height/3.0f*1,
                                              (self.width-self.imageView.width)/2.0f)];
    if (self.selected) {
        [self.titleLabel setWidth:[ALComAction getSizeByStr:[self titleForState:UIControlStateSelected]
                                                     andFont:self.titleLabel.font].width];
        width=[ALComAction getSizeByStr:[self titleForState:UIControlStateSelected]
                                 andFont:self.titleLabel.font].width;
        
    }
    else{
        [self.titleLabel setWidth:[ALComAction getSizeByStr:[self titleForState:UIControlStateNormal]
                                                     andFont:self.titleLabel.font].width];
        width=[ALComAction getSizeByStr:[self titleForState:UIControlStateNormal]
                                 andFont:self.titleLabel.font].width;
    }
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.height/3.0f*2,
                                              (self.width-width)/2.0f-self.imageView.width,
                                              0,
                                              (self.width-width)/2.0f-self.imageView.width)];
}

- (void)setFirstAlignment
{
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
    
    float width=0;
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(0,
                                              0,
                                              15,
                                              0)];
    if (self.selected) {
        [self.titleLabel setWidth:[ALComAction getSizeByStr:[self titleForState:UIControlStateSelected]
                                                    andFont:self.titleLabel.font].width];
        width=[ALComAction getSizeByStr:[self titleForState:UIControlStateSelected]
                                andFont:self.titleLabel.font].width;
        
    }
    else{
        [self.titleLabel setWidth:[ALComAction getSizeByStr:[self titleForState:UIControlStateNormal]
                                                    andFont:self.titleLabel.font].width];
        width=[ALComAction getSizeByStr:[self titleForState:UIControlStateNormal]
                                andFont:self.titleLabel.font].width;
    }
    [self.titleLabel setFont:[UIFont systemFontOfSize:10]];
//    self.titleLabel.backgroundColor = [UIColor redColor];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    if (self.index == 0)
    {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(50,
                                                  (self.width-width)/2.0f-self.imageView.width,
                                                  0,
                                                  (self.width-width)/2.0f-self.imageView.width)];
    }
    else
    {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(50,
                                                  (self.width-width)/2.0f-self.imageView.width +5,
                                                  0,
                                                  (self.width-width)/2.0f-self.imageView.width)];
    }

}

@end
