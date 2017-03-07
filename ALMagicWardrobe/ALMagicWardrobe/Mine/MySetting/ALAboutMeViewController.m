//
//  OcnAboutMeViewController.m
//  OcnO2O
//
//  Created by anLun on 15-1-14.
//  Copyright (c) 2015年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import "ALAboutMeViewController.h"

@interface ALAboutMeViewController ()

@end

@implementation ALAboutMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"关于我们";
    [self initWithView];
    self.contentView.backgroundColor =  HEX(@"#F0EEEA");

}
-(void)initWithView{

    ALImageView *imageVIew = [[ALImageView alloc]
                              initWithFrame:CGRectMake(120, 20, 71, 119)];
    imageVIew.image = [ALImage imageNamed:@"icon_about"];
    [self.contentView addSubview:imageVIew];
    
    NSString *str=@"2015 年，魔法衣橱诞生于中国，是共享经济大潮下“快时尚智能服装月租”服务的创新者。魔法衣橱希望利用移动互联网的力量，让每一个年轻人不再受困于经济有限和视界有限，让变美这件大事能够更高效、更环保。\n\n我们为所有爱美的都市年轻女性服务，为她们提供最时尚、不限量、超便利的日常服装租用，让她们勿需疲于追赶潮流、频繁购买爆款，帮她们走出“衣橱爆满但总是少了一件”的魔咒，从此不再囿于有限买衣，真正可以无限穿衣。\n\n更重要的是——“共享美好”，这是全新的时尚环保消费创意，魔法衣橱正在用科技实现它。";
    ALLabel *aLlabel  = [[ALLabel alloc]
                         initWithFrame:CGRectMake(13, imageVIew.bottom+15, kScreenWidth-20, 340)
                         andColor:colorByStr(@"#5F5D59")
                         andFontNum:14];
    [self.contentView addSubview:aLlabel];
    [aLlabel setVerticalAlignment:VerticalAlignmentTop];
    aLlabel.numberOfLines = 0;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    
    aLlabel.attributedText = attributedString;
//    CGSize size=[ALComAction getSizeByStr:attributedString andFont:[UIFont systemFontOfSize:12] andRect:CGSizeMake(kScreenWidth-20, 0)];
    //调节高度
//    CGSize size = CGSizeMake(width, 500000);
//    
//    CGSize labelSize = [contentLabel sizeThatFits:size];
    
}

@end
