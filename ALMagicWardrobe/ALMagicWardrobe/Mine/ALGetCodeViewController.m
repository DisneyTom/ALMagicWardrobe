//
//  ALGetCodeViewController.m
//  ALMagicWardrobe
//
//  Created by wang on 4/12/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import "ALGetCodeViewController.h"
#import "UICopyLabel.h"

@interface ALGetCodeViewController ()
{
    NSDictionary *_showDataInfo;
}
@end

@implementation ALGetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"邀请码";
    [self _initView];
    
}


-(void)_initView{
    ALComView *View = [[ALComView alloc]
                       initWithFrame:CGRectMake(0, 0, kScreenWidth, 325/2)];
    View.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:View];
    ALImageView *imageView = [[ALImageView alloc]
                              initWithFrame:CGRectMake((kScreenWidth-99)/2, 35/2, 99, 99)];
    imageView.image = [UIImage imageNamed:@"invitation_code_photo.png"];
    [View addSubview:imageView];
    
    NSArray *codeArray = [MBNonEmptyString(_codeMessage) componentsSeparatedByString:@","];
    __block float orginy=0;
    
    NSArray *contentArr=@[[NSString stringWithFormat:@"你收到了%lu个邀请码",(unsigned long)codeArray.count-1],
                          @"快邀请你的好友成为会员吧!",
                          ];
    
    [contentArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALLabel *lbl=[[ALLabel alloc]
                      initWithFrame:CGRectMake(0,
                                               imageView.bottom+20*idx,
                                               kScreenWidth,
                                               20)];
        [lbl setText:contentArr[idx]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        lbl.font=[UIFont boldSystemFontOfSize:13];
        [lbl setTextColor:colorByStr(@"#8f7644")];
        [View addSubview:lbl];
        orginy=lbl.bottom;
    }];
    
    ALImageView *imageViewSpect = [[ALImageView alloc]
                                   initWithFrame:CGRectMake(5, 230, kScreenWidth-10, 1)];
    imageViewSpect.image = [UIImage imageNamed:@"imaginary_line.png"];
    [View addSubview:imageViewSpect];
    
    for (int i=0; i<codeArray.count-1; i++) {
        ALImageView *iamgeVew= [[ALImageView alloc]
                                initWithFrame:CGRectMake((kScreenWidth-527/2)/2, View.bottom+32/2+(32/2+77)*i, 527/2, 138/2)];
        iamgeVew.image = [UIImage imageNamed:@"bg_invitation_code"];
        [self.contentView addSubview:iamgeVew];
        
        UICopyLabel *lbl=[[UICopyLabel alloc]
                      initWithFrame:CGRectMake(0,
                                               10,
                                               296,
                                               47)];
        [lbl setText:codeArray[i]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        lbl.font=[UIFont boldSystemFontOfSize:22];
        [lbl setTextColor:colorByStr(@"#9A6B46")];
        [iamgeVew addSubview:lbl];
        iamgeVew.userInteractionEnabled = YES;
    }
}

@end
