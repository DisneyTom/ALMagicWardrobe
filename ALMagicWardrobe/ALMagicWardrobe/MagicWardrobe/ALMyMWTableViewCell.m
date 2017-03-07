//
//  ALMyMWTableViewCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-4-25.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMyMWTableViewCell.h"
#import "ALMagicWardrobeClothsModel.h"

typedef void (^BackBlock)(id sender);

@interface ALMyMWView : ALButton
-(void)setModel:(ALMagicWardrobeClothsModel *)theModel;
@property(nonatomic,copy) BackBlock theBlock;

@end

@implementation ALMyMWView
{
    ALImageView *_imgView;
    ALLabel *_titLbl;
    ALButton *_addBtn;
    ALButton *btn;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _imgView=[[ALImageView alloc]
                  initWithFrame:CGRectMake(10, 0, 574/4, 644/4)];
//        [_imgView setUserInteractionEnabled:YES];
        [self addSubview:_imgView];
        
        _titLbl=[[ALLabel alloc]
                 initWithFrame:CGRectMake(_imgView.left, _imgView.bottom, _imgView.width/3*2, 108/4)
                 andColor:colorByStr(@"#2E2C28")
                 andFontNum:11.5];
        [self addSubview:_titLbl];
        
        _addBtn=[ALButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setFrame:CGRectMake(self.width-25, _titLbl.top+(_titLbl.height-25)/2, 25, 25)];
        [_addBtn setImage:[ALImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        __block ALMyMWView *theBlockView=self;
        [_addBtn setTheBtnClickBlock:^(id sender){
            if (theBlockView.theBlock) {
                theBlockView.theBlock(sender);
            }
        }];
        [self addSubview:_addBtn];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGFloat height = bounds.size.height;
    [_imgView setFrame:CGRectMake(10, 0, 574/4, 644/4)];
    [_titLbl setFrame:CGRectMake(_imgView.left, _imgView.bottom, _imgView.width/3*2, 108/4)];
    [_addBtn setFrame:CGRectMake(self.width-25, height - 25.f - 10, 25, 25)];
//    [_addBtn  setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
//    [_addBtn setBackgroundColor:[UIColor redColor]];
}
-(void)setModel:(ALMagicWardrobeClothsModel *)theModel{
//    [_imgView setImageWithURL:[NSURL URLWithString:theModel.main_image] placeholderImage:LoadIngImg];
//    [_titLbl setText:theModel.name];
    
    if (theModel == nil)
    {
        _imgView.hidden = YES;
        _titLbl.hidden = YES;
        _addBtn.hidden = YES;
        self.userInteractionEnabled = NO;
    }
    else
    {
        _imgView.hidden = NO;
        _titLbl.hidden = NO;
        _addBtn.hidden = NO;
         self.userInteractionEnabled = YES;
        [_imgView setImageWithURL:[NSURL URLWithString:theModel.main_image] placeholderImage:LoadIngImg];
        [_titLbl setText:theModel.name];
    }

    
}

@end

#pragma mark -
#pragma mark ==============================

@implementation ALMyMWTableViewCell
{
    ALMyMWView *_leftView;
    ALMyMWView *_rightView;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        __block ALMyMWTableViewCell *theCell=self;
        _leftView=[[ALMyMWView alloc]
                   initWithFrame:CGRectMake(0, 0, 574/4, 644/4+10+108/4)];
        [_leftView setTheBtnClickBlock:^(id sender){
            if (theCell.theBigBlock) {
                theCell.theBigBlock(0);
            }
        }];
        [_leftView setTheBlock:^(id sender){
            if (theCell.theSmallBlock) {
                theCell.theSmallBlock(0);
            }
        }];

        [self addSubview:_leftView];
        
        _rightView=[[ALMyMWView alloc]
                    initWithFrame:CGRectMake(_leftView.right+10, _leftView.top, _leftView.width, _leftView.height)];
        [_rightView setTheBtnClickBlock:^(id sender){
            if (theCell.theBigBlock) {
                theCell.theBigBlock(1);
            }

        }];
        [_rightView setTheBlock:^(id sender){
            if (theCell.theSmallBlock) {
                theCell.theSmallBlock(1);
            }
        }];
        [self addSubview:_rightView];
        

    }
    return self;
}
-(void)setLeftModel:(ALMagicWardrobeClothsModel *)theModel{
    [_leftView setModel:theModel];
}
-(void)setRightModel:(ALMagicWardrobeClothsModel *)theModel{
    [_rightView setModel:theModel];
}

@end
