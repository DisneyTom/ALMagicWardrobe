//
//  ALMagicWardrobeCollectionViewCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-20.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicWardrobeCollectionViewCell.h"

@implementation ALMagicWardrobeCollectionViewCell
{
    ALImageView *_imgView;
    ALLabel *_titLbl;
    ALImageView *_praseImgView;
    ALLabel *_praseNumLbl;
//    ALButton *_addBtn;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _imgView=[[ALImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 170)];
        [self addSubview:_imgView];
        _titLbl  =[[ALLabel alloc]
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
-(void)layoutSubviews{
    [super layoutSubviews];
    _imgView.frame = CGRectMake(0, 0, self.width, 170);
    _titLbl.frame = CGRectMake(_imgView.left, _imgView.bottom + 5, _imgView.width/3*2, 10);
    CGFloat width = self.bounds.size.width;
    CGSize size = [ALComAction getSizeByStr:_praseNumLbl.text andFont:[UIFont systemFontOfSize:10]];
    CGFloat praseX = width - size.width - 18;
    _praseImgView.frame = CGRectMake(praseX,_titLbl.top - 2,12,12);
    _praseNumLbl.frame = CGRectMake(_praseImgView.right+3, _titLbl.top, size.width, _titLbl.height);
    _praseNumLbl.textAlignment = NSTextAlignmentLeft;
}

-(void)setModel:(ALClothsModel *)theModel{
    [_imgView setImageWithURL:[NSURL URLWithString:theModel.mainImage] placeholderImage:LoadIngImg];
    [_titLbl setText:theModel.name];
    [_praseNumLbl setText:theModel.collects];
    [self setNeedsLayout];
}

@end
