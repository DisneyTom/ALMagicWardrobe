//
//  ALRuleExplainViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-14.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALRuleExplainViewController.h"

@interface ALRuleExplainViewController ()

@end

@implementation ALRuleExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"魔法值规则"];
    
    [self _initData];
    
    [self _initView];
    
}

-(void)_initData{
    
}
-(void)_initView{
    UIImageView *imgView=[[UIImageView alloc]
                          initWithFrame:CGRectMake(0, 0, kScreenWidth, 2049)];
    [imgView setImage:[ALImage imageNamed:@"mana_rules"]];
    self.contentView.backgroundColor = AL_RGB(240, 236, 233);
    [self.contentView addSubview:imgView];
}

@end
