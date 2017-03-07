//
//  ALMyMagicWardrobeCollectionViewCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-22.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMyMagicWardrobeCollectionViewCell.h"

@implementation ALMyMagicWardrobeCollectionViewCell
{
    ALImageView *_imgView;
    ALLabel *_titLbl;
    ALButton *_addBtn;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _imgView=[[ALImageView alloc] initWithFrame:CGRectMake(0, 0, 574/4, 644/4)];
        [self addSubview:_imgView];
        
        _titLbl=[[ALLabel alloc]
                 initWithFrame:CGRectMake(_imgView.left, _imgView.bottom, _imgView.width/3*2, 108/4)
                 andColor:colorByStr(@"#2E2C28")
                 andFontNum:11.5];
        [self addSubview:_titLbl];
        
        _addBtn=[ALButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setFrame:CGRectMake(self.width-20, _titLbl.top+(_titLbl.height-20)/2, 19, 20)];
        [_addBtn setImage:[ALImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        [_addBtn setTheBtnClickBlock:^(id sender){
            if (self.theBlock) {
                self.theBlock(sender);
            }
        }];
        [self addSubview:_addBtn];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_imgView setFrame:CGRectMake(0, 0, 574/4, 644/4)];
    [_titLbl setFrame:CGRectMake(_imgView.left, _imgView.bottom, _imgView.width/3*2, 108/4)];
    [_addBtn setFrame:CGRectMake(self.width-20, _titLbl.top+(_titLbl.height-20)/2, 19, 20)];
}
-(void)setModel:(ALMagicWardrobeClothsModel *)theModel{
    [_imgView setImageWithURL:[NSURL URLWithString:theModel.main_image] placeholderImage:LoadIngImg];
    [_titLbl setText:theModel.name];
}

@end
