//
//  MGUI_SquareTableViewCell.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUI_SquareTableViewCell.h"


@implementation MGUI_SquareTableViewCell

{
    UIImageView*    imgView;
    UILabel*        lbl_count;
    UIImageView*    imgView_Bottom;
    UILabel*        lbl_Content;
    UILabel*        lbl_Size;
    UILabel*        lbl_Line;
    UILabel*        lbl_Time;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  self.contentView.backgroundColor = AL_RGB(240,236,233);
        imgView_Bottom = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btt"]];
        imgView = [[UIImageView alloc]initWithImage:LoadIngImg];
        imgView.layer.cornerRadius = 2;
        imgView.userInteractionEnabled = true;
        imgView.clipsToBounds = true;
        lbl_count = [[UILabel alloc]init];
        lbl_count.textColor = [UIColor blackColor];
        lbl_count.font = [UIFont systemFontOfSize:11];
        lbl_Content = [[UILabel alloc]init];
        lbl_Content.textColor = [UIColor blackColor];
        lbl_Content.font = [UIFont systemFontOfSize:13];
        lbl_Size  = [[UILabel alloc]init];
        lbl_Size.textColor = [UIColor blackColor];
        lbl_Size.font = [UIFont systemFontOfSize:13];
        lbl_Size.textAlignment = NSTextAlignmentRight;
        [self addSubview:imgView];
        [imgView addSubview:imgView_Bottom];
        [imgView_Bottom addSubview:lbl_Content];
        [imgView_Bottom addSubview:lbl_Size];
        [imgView_Bottom addSubview:lbl_count];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    imgView.frame = CGRectMake(10, 0, kScreenWidth - 20, (kScreenWidth - 20)*1354/1200);
    lbl_count.frame = CGRectMake(10, 26, imgView.width - 20, 20);
     imgView_Bottom.frame = CGRectMake(0, imgView.height - 54, imgView.width, 54);
    lbl_Size.frame = CGRectMake(imgView.width - 100 - 10, 5, 100, 20);
    lbl_Content.frame = CGRectMake(10, 8, imgView.width - 20 - 100, 20);
}
-(void)setModel:(MGData_KeyFashions *)theModel
{
    [imgView setImageWithURL:[NSURL URLWithString:theModel.imageUrl] placeholderImage:LoadIngImg];
    lbl_Content.text = theModel.name;
    lbl_count.text = theModel.collects;
    lbl_Size.text = [theModel.size stringByReplacingOccurrencesOfString:@"," withString:@"/"];
    
    NSString* string_C = [NSString stringWithFormat:@"已有%@人加入了衣橱",theModel.collects];
    NSMutableAttributedString *string_Collect=[[NSMutableAttributedString alloc] initWithString:string_C];
 
    [string_Collect addAttribute:NSForegroundColorAttributeName value:ALUIColorFromHex(0xa07845) range:NSMakeRange(2, theModel.collects.length)];
  
    lbl_count.attributedText = string_Collect;
       [self layoutSubviews];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end