//
//  ALMagicBagRecoderTableViewCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicBagRecoderTableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "NSDateUtilities.h"

@implementation ALMagicBagRecoderTableViewCell{
    ALComView *_bgView;
    ALLabel *_recorderDateLbl;  //开始时间
    UILabel *_bagNameTipLbl; //魔法包Tip
    UILabel *_bagUsedTipLbl;
    UILabel *_dayTipLbl;
    ALLabel *_bagNumLbl;
    ALLabel *_recorderDayLbl; //使用天数
    ALButton *_recommentBtn; //评价按钮
    ALLabel *_lineLbl; //分割线
    ALComView *_clothesView; //放衣服容器
}
-(id)initWithStyle:(UITableViewCellStyle)style
   reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        __block ALMagicBagRecoderTableViewCell *theCell=self;
        
        _bgView=[[ALComView alloc] initWithFrame:CGRectMake(0, 5, self.width, self.height-5)];
        [_bgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_bgView];
        
        _recorderDateLbl=[[ALLabel alloc] initWithFrame:CGRectMake(kLeftSpace, 0, self.width-kLeftSpace, 30) andColor:colorByStr(@"666666") andFontNum:13];
        
        
        [_recorderDateLbl setKeyWordTextString:@"月" WithFont:[UIFont systemFontOfSize:18] AndColor:[UIColor blueColor]];
        [_bgView addSubview:_recorderDateLbl];
        
        UIFont *font = [UIFont systemFontOfSize:12];
        _bagNameTipLbl = [self buildLbl:@"魔法包" font:font alignment:NSTextAlignmentRight];
        
        _bagUsedTipLbl = [self buildLbl:@"使用" font:font alignment:NSTextAlignmentCenter];
        
        _dayTipLbl = [self buildLbl:@"天" font:font alignment:NSTextAlignmentCenter];
        
        
        //编号
        _bagNumLbl=[[ALLabel alloc]
                         initWithFrame:CGRectMake(45,
                                                  35,
                                                  50,
                                                  16)];
        [_bgView addSubview:_bagNumLbl];
        _bagNumLbl.textColor = AL_RGB(154, 96, 0);
        
        _recorderDayLbl=[[ALLabel alloc]
                         initWithFrame:CGRectMake(120,
                                                  35,
                                                  30,
                                                  16)];
        [_bgView addSubview:_recorderDayLbl];
        _recorderDayLbl.textColor = AL_RGB(154, 96, 0);
        
        _recommentBtn=[ALButton buttonWithType:UIButtonTypeCustom];
        [_recommentBtn setFrame:CGRectMake(_recorderDayLbl.right, _recorderDayLbl.top, 55, 20)];
        [_recommentBtn setTitle:@"评价" forState:UIControlStateNormal];
        [_recommentBtn setBackgroundImage:[ALImage imageNamed:@"btn_evaluate"]
                                 forState:UIControlStateNormal];
        _recommentBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_recommentBtn setTheBtnClickBlock:^(id sender){
            if (theCell.theBlock) {
                theCell.theBlock(sender);
            }
        }];
       
        [_bgView addSubview:_recommentBtn];
        
        _lineLbl=[[ALLabel alloc]
                  initWithFrame:CGRectMake(0, _recommentBtn.bottom+5, self.width, .5f)];
        [_lineLbl setBackgroundColor:Line_Color];
        [_bgView addSubview:_lineLbl];
        
        _clothesView=[[ALComView alloc]
                      initWithFrame:CGRectMake(0, _lineLbl.bottom+5, self.width, 600/4)];
        [_bgView addSubview:_clothesView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_bgView setFrame:CGRectMake(0, 5, self.width, self.height-5)];
    [_recorderDateLbl setFrame:CGRectMake(kLeftSpace, 0, self.width-kLeftSpace, 30)];
    
    _bagNameTipLbl.frame = CGRectMake(0, 40, 49, 12);
    CGSize numSize = [ALComAction getSizeByStr:_bagNumLbl.text andFont:[UIFont systemFontOfSize:15]];
    CGFloat bagNumX = CGRectGetMaxX(_bagNameTipLbl.frame) + 4.f;
    _bagNumLbl.frame = CGRectMake(bagNumX, 35, numSize.width, 15);
    
    CGFloat usedX = CGRectGetMaxX(_bagNumLbl.frame) + 2;
    _bagUsedTipLbl.frame = CGRectMake(usedX, 40, 30, 12);
    CGFloat dayX = CGRectGetMaxX(_bagUsedTipLbl.frame) + 2;
    CGSize numSize2 = [ALComAction getSizeByStr:_recorderDayLbl.text andFont:[UIFont systemFontOfSize:15]];
    _recorderDayLbl.frame = CGRectMake(dayX, 35, numSize2.width, 15);
    CGFloat dayTipX = CGRectGetMaxX(_recorderDayLbl.frame) + 4;
    _dayTipLbl.frame = CGRectMake(dayTipX, 40, 12, 12);
    
//    [_recorderDayLbl setFrame:CGRectMake(kLeftSpace,
//                                         _recorderDateLbl.bottom,
//                                         self.width-74-kLeftSpace-kRightSpace,
//                                         40)];
    [_recommentBtn setFrame:CGRectMake(self.width - 55 -15, 30, 55, 20)];
    [_lineLbl setFrame:CGRectMake(0, _recommentBtn.bottom+5, self.width, .5f)];
    [_clothesView setFrame:CGRectMake(0, _lineLbl.bottom+5, self.width, 600/4)];
}
-(void)setDic:(NSDictionary *)dic{
    NSString *iscommend = dic[@"isAllAsses"];
    if ( [iscommend isEqualToString:@"Y"]) {
        [_recommentBtn setHidden:YES];
    }else{
        [_recommentBtn setHidden:NO];
    }
    
    [_recorderDateLbl setText:[[NSDate dateWithTimeIntervalString:[dic[@"magicExpress"][@"startDate"] stringValue]] dateString]];
    _bagNumLbl.text = [dic[@"magicExpress"][@"id"] stringValue];
    _recorderDayLbl.text = [dic[@"magicExpress"][@"useDays"] stringValue];
    
//    [_recorderDayLbl setText:[NSString stringWithFormat:@"魔法包%@使用%@天",[dic[@"magicExpress"][@"id"] stringValue],[dic[@"magicExpress"][@"useDays"] stringValue]]];
    
    [_clothesView removeAllSubviews];
    
    NSArray *arr=dic[@"fashions"];
    float width=(self.width-5*4)/3;
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *theDic=obj;
        
        ALImageView *imgView=[[ALImageView alloc]
                              initWithFrame:CGRectMake(
                                                       5*(idx+1)+width*idx,
                                                       5,
                                                       width,
                                                       _clothesView.height-20)];
        [imgView setImageWithURL:[NSURL URLWithString:theDic[@"main_image"]]
                placeholderImage:LoadIngImg];
        [_clothesView addSubview:imgView];
        
        ALLabel *lblView=[[ALLabel alloc] initWithFrame:CGRectMake(imgView.left,
                                                                   imgView.bottom,
                                                                   imgView.width,
                                                                   20)
                                               andColor:[UIColor blackColor]
                                             andFontNum:14];
        [lblView setTextAlignment:NSTextAlignmentCenter];
        [lblView setText:theDic[@"grade"]];
        lblView.textColor = AL_RGB(54, 54, 54);
        [_clothesView addSubview:lblView];
    }];
    [self setNeedsLayout];
}

#pragma mark - 建立Lbl
- (UILabel *)buildLbl:(NSString *)title font:(UIFont *)font alignment:(NSTextAlignment)alignment
{
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectZero];
    lbl.textAlignment = alignment;
    lbl.font = font;
    lbl.text = title;
    lbl.textColor = AL_RGB(158, 158, 158);
    [_bgView addSubview:lbl];
    return lbl;
}
@end
