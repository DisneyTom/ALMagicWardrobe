//
//  ALProductActionViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-18.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALProductActionViewController.h"
#import "ALScrollView.h"

#import "ALOneProductView.h"
#import "ALTwoProductView.h"
#import "ALThreeProductView.h"

#import "ALFourProductView.h"
#import "ALFiveProductView.h"
#import "ALSixProductView.h"
#import "ALSevenProductView.h"
#import "ALEightProductView.h"

@interface ALProductActionViewController ()

@end

@implementation ALProductActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"着装测试"];

    NSUInteger viewWidth = kScreenWidth;
    NSUInteger viewHeight = kScreenHeight;//self.contentView.height;

    
    ALScrollView *contentView=[[ALScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    contentView.pagingEnabled = YES;
//    [contentView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight)];
    [contentView contentSizeToFit];
    
    [self.contentView addSubview:contentView];
    
    
    
    //第一题
    ALOneProductView *oneView=[[ALOneProductView alloc] initWithFrame:CGRectMake(0, 0,viewWidth, viewHeight)];
    [contentView addSubview:oneView];
    
    //第二题
    ALTwoProductView *twoView=[[ALTwoProductView alloc] initWithFrame:CGRectMake(viewWidth*1,0, viewWidth, viewHeight)];
    [contentView addSubview:twoView];

    
    //第三题
    ALThreeProductView *threeView=[[ALThreeProductView alloc] initWithFrame:CGRectMake(viewWidth*2,0, viewWidth, viewHeight)];
    [contentView addSubview:threeView];
    
    //第四题
    ALFourProductView *productView4=[[ALFourProductView alloc] initWithFrame:CGRectMake(viewWidth*3,0, viewWidth, viewHeight)];
    [contentView addSubview:productView4];
    //第五题
    ALFiveProductView *productView5=[[ALFiveProductView alloc] initWithFrame:CGRectMake(viewWidth*4,0, viewWidth, viewHeight)];
    [contentView addSubview:productView5];
    //第六题
    ALSixProductView *productView6=[[ALSixProductView alloc] initWithFrame:CGRectMake(viewWidth*5,0, viewWidth, viewHeight)];
    [contentView addSubview:productView6];
    //第七题
    ALSevenProductView *productView7=[[ALSevenProductView alloc] initWithFrame:CGRectMake(viewWidth*6,0, viewWidth, viewHeight)];
    [contentView addSubview:productView7];
    //第八题
    ALEightProductView *productView8=[[ALEightProductView alloc] initWithFrame:CGRectMake(viewWidth*7,0, viewWidth, viewHeight)];
    [contentView addSubview:productView8];
    
}

@end
