//
//  ALAddressCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALAddressCell.h"

@implementation ALAddressCell{
    ALLabel *_leftLbl;
    ALImageView *rightImgView;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftLbl=[[ALLabel alloc] initWithFrame:CGRectMake(0, 0, self.width-70, 230/4)];
        [self addSubview:_leftLbl];
        
        rightImgView=[[ALImageView alloc] initWithFrame:CGRectMake(_leftLbl.right, (self.height-30)/2, 20, 30)];
        [rightImgView setImage:[ALImage imageNamed:@"icon_next"]];
        [self addSubview:rightImgView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_leftLbl setFrame:CGRectMake(0, 0, self.width-70, 230/4)];
    [rightImgView setFrame:CGRectMake(_leftLbl.right, (self.height-30)/2, 20, 30)];
}
-(void)setAddress:(NSString *)address{
    [_leftLbl setText:address];
}
@end
