//
//  ALLabel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    VerticalAlignmentMiddle = 0, // default
    VerticalAlignmentTop,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface ALLabel : UILabel {
@private VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;
- (id)initWithFrame:(CGRect)frame
           andColor:(UIColor *)color
         andFontNum:(CGFloat)num;

- (id)initWithFrame:(CGRect)frame
               Font:(CGFloat)font
            BGColor:(UIColor *)color
          FontColor:(UIColor *)fontColor;

- (id)initWithFrame:(CGRect)frame
           BoldFont:(CGFloat)font
            BGColor:(UIColor*)color
          FontColor:(UIColor *)fontColor;

- (void)setIsRight:(BOOL)isRight Right:(NSInteger)right;

- (void)setIsShowDeleteLine:(BOOL)isShowDeleteLine
                  LineFrame:(CGRect)lineFrame
                  LineColor:(UIColor *)lineColor;

//给某些字段添加另外的字体和颜色
-(void)setKeyWordTextString:(NSString *)keyWordArray WithFont:(UIFont *)font AndColor:(UIColor *)keyWordColor;

@end
