//
//  ALClothesTableViewCell.m
//  ALMagicWardrobe
//
//  Created by OCN on 15-4-2.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALClothesTableViewCell.h"

@interface ALClothesView : ALButton
-(void)setModel:(ALClothsModel *)theModel;
@end

@implementation ALClothesView{
    ALImageView *_imgView;
    ALLabel *_titLbl;
    ALImageView *_praseImgView;
    ALLabel *_praseNumLbl;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _imgView=[[ALImageView alloc]
                  initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:_imgView];
        
        _titLbl=[[ALLabel alloc]
                 initWithFrame:CGRectMake(_imgView.left, _imgView.bottom + 5, _imgView.width/3*2, 10)
                 andColor:colorByStr(@"#2E2C28")
                 andFontNum:10];
        [self addSubview:_titLbl];
        
        CGFloat width = self.bounds.size.width;
        CGFloat praseX = width - 55.f;
        _praseImgView=[[ALImageView alloc]
                       initWithFrame:CGRectMake(praseX,
                                                _titLbl.top - 2,
                                                12,
                                                12)];
        [_praseImgView setImage:[ALImage imageNamed:@"icon012"]];
        [self addSubview:_praseImgView];
        
        _praseNumLbl=[[ALLabel alloc]
                      initWithFrame:CGRectMake(_praseImgView.right+3, _titLbl.top, self.width-(_praseImgView.right+3), _titLbl.height)
                      andColor:colorByStr(@"#2E2C28")
                      andFontNum:10];
        [_praseNumLbl setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_praseNumLbl];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake(0, 0, self.width, self.height);
    _titLbl.frame = CGRectMake(_imgView.left, _imgView.bottom + 5, _imgView.width/3*2, 10);
    CGFloat width = self.bounds.size.width;
    CGSize size = [ALComAction getSizeByStr:_praseNumLbl.text andFont:[UIFont systemFontOfSize:10]];
     CGFloat praseX = width - size.width - 18;
    _praseImgView.frame = CGRectMake(praseX,_titLbl.top - 2,12,12);
    _praseNumLbl.frame = CGRectMake(_praseImgView.right+3, _titLbl.top, size.width, _titLbl.height);
    _praseNumLbl.textAlignment = NSTextAlignmentLeft;
}

-(void)setModel:(ALClothsModel *)theModel{

    if (theModel == nil)
    {
        _imgView.hidden = YES;
        _titLbl.hidden = YES;
        _praseImgView.hidden = YES;
        _praseNumLbl.hidden = YES;
    }
    else
    {
        _imgView.hidden = NO;
        _titLbl.hidden = NO;
        _praseImgView.hidden = NO;
        _praseNumLbl.hidden = NO;
        [_imgView setImageWithURL:[NSURL URLWithString:theModel.mainImage] placeholderImage:LoadIngImg];
        [_titLbl setText:theModel.name];
        NSString *title = theModel.collects;
        [_praseNumLbl setText:title];
        [self setNeedsLayout];
    }

}
@end

@implementation ALClothesTableViewCell{
    ALClothesView *_leftView;
    ALClothesView *_rightView;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = AL_RGB(240,236,233);
        __block ALClothesTableViewCell *theCell=self;
        _leftView=[[ALClothesView alloc]
                   initWithFrame:CGRectMake((self.width-148*2)/3, 0, 148, 170)];
        [_leftView setTheBtnClickBlock:^(id sender){
            if (theCell.theBlock)
            {
                theCell.theBlock(0);
            }
        }];
        [self addSubview:_leftView];
        
        _rightView=[[ALClothesView alloc]
                    initWithFrame:CGRectMake(_leftView.right+(self.width-148*2)/3, _leftView.top, _leftView.width, _leftView.height)];
        [_rightView setTheBtnClickBlock:^(id sender){
            if (theCell.theBlock) {
                theCell.theBlock(1);
            }
        }];
        [self addSubview:_rightView];
    }
    return self;
}
-(void)setLeftModel:(ALClothsModel *)theModel{
    [_leftView setModel:theModel];
}
-(void)setRightModel:(ALClothsModel *)theModel{
    [_rightView setModel:theModel];
}
@end
