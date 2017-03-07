//
//  ALMagicBagBuyCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-22.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicBagBuyCell.h"
#import "UIKit+AFNetworking.h"

@implementation ALMagicBagBuyCell{
    ALButton *_selBtn;
    ALImageView *_imgView;
    ALLabel *_titLbl;
    ALLabel *_subTitLbl;
    ALLabel *_priceLbl;
    ALLabel *line;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _selBtn=[ALButton buttonWithType:UIButtonTypeCustom];
        [_selBtn setFrame:CGRectZero];
        [_selBtn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
        [_selBtn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
        [_selBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selBtn];
        
        _imgView=[[ALImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imgView];
        
        _titLbl=[[ALLabel alloc] initWithFrame:CGRectZero andColor:colorByStr(@"#9D9D9D") andFontNum:14];
        [self addSubview:_titLbl];
        
        _subTitLbl=[[ALLabel alloc] initWithFrame:CGRectZero andColor:colorByStr(@"#636363") andFontNum:13];
        [self addSubview:_subTitLbl];
        
        _priceLbl=[[ALLabel alloc] initWithFrame:CGRectZero andColor:colorByStr(@"#977D51") andFontNum:14];
        [self addSubview:_priceLbl];
        
        line=[[ALLabel alloc]
                       initWithFrame:CGRectZero];
        [line setBackgroundColor:colorByStr(@"#a07845")];
        [self addSubview:line];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_selBtn setFrame:CGRectMake(kLeftSpace, (self.height-20)/2, 20, 20)];
//    _selBtn.backgroundColor = [UIColor redColor];
    
    [_imgView setFrame:CGRectMake(_selBtn.right+5, 5, 50, self.height-5-5)];
    [_titLbl setFrame:CGRectMake(_imgView.right+5, (self.height-25*2)/2, 120, 25)];
    [_subTitLbl setFrame:CGRectMake(_titLbl.left, _titLbl.bottom, _titLbl.width, _titLbl.height)];
    [_priceLbl setFrame:CGRectMake(_subTitLbl.right, _subTitLbl.top-5, 100, 30)];
    [line setFrame:CGRectMake(0, self.height-.5f, self.width, .5f)];
}
-(void)setDic:(NSDictionary *)dic{
    [_imgView setImageWithURL:[NSURL URLWithString:dic[@"mainImage"]] placeholderImage:nil];
    [_titLbl setText:dic[@"introduce"]];
    [_subTitLbl setText:dic[@"name"]];
//    [_priceLbl setText:[NSString stringWithFormat:@"￥%@元",[dic[@"price"] stringValue]]];
    NSString *str=[NSString stringWithFormat:@"￥%@元",[dic[@"price"] stringValue]];
    NSMutableAttributedString *newStr=[[NSMutableAttributedString alloc] initWithString:str];
    [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:21] range:NSMakeRange(0, str.length-1)];
    [_priceLbl setAttributedText:newStr];
    
}
-(void)selBuy:(BOOL)isSel{
    [_selBtn setSelected:isSel];
}

#pragma mark - 按钮点击按钮
- (void)btnClick:(UIButton *)btn
{
    if(_cellIndexBlock != nil)
    {
        _cellIndexBlock(self.index);
    }
}

@end
