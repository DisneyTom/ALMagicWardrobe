//
//  MBGuideView.h
//  SFAfNetWorking1.0
//
//  Created by bobo on 14-12-21.
//  Copyright (c) 2014年 祥敏 罗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"
#import <AVFoundation/AVFoundation.h>

typedef void (^GuideBlock)(id sender);
@protocol MBGuideViewDelegate <NSObject>

- (void)guideViewHide;

@end

@interface MBGuideView : UIView<UIScrollViewDelegate>
{
    UIScrollView  *_scrollView;
    SMPageControl *_pageControl;
    UIImageView   *_fourImageView;
    UIImageView   *_roadImageView;
    float         _carLong;
}
@property(nonatomic,strong) GuideBlock theBlock;
@property (nonatomic, strong) id<MBGuideViewDelegate>delegate;

@end
