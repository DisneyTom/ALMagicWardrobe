//
//  ALPersonalDataCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALPersonalDataCell.h"

@implementation ALPersonalDataCell{
    ALLabel *_leftLbl;
    ALLabel *_rightLbl;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftLbl=[[ALLabel alloc]
                          initWithFrame:CGRectMake(5, 0, 120, 45)];
        _rightLbl=[[ALLabel alloc]
                           initWithFrame:CGRectMake(_leftLbl.right, 0, 190, 45)];
        [self addSubview:_leftLbl];
        [self addSubview:_rightLbl];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setLeft:(NSString *)leftStr andRight:(NSString *)rightStr{
    [_leftLbl setText:leftStr];
    [_rightLbl setText:rightStr];
}

@end


@implementation MBCollectionShopCell
-(void)upLoad:(BOOL)isHua{
    UIView * contentView=nil;
    if (isHua) {
        contentView=self.actualContentView;
    }
    else{
        contentView=self.contentView;
    }
    
    _leftLabel = [[ALLabel alloc] initWithFrame:CGRectMake(95, 5, kScreenWidth-90 - 10, 80)];
    _leftLabel.numberOfLines = 0;
    _leftLabel.backgroundColor = [UIColor clearColor];
    _leftLabel.textColor = HEX(@"#5f5f5f");
    _leftLabel.font = [UIFont boldSystemFontOfSize:14];
//    _leftLabel.text = @"修改头像";
    _leftLabel.textAlignment = NSTextAlignmentLeft;
    [self.actualContentView addSubview:_leftLabel];
    
    _leftImageView = [[ALImageView alloc] init];
    [_leftImageView setFrame:CGRectMake(10, 5, 80, 80)];
    [_leftImageView setBackgroundColor:[UIColor clearColor]];
    _leftImageView.image = [UIImage imageNamed:@"collect_picture.png"];
    [self.actualContentView addSubview:_leftImageView];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier andCanHua:YES];
    if (self) {
        [self upLoad:YES];
    }
    return self;
}

-(void)setModel:(ALPeriodicalsModel *)theModel{
    [_leftImageView setImageWithURL:[NSURL URLWithString:theModel.mainImage] placeholderImage:LoadIngImg];
    [_leftLabel setText:theModel.title];
    [_leftLabel sizeToFit];
}
@end;

@implementation MBSetingPersonSubCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    
    _leftLabel = [[ALLabel alloc] initWithFrame:CGRectMake(20, 7, 80, 30)];
    _leftLabel.backgroundColor = [UIColor clearColor];
    _leftLabel.textColor = HEX(@"#5f5f5f");
    _leftLabel.font = [UIFont boldSystemFontOfSize:14];
    _leftLabel.text = @"修改头像";
    [self.contentView addSubview:_leftLabel];
    
    _rightLabel = [[ALLabel alloc] initWithFrame:CGRectMake(60, 7, kScreenWidth-70, 30)];
    _rightLabel.backgroundColor = [UIColor clearColor];
    _rightLabel.textColor = [UIColor blackColor];
    _rightLabel.font = [UIFont boldSystemFontOfSize:14];
    _rightLabel.text = @"";
    _rightLabel.textColor = HEX(@"#91908e");
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
    _rightImage = [[ALImageView alloc] init];
    [_rightImage setFrame:CGRectMake(kScreenWidth-50, 6, 30, 30)];
    [_rightImage setBackgroundColor:[UIColor clearColor]];
    _rightImage.image = [UIImage imageNamed:@"icon04.png"];
    [self.contentView addSubview:_rightImage];
    
//    CGFloat height = self.contentView.size.height;
//    _seperateImg = [[UIImageView alloc] initWithFrame:CGRectZero];
//    _seperateImg.frame = CGRectMake(0, height - 0.5, kScreenWidth, 0.5);
//    [self.contentView addSubview:_seperateImg];
//    _seperateImg.backgroundColor = AL_RGB(200, 191, 176);
    
//    UILabel *plues = [[UILabel alloc] initWithFrame:CGRectMake(0, 7,0, 30)];
//    plues.textColor = HEX(@"#91908e");
//    plues.tag = 1000000;
//    plues.font = [UIFont systemFontOfSize:16];
//    [self.contentView addSubview:plues];
//    
//    CGFloat dayX = CGRectGetMaxX(plues.frame);
//    UILabel *dayLbl = [[UILabel alloc] initWithFrame:CGRectMake(dayX, 7, 12, 30)];
//    dayLbl.font = [UIFont systemFontOfSize:10];
//    dayLbl.textColor = HEX(@"#91908e");
//    dayLbl.textAlignment = NSTextAlignmentLeft;
//    dayLbl.text = @"天";
//    dayLbl.tag = 1000001;
//    [self.contentView addSubview:dayLbl];
//    plues.hidden = YES;
//    dayLbl.hidden = YES;
    
}
-(void)setLeft:(NSString *)leftStr andRight:(NSString *)rightStr{
    [_leftLabel setText:leftStr];
    [_rightLabel setText:rightStr];
}
@end;

