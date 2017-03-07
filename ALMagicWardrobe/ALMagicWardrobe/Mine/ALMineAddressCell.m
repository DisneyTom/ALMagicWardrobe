//
//  ALMineAddressCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-4-15.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMineAddressCell.h"

@implementation ALMineAddressCell{
    ALButton *_selBtn;
    ALLabel *_titLbl;
}
-(void)upLoad:(BOOL)isHua{
    UIView * contentView=nil;
    if (isHua) {
        contentView=self.actualContentView;
    }
    else{
        contentView=self.contentView;
    }
    _selBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [_selBtn setFrame:CGRectMake(kLeftSpace, 10, 20, 20)];
    [_selBtn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
    [_selBtn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
    __block ALMineAddressCell * theBlockCell=self;
    [_selBtn setTheBtnClickBlock:^(id sender){
        ALButton *btn=sender;
        [btn setSelected:!btn.selected];
        if (theBlockCell.theBlock) {
            theBlockCell.theBlock(btn.selected);
        }
    }];
    [contentView addSubview:_selBtn];
    
    _titLbl=[[ALLabel alloc]
             initWithFrame:CGRectMake(_selBtn.left+10, 0, self.width-_selBtn.right-kRightSpace, self.height) andColor:[UIColor blackColor] andFontNum:13];
    [_titLbl setNumberOfLines:0];
    [contentView addSubview:_titLbl];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_selBtn setFrame:CGRectMake(kLeftSpace, (self.height-_selBtn.height)/2, 20, 20)];
    [_titLbl setFrame:CGRectMake(_selBtn.right+10, 0, self.width-_selBtn.right-kRightSpace, self.height)];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier andCanHua:YES];
    if (self) {
        [self upLoad:YES];
    }
    return self;
}
-(void)setSel:(BOOL)sel{
    [_selBtn setSelected:sel];
}
-(void)setModel:(ALAddressModel *)theModel{
    [_titLbl setText:[NSString stringWithFormat:@"%@%@%@",MBNonEmptyString(theModel.province),MBNonEmptyString(theModel.city),MBNonEmptyString(theModel.address)]];
        if ([theModel.isdefault isEqualToString:@"Y"]) {
            [_selBtn setSelected:YES];
        }else{
            [_selBtn setSelected:NO];
        }
}

@end
