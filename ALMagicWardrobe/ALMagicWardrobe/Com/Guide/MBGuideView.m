//
//  MBGuideView.m
//  SFAfNetWorking1.0
//
//  Created by bobo on 14-12-21.
//  Copyright (c) 2014年 祥敏 罗. All rights reserved.
//

#import "MBGuideView.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
//#import "AFNconnectionImport.h"
@implementation MBGuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
   
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    //[AFNconnectionImport connectionWifi];
    
    NSArray *images1 = @[@"I_Income_",@"I_See_",@"I_Not_",@"guide_view4",];
      images1 = @[@"guide_view4",];
     _scrollView.contentSize = CGSizeMake(kScreenWidth*images1.count, kScreenHeight);
//    NSArray *images2 = @[@"guide_view11",@"guide_view22",@"guide_view33",@"guide_view44",];
    
    for (NSInteger i=0; i<images1.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.backgroundColor = [UIColor clearColor];
//        if (kScreenHeight>480) {
//            imageView.image = [UIImage imageNamed:images2[i]];
//        }else{
            imageView.image = [UIImage imageNamed:images1[i]];
//        }
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
        if (i==images1.count -1 ) _fourImageView = imageView;
    }
    _fourImageView.userInteractionEnabled = YES;
    
    _pageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight-30, kScreenWidth, 20)];
    _pageControl.numberOfPages = images1.count;
//    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0/255.0f green:205/255.0f blue:102/255.0f alpha:.2];
//    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.tag = 101;
    _pageControl.pageIndicatorImage=[ALImage imageNamed:@"1212"];
    _pageControl.currentPageIndicatorImage=[ALImage imageNamed:@"1213"];
    if (images1.count > 1)
    {
        [self addSubview:_pageControl];
    }
  //
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(0, kScreenHeight-100, kScreenWidth, 100);
    startBtn.backgroundColor = [UIColor clearColor];
    [startBtn addTarget:self action:@selector(startBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //[AFNconnectionImport netWorkingCon];
    [_fourImageView addSubview:startBtn];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = floor((scrollView.contentOffset.x - kScreenWidth / 2) / kScreenWidth) + 1;
    _pageControl.currentPage = page;
}

- (void)startBtnAction
{
    if (self.theBlock) {
        self.theBlock(self);
      //  [AFNconnectionImport connectionWifi];
    }
//    if ([self.delegate respondsToSelector:@selector(guideViewHide)]) {
//        [self.delegate guideViewHide];
//    }
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
