//
//  OcnAccessoryView.m
//  tour Manager
//
//  Created by admin on 14-5-21.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "ALAccessoryView.h"
//#import "const.h"

@interface ALAccessoryView ()
{
    UILabel *_titleLabel;
}
@property (nonatomic, unsafe_unretained) id<ALAccessoryViewDelegate> accessoryDelegate;
@end

@implementation ALAccessoryView

- (id)initWithDelegate:(id<ALAccessoryViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.accessoryDelegate = delegate;
        self.frame = CGRectMake(0, 0, kScreenWidth, kToolBarHeight);
        
        UIBarButtonItem   *SpaceButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                                     target:nil
                                                                                     action:nil];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:self
                                                                        action:@selector(inputCancel)];
        cancelButton.tintColor=AL_RGB(149,105,62);
        
//#warning 这里还需要更改
        _titleLabel = [[UILabel alloc]
                       initWithFrame:(CGRect){
                           44,
                           0,
                           isIOS6?kScreenWidth-44*2:kScreenWidth-44*2-15,
                           kToolBarHeight}];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]
                                          initWithCustomView:_titleLabel];
        
        UIBarButtonItem   *rightSpaceButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                                     target:nil
                                                                                     action:nil];

        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确认"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(inputDone)];
        doneButton.tintColor=AL_RGB(149,105,62);
        
        self.items = @[SpaceButton,cancelButton,flexibleSpace,doneButton,rightSpaceButton];
        self.barStyle = UIBarStyleDefault;
        self.translucent = YES;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [_titleLabel setText:title];
    
}

- (void)inputCancel{
    if (_accessoryDelegate && [_accessoryDelegate
                               respondsToSelector:@selector(accessoryViewDidPressedCancelButton:)]) {
        [_accessoryDelegate accessoryViewDidPressedCancelButton:self];
    }
}

- (void)inputDone{
    if (_accessoryDelegate && [_accessoryDelegate
                               respondsToSelector:@selector(accessoryViewDidPressedDoneButton:)]) {
        [_accessoryDelegate accessoryViewDidPressedDoneButton:self];
    }
}


@end

