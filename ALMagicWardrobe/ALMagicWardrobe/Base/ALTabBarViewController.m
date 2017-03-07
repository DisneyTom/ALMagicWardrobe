//
//  ALTabBarViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALTabBarViewController.h"

#import "ALFashionSquareViewController.h" //潮流广场
#import "ALMagicWardrobeViewController.h" //魔法衣橱
#import "ALMagicBagViewController.h" //魔法包
#import "ALMineViewController.h"  //我的

#import "ALNavigationViewController.h"  //根导航

@interface ALTabBarViewController ()
{
    ALFashionSquareViewController *_theFashionSquareCtrl;
    ALMagicWardrobeViewController *_theMagicWardrobeCtrl;
    ALMagicBagViewController *_theMagicBagCtrl;
    ALMineViewController *_theMineCtrl;
    
    NSMutableArray *_barItemArray; //存放tabBar
    ALComView *_tabBarBgView; //tabBar背景View
    UIImageView* imgView_;
}
@end
@implementation ALTabBarViewController
-(void)getMessage
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"messageStatu"] && [[[NSUserDefaults standardUserDefaults]objectForKey:@"messageStatu"]  isEqualToString:@"1"])
    {
        if ([[ALLoginUserManager sharedInstance] loginCheck])
        {
            imgView_.hidden = false;
        }
    }
    else
    {
        imgView_.hidden = true;
    }
}

+ (instancetype)shareALTabBarVC
{
    static ALTabBarViewController *tabBarVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBarVC = [[ALTabBarViewController alloc] init];
    });
    return tabBarVC;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getMessage];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setUserInteractionEnabled:YES];
    __block ALTabBarViewController* theBlock = self;
    _theFashionSquareCtrl=[[ALFashionSquareViewController alloc] init];
    _theMagicWardrobeCtrl=[[ALMagicWardrobeViewController alloc] init];
    _theMagicBagCtrl=[[ALMagicBagViewController alloc] init];
    [_theMagicBagCtrl setTheBlcokALToMyAL:^(){
        [theBlock toMyAL];
    }];
    _theMineCtrl=[[ALMineViewController alloc] init];
    _theMineCtrl.tb_Ctrl = self;

    //潮流广场
    ALNavigationViewController *fashionSquareNVC = [[ALNavigationViewController alloc]
                                                    initWithRootViewController:_theFashionSquareCtrl];
    //魔法衣橱
    ALNavigationViewController *magicWardrobeNVC = [[ALNavigationViewController alloc]
                                                    initWithRootViewController:_theMagicWardrobeCtrl];
    //魔法包
    ALNavigationViewController *magicBagNVC = [[ALNavigationViewController alloc]
                                               initWithRootViewController:_theMagicBagCtrl];
    //个人中心
    ALNavigationViewController *mineNVC = [[ALNavigationViewController alloc]
                                           initWithRootViewController:_theMineCtrl];
    
    self.viewControllers = @[
                             fashionSquareNVC,
                             magicWardrobeNVC,
                             magicBagNVC,
                             mineNVC
                             ];
    
    NSArray *tabBarTitArr=@[
                            @"icon013",
                            @"icon014",
                            @"icon015",
                            @"icon016"
                            ];
    
    _barItemArray = [[NSMutableArray alloc] init];
    
    if (isIOS7) {
        self.tabBar.itemWidth = kTabbarItemWidth;
    }
    self.tabBar.backgroundColor=AL_RGB(46,55,61);
    
    _tabBarBgView=[[ALComView alloc]
                   initWithFrame:CGRectMake(
                                            0,
                                            0,
                                            self.tabBar.width,
                                            kTabBarHeight)];
    [_tabBarBgView setBackgroundColor:colorByStr(@"#F0ECE9")];
    [_tabBarBgView setCustemViewWithType:TopLine_type
                         andTopLineColor:AL_RGB(175,154,123)
                      andBottomLineColor:nil];
    [self.tabBar addSubview:_tabBarBgView];
    
    __block float left=0.0f;
    [tabBarTitArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALButton *btn = [ALButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(
                               left,
                               0,
                               kTabbarItemWidth,
                               kTabBarHeight);
        btn.tag = idx;
        if (idx == 3)
        {
            imgView_ = [[UIImageView alloc]init];
            imgView_.layer.cornerRadius = 4;
            imgView_.backgroundColor = [UIColor redColor];
            imgView_.frame = CGRectMake(44,4, 8, 8);
            imgView_.hidden = true;
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"messageStatu"] && [[[NSUserDefaults standardUserDefaults]objectForKey:@"messageStatu"]  isEqualToString:@"1"])
            {
                if ([[ALLoginUserManager sharedInstance] loginCheck])
                {
                    imgView_.hidden = false;
                }
            }
            [btn addSubview:imgView_];
        }
        [btn setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_on",obj]] forState:UIControlStateSelected];
        [_barItemArray addObject:btn];
        [_tabBarBgView addSubview:btn];
        
        switch (idx)
        {
            case 0:
                [btn setSelected:YES];
                [btn setBackgroundColor:[UIColor clearColor]];
                
                self.selectedIndex=btn.tag;
                break;
            default:
                [btn setSelected:NO];
                break;
        }
        
        
        [btn setTheBtnClickBlock:^(id sender)
        {
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"messageStatu"] && [[[NSUserDefaults standardUserDefaults]objectForKey:@"messageStatu"]  isEqualToString:@"1"])
            {
                if ([[ALLoginUserManager sharedInstance] loginCheck])
                {
                    imgView_.hidden = false;
                }
            }
            else
            {
                imgView_.hidden = true;
            }
            ALButton *theBtn = _barItemArray[self.selectedIndex];
            [theBtn setSelected:NO];
                
            self.selectedIndex = ((ALButton *)sender).tag;
            theBtn = _barItemArray [self.selectedIndex];
            [theBtn setSelected:YES];
        }];
        
        left += kTabbarItemWidth;
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:HIDETABBARVIEW
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      if ([[note userInfo][@"isHide"] isEqualToString:@"1"]) { //隐藏
                                                          [self tabBarHidden:YES];
                                                      }
                                                      else{
                                                          [self tabBarHidden:NO];
                                                      }
                                                  }];
    //    //注册成功通知
    //    [[NSNotificationCenter defaultCenter] addObserverForName:SIGNUPBACKNOTI
    //                                                      object:nil
    //                                                       queue:nil
    //                                                  usingBlock:^(NSNotification *note) {
    //                                                     ;
    //    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SignUpBackNoTi:) name:SIGNUPBACKNOTI object:nil];
}
-(void)SignUpBackNoTi:(id)sender{
    [self selectTabIndex:0];
}
-(void)toMyAL
{
    [self selectTabIndex:1];
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}
//退出到登录界面
- (void)pushToLogin:(BOOL)animated andRushUserVideos:(BOOL)rush
{
    UIButton *theBtn = _barItemArray[self.selectedIndex];
    theBtn.backgroundColor = [UIColor clearColor];
    
    self.selectedIndex = 3;
    theBtn = _barItemArray [self.selectedIndex];
    theBtn.backgroundColor=AL_RGB(40, 47, 53);
}
//-(void)hideTabBar:(BOOL)isHide{
//    if (isHide) {
//        [self.tabBar setHidden:YES];
//        [_tabBarBgView setHidden:YES];
//    }
//    else{
//        [self.tabBar setHidden:NO];
//        [_tabBarBgView setHidden:NO];
//    }
//}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)tabBarHidden:(BOOL)hidden{
    if (hidden) { //隐藏
        [UIView animateWithDuration:0.5 animations:^{
            [self.tabBar setHidden:YES];    
            //            [_tabBarBgView setFrame:CGRectMake(0, IOS5_Height, kScreenWidth, 49)];
        }];
    }
    else{ //显示
        [UIView animateWithDuration:0.25 animations:^{
            [self.tabBar setHidden:NO];
            //            [_tabBarBgView setFrame:CGRectMake(0, IOS5_Height-(isIOS7?49:29), kScreenWidth, 49)];
        }];
    }
}

-(void)selectTabIndex:(NSInteger)index{
    ALButton *theBtn = _barItemArray[self.selectedIndex];
    [theBtn setSelected:NO];
    
    self.selectedIndex = index;
    theBtn = _barItemArray [self.selectedIndex];
    [theBtn setSelected:YES];
}
@end
