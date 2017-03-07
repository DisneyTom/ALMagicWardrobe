//
//  ALAgreementViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-4-25.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALAgreementViewController.h"

@interface ALAgreementViewController ()

@end

@implementation ALAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"用户协议"];
    
    [self _initData];
    
    [self _initView];
    
    [self initWithView];
    
    self.contentView.backgroundColor =  HEX(@"#efebe8");
}

- (void)initWithView {
    
    /*
    NSString *path = [[NSBundle mainBundle] pathForResource:@"用户协议" ofType:@"html"];
    NSStringEncoding coding = NSUTF8StringEncoding;
    NSString *infoString = [NSString stringWithContentsOfFile:path usedEncoding:&coding error:nil];
    
    UIWebView *webView= [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentViewHeight+69)];
    [webView loadHTMLString:infoString baseURL:nil];
    [self.contentView addSubview:webView];
     */
    UIImageView *imageView=[[UIImageView alloc]
                            initWithFrame:CGRectMake(0, 0, kScreenWidth, 4281/2)];
    [imageView setImage:[ALImage imageNamed:@"User_Agreement_"]];
    [self.contentView addSubview:imageView];
}


-(void)_initData{

}

-(void)_initView{

}
@end
