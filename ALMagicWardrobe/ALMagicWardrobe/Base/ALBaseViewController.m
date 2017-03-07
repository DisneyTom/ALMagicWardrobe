//
//  ALBaseViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
#import "MBAdditions.h"
#import "ALTabBarViewController.h"
#import "MBGlobalUICommon.h"
#import "ALLoginViewController.h"

#import "ALFashionSquareViewController.h"
#import "ALMagicWardrobeViewController.h"
#import "ALMagicBagViewController.h"
#import "ALMineViewController.h"
#import "AppDelegate.h"

#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "ALComAction.h"
#import "MobClick.h"

@interface ALBaseViewController ()
<UIGestureRecognizerDelegate>
@end

@implementation ALBaseViewController{
    
    ALLabel *_navigationTitle;
    
    ALButton *_rightBtn_1;
    ALButton *_rightBtn_2;
    BOOL   _isScrollUp;
}
-(void)setViewWithType:(OcnBaseCtrlViewEnum)type
               andView:(void(^)(id view))theView
          andBackEvent:(void(^)(id sender))theEvent{
    id obj=nil;
    switch (type) {
        case backBtn_type:
        {
            obj=_backBtn;
            if (theView) {
                theView(obj);
            }
            [obj setTheBtnClickBlock:^(id sender){
                if (theEvent) {
                    theEvent(sender);
                }
            }];
        }
            break;
        case rightBtn1_type:
        {
            obj=_rightBtn_1;
            if (theView) {
                theView(obj);
            }
            [obj setTheBtnClickBlock:^(id sender){
                if (theEvent) {
                    theEvent(sender);
                }
            }];
        }
            break;
        case rightBtn2_type:
        {
            obj=_rightBtn_2;
            if (theView) {
                theView(obj);
            }
            [obj setTheBtnClickBlock:^(id sender){
                if (theEvent) {
                    theEvent(sender);
                }
            }];
        }
            break;
        case navigationView_type:
        {
            obj=_navigationView;
            if (theView) {
                theView(obj);
            }
        }
            break;
        default:
            break;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    float current = _contentView.contentOffset.x;
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@" ,self.title]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollUp)
                                                 name:TSelectViewWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollBack)
                                                 name:TSelectViewWillHideNotification
                                               object:nil];
    if ([self.navigationController.viewControllers count]>1) {
        [_backBtn setHidden:NO];
        [self hideTabBar:YES];
        [_contentView setHeight:kScreenHeight-kNavigationBarHeight];
        //        [self makeTabBarHidden:YES];
    }
    else{
        [_backBtn setHidden:YES];
        [self hideTabBar:NO];
        if (current != 1280)
        {
            [_contentView setHeight:kScreenHeight-kTabBarHeight-kNavigationBarHeight];
        }
        
    
        //        [self makeTabBarHidden:NO];
    }
    
}


-(void)toLoginAndBlock:(void(^)())theBlock andObj:(ALBaseViewController *)theCtrl{
    ALLoginViewController *loginVC = [[ALLoginViewController alloc] init];
    [loginVC setTheBlock:theBlock];
    [loginVC setTheUpCtrl:theCtrl];
    [theCtrl.navigationController pushViewController:loginVC animated:YES];
}

-(void)setLeftBtnHidOrNot:(BOOL)statue
{
    [_backBtn setHidden:statue];
}
- (void)viewDidDisappear:(BOOL)animated{
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@" ,self.title]];
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TSelectViewWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TSelectViewWillHideNotification
                                                  object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([self isKindOfClass:[ALFashionSquareViewController class]]||
            [self isKindOfClass:[ALMagicWardrobeViewController class]]||
            [self isKindOfClass:[ALMagicBagViewController class]]||
            [self isKindOfClass:[ALMineViewController class]]) {
            self.hidesBottomBarWhenPushed = NO;
        }else{
            self.hidesBottomBarWhenPushed = YES;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication]
     setStatusBarStyle:UIStatusBarStyleLightContent];
    
    __block ALBaseViewController * theCtrl=self;
    
    if (isIOS7||isIOS8) {
        self.automaticallyAdjustsScrollViewInsets=NO;//取消ios7中views自动滚动
    }
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.view setBackgroundColor:AL_RGB(249, 249, 249)];
    
    float orginY=kNavigationBarHeight;
    float sizeH=kTabBarHeight;
    if ([self.navigationController.viewControllers count]>1) {
        sizeH=0;
    }
    else{
        sizeH=kTabBarHeight;
    }
    //    if (self.navigationController.navigationBarHidden) {
    //        orginY=0;
    //    }

    _contentView =[[ALScrollView alloc]
                   initWithFrame:CGRectMake(
                                            0,
                                            orginY,
                                            kScreenWidth,
                                            kScreenHeight-orginY-sizeH)];
    [_contentView setBackgroundColor:colorByStr(@"#F0ECE9")];
    [_contentView setUserInteractionEnabled:YES];
    [self.view addSubview:_contentView];
    
    //将navigationBar下面的黑色阴影去掉
    //1.方案一：
    //    [self.navigationController.navigationBar.layer setMasksToBounds:YES];
    //2.方案二：
    //    self.navigationController.navigationBar.clipsToBounds = YES;
    //3.方案三：
    //    CustomNavBar *navBar = (CustomNavBar *)self.navigationController.navigationBar;
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_gray.png"] forBarMetrics:UIBarMetricsDefault];
    //    navBar.shadowImage = [[UIImage alloc]init];
    if (isIOS7||isIOS8)
    {
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    if (self.navigationController.viewControllers.count>1) {
        UIViewController *ctrl=self.navigationController.viewControllers[0];
        if (![ctrl isKindOfClass:[self class]]) {
        }
    }
    _view_Top = [[UIView alloc]init];
    _view_Top.hidden = true;
    _view_Top.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, 35);
    _view_Top.backgroundColor = colorByStr(@"#F6F6F6");
    [self.view addSubview:_view_Top];
    
    _navigationView = [[ALComView alloc]
                       initWithFrame:CGRectMake(0,
                                                0,
                                                kScreenWidth,
                                                kNavigationBarHeight)];
    [_navigationView setCustemViewWithType:BottomLine_type
                           andTopLineColor:nil
                        andBottomLineColor:nil];
    
    [_navigationView setBackgroundColor:AL_RGB(0,0,0)];
    [_navigationView setUserInteractionEnabled:YES];
    

    
    [self.view addSubview:_navigationView];
    

    
//    NSArray* array_Btn =  [NSArray arrayWithObjects:@"上新",@"人气",@"为你精选",@"分类",@"玩转魔橱",nil];
//    NSMutableArray* array_B = [[NSMutableArray alloc]init];
//    [array_Btn enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
//     {
//         ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
//         CGFloat btnSpaceWidth = kScreenWidth  /5;
//         [array_B addObject:btn];
//         [btn setFrame:CGRectMake(idx *btnSpaceWidth ,0,btnSpaceWidth,35)];
//         [btn setTitle:array_Btn[idx] forState:UIControlStateNormal];
//         [btn setTitleColor:ALUIColorFromHex(0x92887c) forState:UIControlStateNormal];
//         [btn setTitleColor:ALUIColorFromHex(0xa07845) forState:UIControlStateSelected];
//         if (idx == 0)
//         {
//             btn.selected = true;
//         }
//         [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
//         btn.index = idx;
//         [btn setTag:idx+10000];
//         [btn setTheBtnClickBlock:^(id sender)
//          {
//              ALButton *theBtn=sender;
//              
////              if (theBtn.tag==0+10000)
////              {
////                  current = 0;
////                  
////              }
////              else if (theBtn.tag==1+10000)
////              {
////                  current = 1;
////                  
////              }
////              else if (theBtn.tag==2+10000)
////              {
////                  current = 2;
////                  
////              }
////              else if (theBtn.tag==3+10000)
////              {
////                  current = 3;
////                  
////              }
////              else
////              {
////                  current = 4;
////              }
//              [array_B enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                  ALButton* btn = obj;
//                  btn.selected = false;
//              }];
//              theBtn.selected = true;
//              [UIView animateWithDuration:0.3 animations:^{
////                  view_Line.frame = CGRectMake(kScreenWidth/5*current, 34, kScreenWidth/5, 1);
////                  [self.contentView setContentOffset:CGPointMake(320*current, 0) animated:true];
//              } completion:^(BOOL finished) {
//                  
//              }];
//              
//          }];
//         [_view_Top addSubview:btn];
//     }];

    
    _navigationTitle = [[ALLabel alloc]
                        initWithFrame:CGRectMake(60,
                                                 kStatusBarHeight,
                                                 200,
                                                 44)
                        BoldFont:18
                        BGColor:RGB_BG_Clear
                        FontColor:colorByStr(@"#9B7D56")];
    [_navigationTitle setTextAlignment:NSTextAlignmentCenter];
    [_navigationView addSubview:_navigationTitle];
    
    _backBtn = [ALButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setFrame:CGRectMake(0, kStatusBarHeight, 60, 44)];
    [_backBtn setImage:[ALImage imageNamed:@"icon023"] forState:UIControlStateNormal];
    [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [_backBtn setTheBtnClickBlock:^(id sender){
        [theCtrl.navigationController popViewControllerAnimated:YES];
    }];
    [_navigationView addSubview:_backBtn];
    
    _rightBtn_1 = [ALButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn_1 setFrame:CGRectMake(270, kStatusBarHeight, 50, 44)];
    [_navigationView addSubview:_rightBtn_1];
    
    _rightBtn_2 = [ALButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn_2 setFrame:CGRectMake(220, kStatusBarHeight, 50, 44)];
    [_rightBtn_2 setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [_navigationView addSubview:_rightBtn_2];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    ALTextField *theTextField=(ALTextField *)textField;
    if (theTextField.theTextFiledType==Nomal_type) {
        return YES;
    }
    else if(theTextField.theTextFiledType==MyDot_type){
        NSString *myDotNumbers=@"0123456789.\n";
        //输入字符限制
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (filtered.length == 0) {
            //支持删除键
            return [string isEqualToString:@""];
        }
        if (textField.text.length == 0) {
            return ![string isEqualToString:@"."];
        }
        //第一位为0，只能输入.
        else if (textField.text.length == 1){
            if ([textField.text isEqualToString:@"0"]) {
                return [string isEqualToString:@"."];
            }
            else{
                return NO;
            }
        }
        else{//只能输入一个.
            if ([textField.text rangeOfString:@"."].length) {
                if ([string isEqualToString:@"."]) {
                    return NO;
                }
                //两位小数
                NSArray *ary =  [textField.text componentsSeparatedByString:@"."];
                if (ary.count == 2) {
                    if ([ary[1] length] == 2) {
                        return NO;
                    }
                    else{
                        return YES;
                    }
                }
                else{
                    return YES;
                }
            }
            else{
                return YES;
            }
        }
    }
    else{
        return YES;
    }
}

-(void)setTitle:(NSString *)title{
    [_navigationTitle setText:title];
}

//#pragma mark 导航栏始终保持黑底白字
//- (UIStatusBarStyle)preferredStatusBarStyle{return UIStatusBarStyleLightContent;}
//- (BOOL)prefersStatusBarHidden{return NO;}

- (void)_keyboardWillShow{
    [self scrollUp];
}

- (void)_keyboardWillHide{
    [self scrollBack];
}
- (void)scrollUp{
    
    //    if (_isAlertViewShowing) {
    //        return;
    //    }
    UIView *responder = [self.view.window findFirstResponder];
    if (!_isScrollUp) {
        _contentView.contentSize = CGSizeMake(kScreenWidth, self.contentView.contentSize.height + kInputViewHeight);
        _isScrollUp = YES;
    }
    CGRect rect = [self.contentView convertRect:responder.frame fromView:responder.superview];
    CGFloat distance = 0;
    if (MBIsIPhone5()) {
        distance = rect.origin.y - 160 > 0 ? rect.origin.y - 160 : 0;
    } else {
        distance = rect.origin.y - 80 > 0 ? rect.origin.y - 80 : 0;
    }
    
    [self.contentView setContentOffset:CGPointMake(0, distance) animated:YES];
}

- (void)scrollBack{
    if (_isScrollUp) {
        [_contentView contentSizeToFit];
        _isScrollUp = NO;
    }
    [_contentView scrollToBottomAnimated:YES];
}

-(void)hideTabBar:(BOOL)isHide{
    
    [[self _getTabBarCtrl] tabBarHidden:isHide];
}
-(ALTabBarViewController *)_getTabBarCtrl{
    ALTabBarViewController *theTabBarCtrl=(ALTabBarViewController *)self.tabBarController;
    return theTabBarCtrl;
}
-(void)afterAction:(void(^)())finish afterVal:(float)val{
    [[ALComAction sharedInstance] afterAction:^{
        if (finish) {
            finish();
        }
    } afterVal:val];
}
- (void)makeTabBarHidden:(BOOL)hide
{
    if ( [self.tabBarController.view.subviews count] < 2 )
    {
        return;
    }
    UIView *contentView;
    
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    // [UIView beginAnimations:@"TabbarHide" context:nil];
    if ( hide )
    {
        contentView.frame = self.tabBarController.view.bounds;
    }
    else
    {
        contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
                                       self.tabBarController.view.bounds.origin.y,
                                       self.tabBarController.view.bounds.size.width,
                                       self.tabBarController.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    }
    
    self.tabBarController.tabBar.hidden = hide;
    // [UIView commitAnimations];
}
-(void)showShare{
    
    /*
     NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
     
     //构造分享内容
     id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
     defaultContent:@"测试一下"
     image:[ShareSDK imageWithPath:imagePath]
     title:@"今天我长这样"
     url:@"http://www.mob.com"
     description:@"这是一条测试信息"
     mediaType:SSPublishContentMediaTypeNews];
     //创建弹出菜单容器
     id<ISSContainer> container = [ShareSDK container];
     
     //弹出分享菜单
     [ShareSDK showShareActionSheet:container
     shareList:nil
     content:publishContent
     statusBarTips:YES
     authOptions:nil
     shareOptions:nil
     result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
     
     if (state == SSResponseStateSuccess)
     {
     showWarn(@"分享成功");
     }
     else if (state == SSResponseStateFail)
     {
     showWarn(@"分享失败");
     }
     }];
     */
}

//弹出效果的动画
+(void)animationMainView:(UIView *)mainView
              andPopView:(UIView *)popView{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = .5;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [popView.layer addAnimation:animation forKey:nil];
    
    [mainView addSubview:popView];
}
#pragma mark 分享
#pragma mark -
-(void)showShare:(BOOL)show andClick:(void(^)(NSInteger index))theClick{
    AppDelegate *theDelegate=[UIApplication sharedApplication].delegate;
    
    if (show) {
        
        UIGestureRecognizer *tag=[[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(tag:)];
        [tag setDelegate:self];
        
        ALComView * bgView=[[ALComView alloc]
                            initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [bgView setBackgroundColor:[UIColor blackColor]];
        [bgView setAlpha:.5f];
        [theDelegate.window addSubview:bgView];
        [bgView addGestureRecognizer:tag];
        [bgView setTag:10001];
        
        ALComView * shareView=[[ALComView alloc]
                               initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 326/2+120/2+30)];
        [shareView setBackgroundColor:[UIColor whiteColor]];
        [theDelegate.window addSubview:shareView];
        [shareView setTag:10002];
        
        //        NSArray *imgArr=@[@"sns_icon_22",@"sns_icon_23",@"sns_icon_1",@"sns_icon_24",@"sns_icon_6",@"sns_icon_2"];
        //        NSArray *titArr=@[@"微信好友",@"朋友圈",@"新浪微博",@"QQ好友",@"QQ空间",@"腾讯微博"];
        NSArray *imgArr=@[@"sns_icon_22",@"sns_icon_23",@"sns_icon_1",@"sns_icon_24",@"sns_icon_6"];
        NSArray *titArr=@[@"微信好友",@"朋友圈",@"新浪微博",@"QQ好友",@"QQ空间"];
        [imgArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALButton *shareBtn=[ALButton buttonWithType:UIButtonTypeCustom];
            if (idx<=3) {
                [shareBtn setFrame:CGRectMake((kScreenWidth-4*(120/2))/5*(idx+1)+120/2*idx, 10, 120/2, 120/2+30)];
            }else{
                [shareBtn setFrame:CGRectMake((kScreenWidth-4*(120/2))/5*((idx-4)+1)+120/2*(idx-4), 10+120/2+30, 120/2, 120/2+30)];
            }
            [shareBtn setImage:[ALImage imageNamed:imgArr[idx]] forState:UIControlStateNormal];
            [shareBtn setTitle:titArr[idx] forState:UIControlStateNormal];
            [shareBtn setTitleColor:colorByStr(@"#333333") forState:UIControlStateNormal];
            shareBtn.titleLabel.font=[UIFont systemFontOfSize:20/2];
            [shareBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            //            [shareBtn.imageView setWidth:120/2];
            //            [shareBtn.imageView setHidden:120/2];
            //            [shareBtn setAlignment];
            [shareBtn.titleLabel setWidth:[ALComAction getSizeByStr:[shareBtn titleForState:UIControlStateNormal]
                                                            andFont:shareBtn.titleLabel.font].width];
            float width=[ALComAction getSizeByStr:[shareBtn titleForState:UIControlStateNormal]
                                          andFont:shareBtn.titleLabel.font].width;
            
            [shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(shareBtn.height/3.0f*2+40,
                                                          (shareBtn.width-width)/2.0f-shareBtn.imageView.width,
                                                          0,
                                                          (shareBtn.width-width)/2.0f-shareBtn.imageView.width)];
            [shareBtn setTheBtnClickBlock:^(id sender){
                if (theClick) {
                    theClick(idx);
                }
                [self showShare:NO andClick:nil];
            }];
            [shareView addSubview:shareBtn];
        }];
        
        ALButton *cancelBtn=[ALButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setFrame:CGRectMake(0, 38/2+120/2+30+5+120/2+30, shareView.width, 45)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:colorByStr(@"#FF6633") forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:36/2]];
        [cancelBtn setTheBtnClickBlock:^(id sender){
            [self showShare:NO andClick:^(NSInteger index) {
                
            }];
        }];
        [shareView addSubview:cancelBtn];
        
        [UIView animateWithDuration:.2f animations:^{
            [shareView setFrame:CGRectMake(0, kScreenHeight-shareView.height, kScreenWidth, shareView.height)];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        __block ALComView *bgView=(ALComView *)[theDelegate.window viewWithTag:10001];
        __block ALComView *shareView=(ALComView *)[theDelegate.window viewWithTag:10002];
        [UIView animateWithDuration:.2 animations:^{
            [shareView setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, shareView.height)];
        } completion:^(BOOL finished) {
            [shareView removeFromSuperview];
            shareView=nil;
            
            [bgView removeFromSuperview];
            bgView=nil;
        }];
    }
}
-(void)tag:(UIGestureRecognizer *)theGesture{
    [self showShare:NO andClick:nil];
}
#pragma mark 微信
- (void) sendTextContent:(NSString *)content andType:(enum WXScene)scene andUrlstr:(NSString *)urlStr
{
    WXMediaMessage *theMes=[WXMediaMessage message];
    theMes.title=content;
    theMes.description=content;
    theMes.mediaTagName=@"name";
    
    NSURL * theUrl=[NSURL URLWithString:urlStr];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:theUrl]];
    
    [theMes setThumbImage:image];
    
    WXImageObject *ext=[WXImageObject object];
    [ext setImageData:theMes.thumbData];
    [ext setImageUrl:urlStr];
    
    theMes.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = content;
    req.bText = NO;
    req.scene = scene;
    req.message=theMes;
    
    [WXApi sendReq:req];
}
#pragma mark 新浪微博
- (void) sendWBTextContent:(NSString *)content andUrlstr:(NSString *)urlStr
{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = getTxt(@"wbRedirectURI");
    authRequest.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = content;
    
    NSURL * theUrl=[NSURL URLWithString:urlStr];
    //    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:theUrl]];
    WBImageObject *theImgObj=[WBImageObject object];
    [theImgObj setImageData:[NSData dataWithContentsOfURL:theUrl]];
    [message setImageObject:theImgObj];
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest
                                            requestWithMessage:message
                                            authInfo:authRequest
                                            access_token:getTxt(@"sinaAppKey")];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}
//分享到空间
- (void)shareToQzone:(NSString *)content andUrlstr:(NSString *)urlStr
{
    NSURL *url=[NSURL URLWithString:urlStr];
    QQApiNewsObject* imgObj = [QQApiNewsObject
                               objectWithURL:url
                               title:content
                               description:content
                               previewImageURL:url];
    [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}
//分享到QQ好友
-(void)shareToFriend:(NSString *)content andUrlstr:(NSString *)urlStr{
    NSURL *url=[NSURL URLWithString:urlStr];
    QQApiNewsObject* imgObj = [QQApiNewsObject
                               objectWithURL:url
                               title:content
                               description:content
                               previewImageURL:url];
    [imgObj setCflag:kQQAPICtrlFlagQZoneShareForbid];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}
- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        default:
        {
            break;
        }
    }
}
-(void)wxLoginAndBlock:(void(^)(id sender))theBlock{
    AppDelegate *theDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [theDelegate wxLoginAndBlock:^(id sender) {
        if (theBlock) {
            theBlock(sender);
        }
    }];
}
-(void)qqLoginAndBlock:(void(^)(id sender))theBlock{
    AppDelegate *theDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [theDelegate qqLoginAndBlock:^(id sender) {
        if (theBlock) {
            theBlock(sender);
        }
    }];
}
-(void)wbLoginAndBlock:(void(^)(id sender))theBlock{
    AppDelegate *theDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [theDelegate wbLoginAndBlock:^(id sender) {
        if (theBlock) {
            theBlock(sender);
        }
    }];
}
@end
