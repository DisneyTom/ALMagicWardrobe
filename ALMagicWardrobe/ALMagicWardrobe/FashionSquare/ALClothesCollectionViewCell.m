//
//  ClothesCollectionViewCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-18.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALClothesCollectionViewCell.h"

@implementation ALClothesCollectionViewCell{
    ALImageView *_imgView;
    ALLabel *_titLbl;
    ALImageView *_praseImgView;
    ALLabel *_praseNumLbl;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _imgView=[[ALImageView alloc]
                  initWithFrame:CGRectMake(0, 0, 574/4, 644/4)];
        [self addSubview:_imgView];
        
        _titLbl=[[ALLabel alloc]
                 initWithFrame:CGRectMake(_imgView.left, _imgView.bottom, _imgView.width/3*2, 108/4)
                 andColor:colorByStr(@"#2E2C28")
                 andFontNum:11.5];
        [self addSubview:_titLbl];
        
        _praseImgView=[[ALImageView alloc]
                       initWithFrame:CGRectMake(_titLbl.right,
                                                _titLbl.top+(108/4-17)/2,
                                                16,
                                                17)];
        [_praseImgView setImage:[ALImage imageNamed:@"icon012"]];
        [self addSubview:_praseImgView];
        
        _praseNumLbl=[[ALLabel alloc]
                      initWithFrame:CGRectMake(_praseImgView.right+3,
                                               _titLbl.top,
                                               80,
                                               _titLbl.height)
                      andColor:colorByStr(@"#2E2C28")
                      andFontNum:11.5];
        [self addSubview:_praseNumLbl];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_imgView setFrame:CGRectMake(0, 0, 574/4, 644/4)];
    [_titLbl setFrame:CGRectMake(_imgView.left, _imgView.bottom, _imgView.width/3*2, 108/4)];
    [_praseImgView setFrame:CGRectMake(_titLbl.right, _titLbl.top+(108/4-17)/2, 16, 17)];
    [_praseNumLbl setFrame:CGRectMake(_praseImgView.right+3, _titLbl.top, 80, _titLbl.height)];
}

-(void)setModel:(ALClothsModel *)theModel{
    [_imgView setImageWithURL:[NSURL URLWithString:theModel.mainImage] placeholderImage:LoadIngImg];
    [_titLbl setText:theModel.name];
    [_praseNumLbl setText:theModel.collects];
}
@end
