//
//  LoadingView.m
//  HanChuangScience
//
//  Created by yy on 13-11-27.
//  Copyright (c) 2013年 张 如毅. All rights reserved.
//

#import "LoadingView.h"
#import "AppDelegate.h"

static LoadingView *_loadingView = nil;

@implementation LoadingView

+ (LoadingView *) standarLoadingView {
	if (!_loadingView) {
		_loadingView = [[LoadingView alloc] init];
	}
	return _loadingView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 150, 90)];
        [self setCenter:CGPointMake(kScreenWidth/2.0f, kScreenHeight/2.0f)];
        [self setBackgroundColor:[UIColor blackColor]];
        [self.layer setCornerRadius:8.0];
        [self setAlpha:0.7];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activityView setFrame:CGRectMake(55, 10, 40, 40)];
        [activityView startAnimating];
        [self addSubview:activityView];
        
        UILabel *label = [[UILabel alloc]
                          initWithFrame:CGRectMake(0, 55, 150, 20)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:RGB_BG_Clear];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"加载中..."];
        [self addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap {
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:0.0];
    }completion:^(BOOL finished){
        [self removeFromSuperview];
        [self setAlpha:0.6];
    }];
}

- (void)loadingSuccess:(NSString *)message {
    if (message) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

- (void)loadingFail:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:nil
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:nil, nil];
    [alert show];
    [self removeFromSuperview];
}

- (void)show{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [(AppDelegate *)[[UIApplication sharedApplication] delegate] window];
        for (UIView *v in window.subviews) {
            if ([v isKindOfClass:[LoadingView class]]) {
                [v removeFromSuperview];
            }
        }
        [window addSubview:self];
    });
}

- (void)hide{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}


@end
