//
//  ALComAction.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-12.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALComView.h"
#import "OnboardingViewController.h"
/**
 *  公共处理
 */
@interface ALComAction : NSObject

AL_AS_SINGLETON(ALComAction);

+ (void)createAlert:(NSString*)title
           alertMsg:(NSString*)message
      alertBtnNames:(NSArray*)namesArr
             result:(void(^)(NSInteger btnIndex))result;

-(void)fuwenbenLabel:(UILabel *)labell
          FontNumber:(id)font
      AndLineSpacing:(float)lineSpacing;

/**
 *  两种方法删除NSUserDefaults所有记录
 */
-(void)delAllUserDefaults;

/**
 *  删除本地文件
 *
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL) DeleteSingleFile:(NSString *)filePath;

-(UIViewController *)getCurrentRootViewController;

/**
 *  加载引导页
 */
-(void)loadBoarding:(UIViewController *)theParenstCtrl;

/**
 *  通过font str 获得CGSize
 *
 *  @param str     str
 *  @param theFont font
 *
 *  @return 返回CGSize
 */
+(CGSize)getSizeByStr:(NSString *)str
              andFont:(UIFont *)theFont;
+(CGSize)getSizeByStr:(NSString *)str
              andFont:(UIFont *)theFont
              andRect:(CGSize)rect;
+(CGSize)getSizeByStr2:(NSMutableAttributedString *)str
              andFont:(UIFont *)theFont
              andRect:(CGSize)rect;
+ (CGSize)adjustSizeWithAttributedString:(NSAttributedString *)attributedString maxWidth:(CGFloat)width
                              numberLine:(NSInteger)numberLine;
/**
 *  字符串转颜色
 *
 *  @param stringToConvert <#stringToConvert description#>
 *
 *  @return <#return value description#>
 */
- (UIColor *) colorWithHexString: (NSString *) stringToConvert;

/**
 *  过滤字符串
 *
 *  @param str 要过滤的字符串
 *
 *  @return 返回已经过滤的值
 */
+(NSString *)filterStr:(NSString *)str;

/**
 *  显示通信失败的提示
 *
 *  @param errorMsg 提示内容
 */
-(void)showLoadRequestError:(NSString *)errorMsg;

/**
 *  显示警告的提示
 *
 *  @param warnMsg 提示内容
 */
-(void)showLoadWarn:(NSString *)warnMsg;


/**
 *  通讯等待
 *
 *  @param show YES 为等待  NO 为消失
 */
-(void)requestShowOrHide:(BOOL)show;

/**
 *  通过颜色名字，得到UIColor
 *
 *  @param name 红色，蓝色。。。。。。
 *
 *  @return UIColor
 */
+(UIColor *)getColorByName:(NSString *)name;
/**
 *  延时操作
 *
 *  @param finish block块
 *  @param val    延时时间
 */
-(void)afterAction:(void(^)())finish afterVal:(float)val;
/**
 *  显示失败信息
 *
 *  @param failSender <#failSender description#>
 */
-(void)showFail:(id)failSender;
@end
