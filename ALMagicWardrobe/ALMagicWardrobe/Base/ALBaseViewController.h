//
//  ALBaseViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALComView.h"
#import "ALCom.h"
#import "DBManage.h"
#import "DataRequest.h"
#import "ALLoginUserManager.h"

typedef enum {
    navigationView_type,
    backBtn_type,
    rightBtn1_type,
    rightBtn2_type
}OcnBaseCtrlViewEnum;

@interface ALBaseViewController : UIViewController
{
    ALButton *_backBtn;
}
/**
 *  页面显示的根View,所有的内容显示在此contentView上，以便后续统一管理
 */
@property(nonatomic,strong) ALScrollView *contentView;
@property(nonatomic,strong) ALComView*   navigationView;
@property(nonatomic,strong) UIView*   view_Top;
/**
 *  获取基类中的元素，进行操作
 *
 *  @param type     元素类型
 *  @param theView  元素
 *  @param theEvent 回调事件
 */
-(void)setViewWithType:(OcnBaseCtrlViewEnum)type
               andView:(void(^)(id view))theView
          andBackEvent:(void(^)(id sender))theEvent;

-(void)setLeftBtnHidOrNot:(BOOL)statue;
-(void)toLoginAndBlock:(void(^)())theBlock andObj:(ALBaseViewController *)theCtrl;
/**
 *  延迟操作
 *
 *  @param finish 延迟操作block
 *  @param val    延迟时间
 *  注：功用之一：ios的动画推送bug
 */
-(void)afterAction:(void(^)())finish afterVal:(float)val;
/**
 *  分享
 */
-(void)showShare;
/**
 *  动态弹簧
 */
+(void)animationMainView:(UIView *)mainView
              andPopView:(UIView *)popView;

/**
 *  分享
 */
-(void)showShare:(BOOL)show andClick:(void(^)(NSInteger index))theClick;

#pragma mark 分享到微信
- (void) sendTextContent:(NSString *)content andType:(enum WXScene)scene andUrlstr:(NSString *)urlStr;
#pragma mark 分享到新浪微博
- (void) sendWBTextContent:(NSString *)content andUrlstr:(NSString *)urlStr;
#pragma mark 分享到QQ空间
- (void)shareToQzone:(NSString *)content andUrlstr:(NSString *)urlStr;
#pragma mark 分享到QQ朋友圈
-(void)shareToFriend:(NSString *)content andUrlstr:(NSString *)urlStr;

#pragma mark 微信登陆
-(void)wxLoginAndBlock:(void(^)(id sender))theBlock;
#pragma mark QQ登陆
-(void)qqLoginAndBlock:(void(^)(id sender))theBlock;
#pragma mark 新浪微博登陆
-(void)wbLoginAndBlock:(void(^)(id sender))theBlock;
@end
