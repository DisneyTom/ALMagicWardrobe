//
//  ALFashionSquareHeadView.h
//  ALMagicWardrobe
//
//  Created by OCN on 15-4-2.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALComView.h"
#import "FFScrollView.h"
@protocol MagicButtonDelegate<NSObject>
@optional
- (void)doclickMagicButtonAction;
@end

typedef enum {
    FSCtrlAction_type,
    FSCtrlTest_type
}ClickEnum;


typedef void (^FSHeadViewBlock)(ClickEnum theType,NSInteger index);
#define FSHeadViewHeight (308+21+9+308+60)
@interface ALFashionSquareHeadView : ALComView
-(id)initWithFrame:(CGRect)frame andDelegate:(id <FFScrollViewDelegate>)theCtrl;
-(void)setTopScrollViews:(NSArray *)topDatas andActionImgs:(NSDictionary *)actionImgs;
-(void)hideTestBtn:(BOOL)hide; //隐藏测试按钮
@property(nonatomic,copy) FSHeadViewBlock theBlock;
@property (nonatomic, assign) id<MagicButtonDelegate>delegate;
@end
