//
//  ALMagicBagRuleViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-4-25.
//  Copyright (c) 2015年 anLun. All rights reserved.
//
//#import "AFNconnectionImport.h"
#import "ALMagicBagRuleViewController.h"

@interface ALMagicBagRuleViewController ()

@end

@implementation ALMagicBagRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"魔法包"];
    
    [self _initData];
  //  [AFNconnectionImport netWorkingCon];
    [self _initView];
    
    [self initWithView];
    
    self.contentView.backgroundColor =  HEX(@"#efebe8");
}

- (void)initWithView {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MGBag" ofType:@"html"];
    NSStringEncoding coding = NSUTF8StringEncoding;
    NSString *infoString = [NSString stringWithContentsOfFile:path usedEncoding:&coding error:nil];
    
    UIWebView *webView= [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentViewHeight+69)];
    [webView loadHTMLString:infoString baseURL:nil];
   // [AFNconnectionImport netWorkingCon];
    webView.backgroundColor =  [UIColor clearColor];//HEX(@"#efebe8");
    webView.opaque = NO;
    [self.contentView addSubview:webView];
}

-(void)_initData{

}
-(void)_initView{

}

@end
