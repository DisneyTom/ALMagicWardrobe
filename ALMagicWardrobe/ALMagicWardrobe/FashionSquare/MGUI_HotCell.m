//
//  MGUI_HotCell.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/6/23.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUI_HotCell.h"
#import "ALButton.h"

@implementation MGUI_HotCell
{
    UIImageView*  imgView;
    UIImageView*  imgView_BkgCollection;
    UIImageView*  imgView_Collection;
    UILabel*      lbl_count;
    UIImageView* imgView_Bottom;
    UILabel*      lbl_Content;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      //  self.contentView.backgroundColor = AL_RGB(240,236,233);
        
        imgView_Bottom = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shadow_img"]];
        imgView= [[UIImageView alloc]init];
        imgView.layer.cornerRadius = 2;
        imgView.userInteractionEnabled = true;
        imgView.clipsToBounds = true;
        imgView_BkgCollection = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_like"]];
        imgView_Collection = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_like"]];
        lbl_count = [[UILabel alloc]init];
        lbl_count.textColor = [UIColor whiteColor];
        lbl_count.font = [UIFont systemFontOfSize:10];
        lbl_count.textAlignment = NSTextAlignmentCenter;
        lbl_Content = [[UILabel alloc]init];
        lbl_Content.textColor = [UIColor whiteColor];
//        lbl_Content.backgroundColor = [ UIColor redColor];
        lbl_Content.font = [UIFont systemFontOfSize:13];
        [self addSubview:imgView];
        [imgView addSubview:imgView_BkgCollection];
        [imgView_BkgCollection addSubview:lbl_count];
        [imgView addSubview:imgView_Bottom];
        [imgView_BkgCollection addSubview:imgView_Collection];
        [imgView_Bottom addSubview:lbl_Content];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    float cellW = self.bounds.size.width;
    imgView.frame = CGRectMake(10,0, cellW - 20,(cellW -20)*(200 - 10)/356);
    lbl_count.frame = CGRectMake(0, 0, 100, 20);
    [lbl_count sizeToFit];
    float dd = lbl_count.frame.size.width;
    lbl_count.frame = CGRectMake((imgView_BkgCollection.width - 13 - 2 - dd)/2 + 13 + 2, (imgView_BkgCollection.height - 20)/2, dd, 20);
    imgView_BkgCollection.frame = CGRectMake(imgView.width - 45, 5, 40, 20);
    imgView_Collection.frame = CGRectMake((imgView_BkgCollection.width - 13 - dd - 2)/2, (imgView_BkgCollection.height - 12)/2 +1, 13, 12);
    imgView_Bottom.frame = CGRectMake(0, imgView.height - 80, imgView.width, 80);
    lbl_Content.frame = CGRectMake(10, 55, imgView.width - 10, 20);
}
-(void)setModel:(MGData_KeyFashions *)theModel
{
    [imgView setImageWithURL:[NSURL URLWithString:theModel.imageUrl] placeholderImage:[UIImage imageNamed:@"bg_img_default"]];
    lbl_Content.text = theModel.name;
    lbl_count.text = theModel.collects;
    
    [self layoutSubviews];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
