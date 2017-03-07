//
//  ALMagicBagCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-14.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicBagCell.h"

@implementation ALMagicBagCell{
    ALButton *_selectImgBtn;
    ALImageView *_goodsImgView;
    ALLabel *_goodsNameLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setMagicDic:(NSDictionary *)magicDic
            andSel:(BOOL)isSel
      andSelAction:(void(^)(BOOL sel))theBlock{
    [_selectImgBtn setSelected:isSel];
    
    [_goodsImgView setImage:[UIImage imageNamed:magicDic[@"img"]]];
    
    [_goodsNameLabel setText:magicDic[@"content"]];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _selectImgBtn = [[ALButton alloc] init];
        [_selectImgBtn setFrame:CGRectMake(5, (60-22)/2.0f, 22, 22)];
        [_selectImgBtn setImage:[UIImage imageNamed:@"shopping_btn_select_normal"] forState:UIControlStateNormal];
        [_selectImgBtn setImage:[UIImage imageNamed:@"shopping_img_select_check"] forState:UIControlStateSelected];
        [_selectImgBtn setTheBtnClickBlock:^(id sender){
        }];
        [self.contentView addSubview:_selectImgBtn];
        
        _goodsImgView = [[ALImageView alloc] init];
        [_goodsImgView setTag:202];
        [_goodsImgView setFrame:CGRectMake(40, 5, 50, 50)];
        [_goodsImgView setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:_goodsImgView];
        
        _goodsNameLabel = [[ALLabel alloc]
                                       initWithFrame:CGRectMake(112, 10, kScreenWidth-_goodsImgView.right, 50)
                                       Font:16
                                       BGColor:RGB_BG_Clear
                                       FontColor:RGB_Font_First_Title];
        [_goodsNameLabel setTag:203];
        [_goodsNameLabel setNumberOfLines:0];
        [_goodsNameLabel setVerticalAlignment:VerticalAlignmentTop];
        [self.contentView addSubview:_goodsNameLabel];
    }
    return self;
}
@end
