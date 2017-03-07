//
//  ALComAction.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-12.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALComAction.h"
#import "OnboardingContentViewController.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ALStringAdditions.h"
#import "AFHTTPRequestOperation.h"

#import "ALProgressHUD.h"
#import <CoreText/CoreText.h>

#define kNetConnectionException     @"kNetConnectionException"

@implementation ALComAction
AL_DEF_SINGLETON(ALComAction);
+ (void)createAlert:(NSString*)title
           alertMsg:(NSString*)message
      alertBtnNames:(NSArray*)namesArr
             result:(void(^)(NSInteger btnIndex))result
{
    if(isIOS8)
    {
        if([title isEqualToString:@""]){
            title = nil;
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        for (NSInteger i = 0; i<[namesArr count]; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:[namesArr objectAtIndex:i]
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                result(i);
            }]];
        }
        [[UIApplication sharedApplication].keyWindow.rootViewController
         presentViewController:alert
         animated:YES
         completion:^{}];
    }
    else
    {
        ALBlockUIAlertView *blockAlert = [[ALBlockUIAlertView alloc]
                                          initWithTitle:title
                                          message:message
                                          buttonTitles:namesArr
                                          clickButton:^(NSInteger i) {
            result(i);
        }];
        [blockAlert show];
    }
}

-(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndLineSpacing:(float)lineSpacing
{
    //富文本设置文字行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle};
    labell.attributedText = [[NSAttributedString alloc]
                             initWithString:labell.text
                             attributes:attributes];
}
-(void)delAllUserDefaults{
    //方法一
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    //方法二
//    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
//    NSDictionary * dict = [defs dictionaryRepresentation];
//    for (id key in dict) {
//        [defs removeObjectForKey:key];
//    }
//    [defs synchronize];
}
/** Delete a file **/
+ (BOOL) DeleteSingleFile:(NSString *)filePath
{
    NSError *err = nil;
    if (nil == filePath) {
        return NO;
        }
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    if (![appFileManager fileExistsAtPath:filePath]) {
        return YES;
        }
    if (![appFileManager isDeletableFileAtPath:filePath]) {
        return NO;
        }
    return [appFileManager removeItemAtPath:filePath error:&err];
}

-(UIViewController *)getCurrentRootViewController {
    /*
     UIViewController *result;
     UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
     if (topWindow.windowLevel != UIWindowLevelNormal)
     {
     NSArray *windows = [[UIApplication sharedApplication] windows];
     for(topWindow in windows)
     {
     if (topWindow.windowLevel == UIWindowLevelNormal)
     break;
     }
     }
     UIView *rootView = [[topWindow subviews] objectAtIndex:0];
     id nextResponder = [rootView nextResponder];
     if ([nextResponder isKindOfClass:[UIViewController class]])
     result = nextResponder;
     else if ([topWindow respondsToSelector:@selector(rootViewController)] &&
     topWindow.rootViewController != nil)
     result = topWindow.rootViewController;
     
     else{
     result=nil;
     }
     return result;
     */
    UIViewController *result = nil;
    
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}
-(void)loadBoarding:(UIViewController *)theParenstCtrl{
    __block OnboardingViewController *theBoardControlCtrl=nil;
    
    OnboardingContentViewController *theOneContentCtrl=[[OnboardingContentViewController alloc] initWithTitle:@"这里是标题" body:@"这里是内容" image:[UIImage imageNamed:@"oneBoard"] buttonText:nil action:^{
        
    }];
    
    OnboardingContentViewController *theTwoContentCtrl=[[OnboardingContentViewController alloc] initWithTitle:@"这里是标题" body:@"这里是内容" image:[UIImage imageNamed:@"twoBoard"] buttonText:nil action:^{
        
    }];
    
    OnboardingContentViewController *theThreeContentCtrl=[[OnboardingContentViewController alloc] initWithTitle:@"这里是标题" body:@"这里是内容" image:[UIImage imageNamed:@"threeBoard"] buttonText:nil action:^{
        
    }];
    
    OnboardingContentViewController *theFourContentCtrl=[[OnboardingContentViewController alloc] initWithTitle:@"这里是标题" body:@"这里是内容" image:[UIImage imageNamed:@"fourBoard"] buttonText:@"点击进入" action:^{
        [theBoardControlCtrl dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    theBoardControlCtrl=[[OnboardingViewController alloc] initWithBackgroundImage:nil contents:@[theOneContentCtrl,theTwoContentCtrl,theThreeContentCtrl,theFourContentCtrl]];
    
    [theParenstCtrl presentViewController:theBoardControlCtrl animated:YES completion:^{
        
    }];
}
//通过字体 字符串 获得CGSize
+(CGSize)getSizeByStr:(NSString *)str
              andFont:(UIFont *)theFont{
    CGSize theSize;
    if (isIOS7) {
        NSDictionary *attribute = @{NSFontAttributeName: theFont};
        theSize=[str
                 boundingRectWithSize:CGSizeMake(300, 0)
                 options:NSStringDrawingTruncatesLastVisibleLine |
                 NSStringDrawingUsesLineFragmentOrigin |
                 NSStringDrawingUsesFontLeading
                 attributes:attribute
                 context:nil].size;
    }
    else{
        theSize=[str
                 sizeWithFont:theFont
                 constrainedToSize:CGSizeMake(300, 100)
                 lineBreakMode:NSLineBreakByCharWrapping];
    }
    return theSize;
}
+(CGSize)getSizeByStr:(NSString *)str
              andFont:(UIFont *)theFont
              andRect:(CGSize)rect{
    CGSize theSize;
    if (isIOS7||isIOS8) {
        NSDictionary *attribute = @{NSFontAttributeName: theFont};
        theSize=[str
                 boundingRectWithSize:rect
                 options:NSStringDrawingTruncatesLastVisibleLine |
                 NSStringDrawingUsesLineFragmentOrigin |
                 NSStringDrawingUsesFontLeading
                 attributes:attribute
                 context:nil].size;
    }
    else{
        theSize=[str
                 sizeWithFont:theFont
                 constrainedToSize:rect
                 lineBreakMode:NSLineBreakByCharWrapping];
    }
    return theSize;
}
+(CGSize)getSizeByStr2:(NSMutableAttributedString *)str
               andFont:(UIFont *)theFont
               andRect:(CGSize)rect{
    CGSize theSize;
    if (isIOS7) {
        theSize=[str
                 boundingRectWithSize:rect
                 options:NSStringDrawingTruncatesLastVisibleLine |
                 NSStringDrawingUsesLineFragmentOrigin |
                 NSStringDrawingUsesFontLeading
                 context:nil].size;
    }
    return theSize;
}
+ (CGSize)adjustSizeWithAttributedString:(NSAttributedString *)attributedString maxWidth:(CGFloat)width
                              numberLine:(NSInteger)numberLine
{
    if (!attributedString.length) {
        return CGSizeZero;
    }
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef)attributedString);
    
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    
    
    CFRange range = CFRangeMake(0, 0);
    if (numberLine > 0 && framesetter)
    {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0, 0, maxSize.width, maxSize.height));
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
        CFArrayRef lines = CTFrameGetLines(frame);
        if (nil != lines && CFArrayGetCount(lines) > 0)
        {
            NSInteger lastVisibleLineIndex = MIN(numberLine, CFArrayGetCount(lines)) - 1;
            CTLineRef lastVisibleLine = CFArrayGetValueAtIndex(lines, lastVisibleLineIndex);
            CFRange rangeToLayout = CTLineGetStringRange(lastVisibleLine);
            range = CFRangeMake(0, rangeToLayout.location + rangeToLayout.length);
        }
        CFRelease(frame);
        CFRelease(path);
    }
    
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, NULL, maxSize, NULL);
    
    CFRelease(framesetter);
    return CGSizeMake(floor(size.width) + 1, floor(size.height) + 1);
    
    
}
- (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(NSString *)filterStr:(NSString *)str{
    //TODO: 这里需要做些字符串过滤的处理
    if ([str isKindOfClass:[NSNumber class]]) {
        str=[NSString stringWithFormat:@"%@",str];
    }
    if (str==nil) {
        return @"";
    }
    if([str isEqual:[NSNull null]])
    {
        return @"";
    }
    //去掉空格
    return [str stringFilSpace];
}

-(void)showLoadRequestError:(NSString *)errorMsg{
    ALAlertView *alert = [[ALAlertView alloc] initWithTitle:@"加载出错"
                                                      message:errorMsg
                                                     delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
    [alert show];
}
-(void)showLoadWarn:(NSString *)warnMsg{
    
    [ALProgressHUD showHUDViewTo:[UIApplication sharedApplication].keyWindow
                            image:nil
                             text:warnMsg
                     timeInterval:1.0f];
}

-(void)requestShowOrHide:(BOOL)show{
    LoadingView *loadIngView=[LoadingView standarLoadingView];
    if (show) {
        [loadIngView show];
    }
    else{
        [loadIngView hide];
    }
    /*
     if (!_requestAlertView) {
     _requestAlertView=[[UIAlertView alloc]
     initWithTitle:@""
     message:@"正在通讯..."
     delegate:nil
     cancelButtonTitle:nil
     otherButtonTitles:nil, nil];
     }
     if (show) {
     [_requestAlertView show];
     }
     else{
     [_requestAlertView dismissWithClickedButtonIndex:0 animated:NO];
     _requestAlertView=nil;
     }
     */
}
+(UIColor *)getColorByName:(NSString *)name{
    if ([name isEqualToString:@"红色"]) {
        return [UIColor redColor];
    }else if ([name isEqualToString:@"绿色"]){
        return [UIColor greenColor];
    }else if ([name isEqualToString:@"蓝色"]){
        return [UIColor blueColor];
    }else if ([name isEqualToString:@"黄色"]){
        return [UIColor yellowColor];
    }else if ([name isEqualToString:@"紫色"]){
        return [UIColor purpleColor];
    }
    return nil;
}
-(void)afterAction:(void(^)())finish afterVal:(float)val{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, val*NSEC_PER_SEC);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
        if (finish) {
            finish();
        }
    });
}
-(void)showFail:(id)failSender{
    if ([failSender isKindOfClass:[NSDictionary class]]) {
        [self showLoadWarn:failSender[@"body"][@"message"]];
    }
    else if ([failSender isKindOfClass:[AFHTTPRequestOperation class]])
    {
        [self showLoadWarn:@"网络连接异常,请检查网络!"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetConnectionException object:nil];
    }
}


@end
