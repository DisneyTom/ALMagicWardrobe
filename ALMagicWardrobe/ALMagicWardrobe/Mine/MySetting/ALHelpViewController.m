//
//  ALHelpViewController.m
//  ALMagicWardrobe
//
//  Created by wang on 4/7/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import "ALHelpViewController.h"

@interface ALHelpViewController ()

@end

@implementation ALHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"帮助中心";
    [self initWithView];
//    self.contentView.backgroundColor =  HEX(@"#efebe8");
}

- (void)initWithView {
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"服务指南" ofType:@"html"];
//    NSStringEncoding coding = NSUTF8StringEncoding;
//    NSString *infoString = [NSString stringWithContentsOfFile:path usedEncoding:&coding error:nil];
//    
//    UIWebView *webView= [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentViewHeight+69)];
//    [webView loadHTMLString:infoString baseURL:nil];
//    [self.contentView addSubview:webView];
    UIImageView *imgView=[[UIImageView alloc]
                          initWithFrame:CGRectMake(0, 0, kScreenWidth, 3326/2)];
    [imgView setImage:[ALImage imageNamed:@"Magic_What_"]];
    [self.contentView addSubview:imgView];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
