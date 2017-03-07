//
//  MGUI_TypeViewCell.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/16.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUI_TypeViewCell.h"

@interface ALClothesViews : ALButton
-(void)setModel:(MGData_Type *)theModel;
@end

@implementation ALClothesViews{
    ALImageView *_imgView;
    ALImageView *_praseImgView;
    ALLabel * lbl_Title;
    ALLabel * lbl_Size;
    ALLabel * lbl_Collect;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _imgView=[[ALImageView alloc]
                  initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:_imgView];
        _praseImgView = [[ALImageView alloc]initWithFrame:CGRectMake(0,  self.height - 40, self.width, 40)];
        _praseImgView.image = [UIImage imageNamed:@"touming"];
        lbl_Title = [[ALLabel alloc]init];
        lbl_Title.font = [UIFont systemFontOfSize:10];
        lbl_Title.textColor = [UIColor blackColor];
        lbl_Size = [[ALLabel alloc]init];
        lbl_Size.font = [UIFont systemFontOfSize:10];
        lbl_Size.textColor = [UIColor blackColor];
        lbl_Size.textAlignment = NSTextAlignmentRight;
        lbl_Collect = [[ALLabel alloc]init];
        lbl_Collect.font = [UIFont systemFontOfSize:10];
        lbl_Collect.textColor = [UIColor blackColor];
        lbl_Title.frame = CGRectMake(5, 0, 100, 20);
        lbl_Collect.frame = CGRectMake(5, 20, self.width - 5, 20);
        lbl_Size.frame = CGRectMake(95, 0, 50, 20);
        [_praseImgView addSubview:lbl_Title];
        [_praseImgView addSubview:lbl_Size];
        [_praseImgView addSubview:lbl_Collect];
        [_imgView addSubview:_praseImgView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake(0, 0, self.width, self.height);

}

-(void)setModel:(MGData_Type *)theModel{
    
    if (theModel == nil)
    {
        _imgView.hidden = YES;
        _praseImgView.hidden = YES;

    }
    else
    {
        NSString* string_C = [NSString stringWithFormat:@"已有%@人加入了衣橱",theModel.collects];
        NSMutableAttributedString *string_Collect=[[NSMutableAttributedString alloc] initWithString:string_C];
        [string_Collect addAttribute:NSForegroundColorAttributeName value:ALUIColorFromHex(0xa07845) range:NSMakeRange(2, theModel.collects.length)];
        lbl_Title.text = theModel.name;
        lbl_Collect.attributedText = string_Collect;
        lbl_Size.text = [theModel.size stringByReplacingOccurrencesOfString:@"," withString:@"/"];
        _imgView.hidden = NO;
        _praseImgView.hidden = NO;
        [_imgView setImageWithURL:[NSURL URLWithString:theModel.imageUrl] placeholderImage:LoadIngImg];
        [self setNeedsLayout];
    }
    
}
@end

@implementation MGUI_TypeViewCell{
    ALClothesViews *_leftView;
    ALClothesViews *_rightView;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = AL_RGB(240,236,233);
        __block MGUI_TypeViewCell *theCell=self;
        _leftView=[[ALClothesViews alloc]
                   initWithFrame:CGRectMake((self.width-150*2)/3, 0, 150, 170)];
        [_leftView setTheBtnClickBlock:^(id sender){
            if (theCell.theBlock)
            {
                theCell.theBlock(0);
            }
        }];
        [self addSubview:_leftView];
        
        _rightView=[[ALClothesViews alloc]
                    initWithFrame:CGRectMake(_leftView.right+(self.width-150*2)/3, _leftView.top, _leftView.width, _leftView.height)];
        [_rightView setTheBtnClickBlock:^(id sender){
            if (theCell.theBlock) {
                theCell.theBlock(1);
            }
        }];
        [self addSubview:_rightView];
    }
    return self;
}
-(void)setLeftModel:(MGData_Type *)theModel{
    [_leftView setModel:theModel];
}
-(void)setRightModel:(MGData_Type *)theModel{
    [_rightView setModel:theModel];
}
@end


