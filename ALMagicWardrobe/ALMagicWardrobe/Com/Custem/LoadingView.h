//
//  LoadingView.h
//  HanChuangScience
//
//  Created by yy on 13-11-27.
//  Copyright (c) 2013年 张 如毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

+ (LoadingView *) standarLoadingView;
- (void)show;
- (void)hide;
- (void)loadingSuccess:(NSString *)message;
- (void)loadingFail:(NSString *)message;

@end
