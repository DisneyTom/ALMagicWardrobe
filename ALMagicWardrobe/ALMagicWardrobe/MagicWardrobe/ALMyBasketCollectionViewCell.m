//
//  ALMyBasketCollectionViewCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMyBasketCollectionViewCell.h"
//#import "AFNconnectionImport.h"
@implementation ALMyBasketCollectionViewCell
{
    ALImageView *_imgView;
    ALLabel *_titLbl;
    ALButton *_addBtn;
    UIImageView *_selectedImg;
    UIImageView *_maskImg;
    
    ALMagicWardrobeClothsModel *_clothesModel;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        __block ALMyBasketCollectionViewCell *theBlockCtrl=self;
        _imgView=[[ALImageView alloc]
                  initWithFrame:CGRectMake(0, 0, 574/4, 644/4)];
        [self addSubview:_imgView];
        
        _titLbl=[[ALLabel alloc]
                 initWithFrame:CGRectMake(_imgView.left, _imgView.bottom, _imgView.width/3*2, 108/4)
                 andColor:colorByStr(@"#2E2C28")
                 andFontNum:11.5];
        [self addSubview:_titLbl];
        
        _addBtn=[ALButton buttonWithType:UIButtonTypeCustom];

        [_addBtn setFrame:CGRectMake(self.width-40, _imgView.bottom, 40, 40)];
        [_addBtn setImage:[ALImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_addBtn setTheBtnClickBlock:^(id sender){
            if (theBlockCtrl.theBlock) {
            //   [AFNconnectionImport connectionWifi];
                theBlockCtrl.theBlock(sender);
            }
        }];
        [self addSubview:_addBtn];
        
        _maskImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _maskImg.image = [UIImage imageNamed:@"trashSelectedStateMask.png"];
        _maskImg.hidden = YES;
       // [self addSubview:_maskImg];
        
        _selectedImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _selectedImg.image = [UIImage imageNamed:@"trashUnselectedState.png"];
        _selectedImg.hidden = YES;
       // [self addSubview:_selectedImg];
        

        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_imgView setFrame:CGRectMake(0, 0, 574/4, 644/4)];
    [_titLbl setFrame:CGRectMake(_imgView.left, _imgView.bottom, _imgView.width/3*2, 108/4)];
    
    [_addBtn setFrame:CGRectMake(self.width-20,  _imgView.bottom + 2, 20, 20)];

}
-(void)setModel:(ALMagicWardrobeClothsModel *)theModel
{
    if (theModel == nil)
    {
        _imgView.hidden = YES;
        _titLbl.hidden = YES;
        self.userInteractionEnabled = NO;
    }
    else
    {
        self.userInteractionEnabled = YES;
        _imgView.hidden = NO;
        _titLbl.hidden = NO;
        _clothesModel = theModel;
        [_imgView setImageWithURL:[NSURL URLWithString:theModel.main_image] placeholderImage:LoadIngImg];
        [_titLbl setText:theModel.name];
    }

}

- (void)setIsEdit:(BOOL)isEdit
{
    if (isEdit == YES)
    {
        _selectedImg.hidden = NO;
//        _selectedImg.hidden = NO;
    }
    else
    {
        _selectedImg.hidden = YES;
    }
    [self setNeedsLayout];
}

@end

