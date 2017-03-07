//
//  MGUI_MainCell.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/17.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUI_MainCell.h"

@implementation MGUI_MainCell
{
    UIImageView*    imgView;
    UILabel*        lbl_count;
    UIImageView*    imgView_Bottom;
    UILabel*        lbl_Content;
    UILabel*        lbl_Size;
    UIView*         view_Line;
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
        view_Line = [[UIView alloc]init];
        view_Line.backgroundColor = ALUIColorFromHex(0xdedede);
        lbl_Time = [[UILabel alloc]init];
        lbl_Time.backgroundColor = AL_RGB(240,236,233);
        lbl_Time.font = [UIFont systemFontOfSize:10];
        
        lbl_Time.textAlignment = NSTextAlignmentCenter;
        lbl_Time.textColor = [UIColor grayColor];
     

        [self addSubview:view_Line];
        [self addSubview:lbl_Time];
        [self addSubview:imgView];
        [imgView addSubview:imgView_Bottom];
        [imgView_Bottom addSubview:lbl_Content];
        [imgView_Bottom addSubview:lbl_Size];
        [imgView_Bottom addSubview:lbl_count];
    }
    return self;
}
-(void)setTime
{
    view_Line.hidden = false;
    lbl_Time.hidden = false;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    view_Line.frame = CGRectMake(0, 14.5, kScreenWidth, 1);
    lbl_Time.frame = CGRectMake((kScreenWidth - 80)/2,5, 80, 20);
    
    imgView.frame = CGRectMake(10, lbl_Time.hidden?5:31, kScreenWidth - 20, (kScreenWidth - 20)*1354/1200);
    lbl_count.frame = CGRectMake(10, 26, imgView.width - 20, 20);
    imgView_Bottom.frame = CGRectMake(0, imgView.height - 54, imgView.width, 54);
    lbl_Size.frame = CGRectMake(imgView.width - 60  - 10, 5, 60, 20);
    lbl_Content.frame = CGRectMake(10, 8, imgView.width - 20 - 60, 20);
}
-(void)setModel:(MGData_KeyFashions *)theModel
{
    view_Line.hidden = true;
    lbl_Time.hidden = true;
    [imgView setImageWithURL:[NSURL URLWithString:theModel.imageUrl] placeholderImage:LoadIngImg];
    lbl_Content.text = theModel.name;
    lbl_count.text = theModel.collects;
    lbl_Size.text = [theModel.size stringByReplacingOccurrencesOfString:@"," withString:@"/"];
    
    NSString* string_C = [NSString stringWithFormat:@"已有%@人加入了衣橱",theModel.collects];
    NSMutableAttributedString *string_Collect=[[NSMutableAttributedString alloc] initWithString:string_C];
    
    [string_Collect addAttribute:NSForegroundColorAttributeName value:ALUIColorFromHex(0xa07845) range:NSMakeRange(2, theModel.collects.length)];
    
    lbl_count.attributedText = string_Collect;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: [theModel.saleTime doubleValue]/1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM月dd日"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    //int week=0;
    comps = [calendar components:unitFlags fromDate:date];
    int month = (int)[comps month];
    int day = (int)[comps day];
    
    lbl_Time.text = [NSString stringWithFormat:@"%d月%d日更新",month,day];
    //[formatter setDateStyle:NSDateFormatterMediumStyle];
    //This sets the label with the updated time.
    //    int hour = (int)[comps hour];
    //    int min = (int)[comps minute];
    //    int sec = (int)[comps second];
    [self layoutSubviews];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
