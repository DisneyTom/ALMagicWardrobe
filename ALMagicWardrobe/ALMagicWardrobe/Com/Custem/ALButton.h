//
//  ALButton.h
//  OcnO2O
//
//  Created by OCN on 14-12-26.
//  Copyright (c) 2014年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^OcnButtonClick_block)(id sender);
@interface ALButton : UIButton
@property (nonatomic,copy) OcnButtonClick_block theBtnClickBlock;
-(void)setFrame:(CGRect)frame
         andTit:(NSString *)tit
   andGoImgView:(NSString *)imgName;
/**
 *  当图片和文字上下居中时调用，并且，设置值后，才调用
 */
-(void)setAlignment;

@property (nonatomic, assign) NSUInteger index;
- (void)setFirstAlignment;
@end
