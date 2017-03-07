//
//  ALTestControlViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALTestControlViewController.h"
#import "ALOneProductView.h"
#import "ALTwoProductView.h"
#import "ALThreeProductView.h"
#import "ALFourProductView.h"
#import "ALFiveProductView.h"
#import "ALSixProductView.h"
#import "ALSevenProductView.h"
#import "ALEightProductView.h"
#import "ALNineProductView.h"
#import "SMPageControl.h"
#import "ALTabBarViewController.h"
#import "ALTestModel.h"

@interface ALTestControlViewController ()
<UIScrollViewDelegate>
@end

@implementation ALTestControlViewController
{
    float _orginY;
    ALScrollView *_theTestView;
    ALComView *_theTestFinishView;
    ALTestModel *_theTestModel;
    ALLabel *_contentLbl;
    ALLabel *_secContentLbl;
    ALLabel *_subContentLbl;
    UIImageView *_lineImg; //分割线
    ALImageView *bgImgView;
    SMPageControl *pageCtrl;
    
    ALButton *btn;
    
    BOOL _reTestRequest;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self setTitle:@"着装测试"];
    
    [self.contentView setBackgroundColor:AL_RGB(237,234,229)];
    
    [self _initData];
    
    [self _initView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (![[ALLoginUserManager sharedInstance] loginCheck]) {
        [btn setTitle:@"登录魔法衣橱，把精彩美衣带回家"
             forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"测试成功，把精彩美衣带回家"
             forState:UIControlStateNormal];
    }
}

-(void)_initData{
    _orginY=0;
    _theTestModel=[[ALTestModel alloc] init];
    _reTestRequest=NO;
}
-(void)_initView{

    _theTestView=[self _createTestProductView];
    [self.contentView addSubview:_theTestView];
    
    _theTestFinishView= [self _createTestFinishView];
    [_theTestFinishView setHidden:YES];
    [self.contentView addSubview:_theTestFinishView];
}
-(BOOL)filVal:(NSString *)val{
    if ([filterStr(val) length]>0) {
        return YES;
    }else{
        return NO;
    }
}
-(void)setValue:(ALTestModel *)comeTestModel{
    [self filVal:comeTestModel.height]? (_theTestModel.height=comeTestModel.height):@"";
    [self filVal:comeTestModel.weight]?(_theTestModel.weight=comeTestModel.weight):@"";
    [self filVal:comeTestModel.bar_size]?(_theTestModel.bar_size=comeTestModel.bar_size):@"";
    [self filVal:comeTestModel.brassiere]?(_theTestModel.brassiere=comeTestModel.brassiere):@"";
    [self filVal:comeTestModel.yaobu]?(_theTestModel.yaobu=comeTestModel.yaobu):@"";
    [self filVal:comeTestModel.tunbu]?(_theTestModel.tunbu=comeTestModel.tunbu):@"";
    [self filVal:comeTestModel.jianbu]?(_theTestModel.jianbu=comeTestModel.jianbu):@"";
    [self filVal:comeTestModel.neck]?(_theTestModel.neck=comeTestModel.neck):@"";
    [self filVal:comeTestModel.buttocks]?(_theTestModel.buttocks=comeTestModel.buttocks):@"";
    [self filVal:comeTestModel.shank]?(_theTestModel.shank=comeTestModel.shank):@"";
    [self filVal:comeTestModel.thigh]?(_theTestModel.thigh=comeTestModel.thigh):@"";
    [self filVal:comeTestModel.size]?(_theTestModel.size=comeTestModel.size):@"";
    [self filVal:comeTestModel.habitus]?(_theTestModel.habitus=comeTestModel.habitus):@"";
    [self filVal:comeTestModel.bust]?(_theTestModel.bust=comeTestModel.bust):@"";
    [self filVal:comeTestModel.waistline]?(_theTestModel.waistline=comeTestModel.waistline):@"";
   [self filVal:comeTestModel.hipline]? (_theTestModel.hipline=comeTestModel.hipline):@"";
    [self filVal:comeTestModel.shoulder]?(_theTestModel.shoulder=comeTestModel.shoulder):@"";
    [self filVal:comeTestModel.age_group]?(_theTestModel.age_group=comeTestModel.age_group):@"";
    [self filVal:comeTestModel.occupation]?(_theTestModel.occupation=comeTestModel.occupation):@"";
    [self filVal:comeTestModel.style]?(_theTestModel.style=comeTestModel.style):@"";
    [self filVal:comeTestModel.wish_style]?(_theTestModel.wish_style=comeTestModel.wish_style):@"";
    [self filVal:comeTestModel.avoid_colour]?(_theTestModel.avoid_colour=comeTestModel.avoid_colour):@"";
    [self filVal:comeTestModel.avoid_pic]?(_theTestModel.avoid_pic=comeTestModel.avoid_pic):@"";
    [self filVal:comeTestModel.avoid_tec]?( _theTestModel.avoid_tec=comeTestModel.avoid_tec):@"";
    [self filVal:comeTestModel.birthday]?(_theTestModel.birthday=comeTestModel.birthday):@"";
    [self filVal:comeTestModel.status]?(_theTestModel.status=comeTestModel.status):@"";
    [self filVal:comeTestModel.wish]?(_theTestModel.wish=comeTestModel.wish):@"";
}
-(ALScrollView *)_createTestProductView{
//    __block ALTestModel *theTestModel=_theTestModel;
    ALScrollView *contentScrollView=[[ALScrollView alloc]
                                     initWithFrame:CGRectMake(
                                                              0,
                                                              0,
                                                              kScreenWidth,
                                                              kScreenHeight - 20)];
    [contentScrollView setDelegate:self];
    [contentScrollView setPagingEnabled:YES];
    contentScrollView.horizontalIndicator.hidden = YES;
    
    ALOneProductView *oneView=[[ALOneProductView alloc]
                               initWithFrame:CGRectMake(0*kScreenWidth, 0, kScreenWidth, self.contentView.height - 0) andBackBlock:^(ALTestModel * theModel) {
                                   [self setValue:theModel];
                               }];
    oneView.scrollEnabled = NO;
    [contentScrollView addSubview:oneView];
    
    ALTwoProductView *twoView=[[ALTwoProductView alloc]
                               initWithFrame:CGRectMake(1*kScreenWidth, 0, kScreenWidth, self.contentView.height) andBackBlock:^(ALTestModel * theModel) {
                                   [self setValue:theModel];
                               }];
    [contentScrollView addSubview:twoView];
    
    ALThreeProductView *threeView=[[ALThreeProductView alloc]
                                   initWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, self.contentView.height) andBackBlock:^(ALTestModel * theModel) {
                                       [self setValue:theModel];
 
                                   }];
    [contentScrollView addSubview:threeView];
    
    ALFourProductView *fourView=[[ALFourProductView alloc]
                                 initWithFrame:CGRectMake(3*kScreenWidth, 0, kScreenWidth, self.contentView.height - 30) andBackBlock:^(ALTestModel * theModel) {
                                     [self setValue:theModel];

                                 }];
    [contentScrollView addSubview:fourView];
    
    ALFiveProductView *fiveView=[[ALFiveProductView alloc]
                                 initWithFrame:CGRectMake(4*kScreenWidth, 0, kScreenWidth, kScreenHeight - 20) andBackBlock:^(ALTestModel * theModel) {
                                     [self setValue:theModel];
                                     fiveView.scrollEnabled  = NO;
//                                     fiveView.contentSize = CGSizeMake(kScreenWidth, self.contentView.height);
                                 }];
    [contentScrollView addSubview:fiveView];
    
    
    ALSixProductView *sixView=[[ALSixProductView alloc]
                               initWithFrame:CGRectMake(5*kScreenWidth, 0, kScreenWidth, self.contentView.height) andBackBlock:^(ALTestModel * theModel) {
                                   [self setValue:theModel];
                                   sixView.scrollEnabled  = NO;
                                   sixView.contentSize = CGSizeMake(kScreenWidth, self.contentView.height);
                               }];
    [contentScrollView addSubview:sixView];
    
    
    ALSevenProductView *sevenView=[[ALSevenProductView alloc]
                                   initWithFrame:CGRectMake(6*kScreenWidth, 0, kScreenWidth, self.contentView.height) andBackBlock:^(ALTestModel * theModel) {
                                       [self setValue:theModel];
 
                                   }];
    [contentScrollView addSubview:sevenView];
    
    ALEightProductView *eightView=[[ALEightProductView alloc]
                                   initWithFrame:CGRectMake(7*kScreenWidth, 0, kScreenWidth, self.contentView.height) andBackBlock:^(ALTestModel * theModel) {
                                       [self setValue:theModel];

                                   }];
    [contentScrollView addSubview:eightView];
    
    ALNineProductView *nineView=[[ALNineProductView alloc]
                                 initWithFrame:CGRectMake(8*kScreenWidth, 0, kScreenWidth, self.contentView.height) andBackBlock:^(ALTestModel * theModel) {
                                     [self setValue:theModel];
                                 }];
    [nineView setTheComitBlock:^(id sender){
        [self requestTestResultAndBlock:^{
            
        }];
    }];
    [contentScrollView addSubview:nineView];
    
    pageCtrl = [[SMPageControl alloc]
                initWithFrame:CGRectMake(kLeftSpace,
                                         kScreenHeight-38,
                                         kScreenWidth-kLeftSpace-kRightSpace,
                                         38)];
    pageCtrl.numberOfPages = 9;
    pageCtrl.pageIndicatorImage=[ALImage imageNamed:@"1212"];
    pageCtrl.currentPageIndicatorImage=[ALImage imageNamed:@"1213"];
    pageCtrl.backgroundColor = AL_RGB(240,236,233);;
    [self.view addSubview:pageCtrl];

    return contentScrollView;
}
-(void)requestTestResultAndBlock:(void(^)())theBlock{
//    if (![[ALLoginUserManager sharedInstance] loginCheck]) {
//        [self toLoginAndBlock:^{
//            [self requestTestResult];
//        } andObj:self];
//        return;
//    }
    
    if (_theTestModel.height.length <= 0)
    {
        showWarn(@"请填写你的身高");
        [_theTestView scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, kScreenHeight)  animated:YES];
        return;
    }
    if (_theTestModel.weight.length <= 0)
    {
        showWarn(@"请填写你的体重");
        [_theTestView scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, kScreenHeight)  animated:YES];
        return;
    }
    if (_theTestModel.bar_size.length <= 0)
    {
        showWarn(@"请填写你的胸衣尺寸");
        [_theTestView scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, kScreenHeight)  animated:YES];
        return;
    }
    if (_theTestModel.brassiere.length <= 0)
    {
        showWarn(@"请填写你的胸衣尺寸");
        [_theTestView scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, kScreenHeight)  animated:YES];
        return;
    }
    if (_theTestModel.yaobu.length <= 0)
    {
        showWarn(@"请选择你的腰部特征");
        [_theTestView scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, kScreenHeight)  animated:YES];
        return;
    }
    if (_theTestModel.tunbu.length <= 0)
    {
        showWarn(@"请选择你的臀部特征");
        [_theTestView scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, kScreenHeight)  animated:YES];
        return;
    }
    
    //第二页
    if (_theTestModel.jianbu.length <= 0)
    {
        [self scrollviewToIndex:1 tip:@"请选择你的肩部特征"];
        return;
    }
    if (_theTestModel.neck.length <= 0)
    {
        [self scrollviewToIndex:1 tip:@"请选择你的颈部特征"];
        return;
    }
    if (_theTestModel.buttocks.length <= 0)
    {
        [self scrollviewToIndex:1 tip:@"请选择你的上臂特征"];
        return;
    }
    if (_theTestModel.shank.length <= 0)
    {
        [self scrollviewToIndex:1 tip:@"请选择你的小腿特征"];
        return;
    }
    if (_theTestModel.thigh.length <= 0)
    {
        [self scrollviewToIndex:1 tip:@"请选择你的大腿特征"];
        return;
    }
    if (_theTestModel.size.length <= 0)
    {
        [self scrollviewToIndex:1 tip:@"请选择你常穿的衣服尺码"];
        return;
    }
    
    //第三页
    if (_theTestModel.habitus.length <= 0)
    {
        [self scrollviewToIndex:2 tip:@"请选择你的体形"];
        return;
    }
//    if (_theTestModel.bust.length <= 0)
//    {
//        [self scrollviewToIndex:2 tip:@"请填写你的胸围"];
//        return;
//    }
//    if (_theTestModel.waistline.length <= 0)
//    {
//        [self scrollviewToIndex:2 tip:@"请填写你的腰围"];
//        return;
//    }
//    if (_theTestModel.hipline.length <= 0)
//    {
//        [self scrollviewToIndex:2 tip:@"请填写你的臀围"];
//        return;
//    }
//    if (_theTestModel.shoulder.length <= 0)
//    {
//        [self scrollviewToIndex:2 tip:@"请填写你的肩宽"];
//        return;
//    }
    
    //第四页
    if (_theTestModel.age_group.length <= 0)
    {
        [self scrollviewToIndex:3 tip:@"请选择你的年龄"];
        return;
    }
    if (_theTestModel.occupation.length <= 0)
    {
        [self scrollviewToIndex:3 tip:@"请选择你的职业"];
        return;
    }
    
    //第五页
    if (_theTestModel.style.length <= 0)
    {
        [self scrollviewToIndex:4 tip:@"请至少选择一个你常穿的风格"];
        return;
    }
    
    //第六页
    if (_theTestModel.wish_style.length <= 0)
    {
        [self scrollviewToIndex:5 tip:@"请至少选择一个你近期想尝试的风格"];
        return;
    }
    
    //第七页
    if (_theTestModel.avoid_colour.length <= 0)
    {
        [self scrollviewToIndex:6 tip:@"如没有不能接受的服装颜色,请选择无"];
        return;
    }
    if (_theTestModel.avoid_pic.length <= 0)
    {
        [self scrollviewToIndex:6 tip:@"如没有不能接受的服装图案,请选择无"];
        return;
    }
    
    //第八页
    if (_theTestModel.avoid_tec.length <= 0)
    {
        [self scrollviewToIndex:7 tip:@"如没有不能接受的服装工艺,请选择无"];
        return;
    }
    
    //第九页
    if (_theTestModel.birthday.length <= 0)
    {
//        [self scrollviewToIndex:8 tip:@"请输入你的生日"];
        showWarn(@"请输入你的生日");
        return;
    }
    if (_theTestModel.status.length <= 0)
    {
        showWarn(@"请选择你最近的状态");
        return;
    }
    if (_theTestModel.wish.length <= 0)
    {
        showWarn(@"请选择你最近的心愿");
        return;
    }
    
    ALLoginUserManager *userManger = [ALLoginUserManager sharedInstance];
    [_theTestModel setUserId:filterStr([userManger getUserId])];
//    [userManger setUserBieMing];
    
    NSDictionary *sendDic=@{
                            @"userId":MBNonEmptyStringNo_(filterStr(_theTestModel.userId)),
                            @"height":MBNonEmptyStringNo_(filterStr(_theTestModel.height)),
                            @"weight":MBNonEmptyStringNo_(filterStr(_theTestModel.weight)),
                            @"bar_size":MBNonEmptyStringNo_(filterStr(_theTestModel.bar_size)),
                            @"brassiere":MBNonEmptyStringNo_(filterStr(_theTestModel.brassiere)),
                            @"yaobu":MBNonEmptyStringNo_(filterStr(_theTestModel.yaobu)),
                            @"tunbu":MBNonEmptyStringNo_(filterStr(_theTestModel.tunbu)),
                            @"jianbu":MBNonEmptyStringNo_(filterStr(_theTestModel.jianbu)),
                            @"neck":MBNonEmptyStringNo_(filterStr(_theTestModel.neck)),
                            @"buttocks":MBNonEmptyStringNo_(filterStr(_theTestModel.buttocks)),
                            @"shank":MBNonEmptyStringNo_(filterStr(_theTestModel.shank)),
                            @"thigh":MBNonEmptyStringNo_(filterStr(_theTestModel.thigh)),
                            @"size":MBNonEmptyStringNo_(filterStr(_theTestModel.size)),
                            @"habitus":MBNonEmptyStringNo_(filterStr(_theTestModel.habitus)),
                            @"bust":MBNonEmptyStringNo_(filterStr(_theTestModel.bust)),
                            @"waistline":MBNonEmptyStringNo_(filterStr(_theTestModel.waistline)),
                            @"hipline":MBNonEmptyStringNo_(filterStr(_theTestModel.hipline)),
                            @"shoulder":MBNonEmptyStringNo_(filterStr(_theTestModel.shoulder)),
                            @"age_group":MBNonEmptyStringNo_(filterStr(_theTestModel.age_group)),
                            @"occupation":MBNonEmptyStringNo_(filterStr(_theTestModel.occupation)),
                            @"style":MBNonEmptyStringNo_(filterStr(_theTestModel.style)),
                            @"wish_style":MBNonEmptyStringNo_(filterStr(_theTestModel.wish_style)),
                            @"avoid_colour":MBNonEmptyStringNo_(filterStr(_theTestModel.avoid_colour)),
                            @"avoid_pic":MBNonEmptyStringNo_(filterStr(_theTestModel.avoid_pic)),
                            @"avoid_tec":MBNonEmptyStringNo_(filterStr(_theTestModel.avoid_tec)),
                            @"birthday":MBNonEmptyStringNo_(filterStr(_theTestModel.birthday)),
                            @"status":MBNonEmptyStringNo_(filterStr(_theTestModel.status)),
                            @"wish":MBNonEmptyStringNo_(filterStr(_theTestModel.wish))
                            };
    [DataRequest requestApiName:@"fashionSquare_saveTestResult"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       if (_reTestRequest) {
                           
                       }else{
                       if(!sucContent[@"body"]||![MBNonEmptyStringNo_(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                           showWarn(@"测试失败");
                           
                       }else{
                           showWarn(@"测试成功");
                           
                           [[NSUserDefaults standardUserDefaults] setValue:sendDic forKey:MWFIRSTINFO];
                           [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:MWFIRST];
                           [[NSUserDefaults standardUserDefaults]synchronize];
                           @try {
                               CGFloat contextY = 0.f;
                               NSString *aStr = MBNonEmptyString(sucContent[@"body"][@"result"][@"A"]);
                               if (aStr.length>1)
                               {
                                   NSString *first = [NSString stringWithFormat:@"%@ %@",@"你知道吗?",aStr];
                                   CGSize size = [ALComAction getSizeByStr:first andFont:[UIFont systemFontOfSize:12] andRect:CGSizeMake(270, 0)];
                                   
                                   NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:first];
                                   NSInteger length = str.length;
                                  [str addAttribute:NSForegroundColorAttributeName value:AL_RGB(62, 62, 62) range:NSMakeRange(0,5)];
                                  [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,5)];
                                   [str addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#9c9a96") range:NSMakeRange(6,length-6)];
                                   [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(6, length - 6)];
                                   
                                   
                                   _contentLbl.attributedText = str;
                                
                                   _contentLbl.frame = CGRectMake(10, 20, 270, size.height + 18);
                                   contextY = CGRectGetMaxY(_contentLbl.frame);
                               }
                               NSString *bStr = filterStr(sucContent[@"body"][@"result"][@"B"]);
                               if (bStr.length > 0)
                               {
                                   contextY = contextY + 15.f;
                                   CGSize size = [ALComAction getSizeByStr:bStr andFont:[UIFont systemFontOfSize:12] andRect:CGSizeMake(270, 0)];
                                   _secContentLbl.text = bStr;
                                   _secContentLbl.frame = CGRectMake(10, contextY, 270, size.height + 18);
                                   contextY = CGRectGetMaxY(_secContentLbl.frame);
                               }
                               if (aStr.length > 0 || bStr.length > 0)
                               {
                                   _lineImg.frame = CGRectMake(10, contextY + 15, 270, 0.5);
                                   _lineImg.hidden = NO;
                                   contextY = CGRectGetMaxY(_lineImg.frame) + 15;
                               }
                               else
                               {
                                   _lineImg.hidden = YES;
                               }

                               
                               NSString *cStr = sucContent[@"body"][@"result"][@"C"];
                               if (cStr.length > 0)
                               {
                                   NSString *first = [NSString stringWithFormat:@"%@ %@",@"扬长避短的细节:",cStr];
                                   CGSize size = [ALComAction getSizeByStr:first andFont:[UIFont systemFontOfSize:12] andRect:CGSizeMake(270, 0)];
                                   
                                   NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:first];
                                   NSInteger length = str.length;
                                   [str addAttribute:NSForegroundColorAttributeName value:AL_RGB(62, 62, 62) range:NSMakeRange(0,8)];
                                   [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,8)];
                                   [str addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#9c9a96") range:NSMakeRange(8,length-8)];
                                   [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(8, length - 8)];
                                   
                
                                   _subContentLbl.attributedText = str;
                                   _subContentLbl.frame = CGRectMake(10, contextY, 270, size.height + 18);
                                   contextY = CGRectGetMaxY(_subContentLbl.frame);
                               }
                               bgImgView.frame = CGRectMake(15, 40, 290, contextY + 30);
                               CGFloat btnY = bgImgView.bottom+30;
                               if (btnY <= 371)
                               {
                                   btnY = 371;
                               }
                               [btn setFrame:CGRectMake(40, btnY, 240, 30)];
                               
                           }
                           @catch (NSException *exception) {
                           }
                           @finally {
                           }
                           [_theTestView setHidden:YES];
                           [_theTestFinishView setHidden:NO];
                       }
                       }
                       if (theBlock) {
                           theBlock();
                       }
    } failedBlock:^(id failContent) {
       showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}

#pragma mark - 滚动到指定的位置
- (void)scrollviewToIndex:(NSInteger)index tip:(NSString *)tip
{
    showWarn(tip);
    [_theTestView scrollRectToVisible:CGRectMake(kScreenWidth * index, 0, kScreenWidth, kScreenHeight)  animated:YES];
}

-(ALComView *)_createTestFinishView{
    ALComView *theView=[[ALComView alloc]
                        initWithFrame:CGRectMake(0, 0, kScreenWidth, self.contentView.height)];
    
    bgImgView=[[ALImageView alloc]
                            initWithFrame:CGRectMake(15, 40, 290, 330)];
    [bgImgView setImage:[ALImage imageNamed:@"finish_bg"]];
    [theView addSubview:bgImgView];
    
    _contentLbl=[[ALLabel alloc]
                 initWithFrame:CGRectMake(10, 20, bgImgView.width-20, 870/4)
                 andColor:colorByStr(@"#9c9a96")
                 andFontNum:12];
    [_contentLbl setNumberOfLines:0];
    [bgImgView addSubview:_contentLbl];
    
    _secContentLbl =[[ALLabel alloc]
                     initWithFrame:CGRectMake(10, 20, bgImgView.width-20, 870/4)
                     andColor:colorByStr(@"#9c9a96")
                     andFontNum:12];
    [_secContentLbl setNumberOfLines:0];
    [bgImgView addSubview:_secContentLbl];
    
    _lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _lineImg.image = [UIImage imageNamed:@"oneLineSperate.png"];
    [bgImgView addSubview:_lineImg];
    
    _subContentLbl=[[ALLabel alloc]
                    initWithFrame:CGRectMake(5,
                                             _contentLbl.bottom+10,
                                             bgImgView.width-5-5,
                                             360/4)
                    andColor:colorByStr(@"#9c9a96")
                    andFontNum:12];
    [_subContentLbl setNumberOfLines:0];
    [bgImgView addSubview:_subContentLbl];
    
    btn=[ALButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(40,
                             bgImgView.bottom+30, 240, 30)];
    if (![[ALLoginUserManager sharedInstance] loginCheck]) {
        [btn setTitle:@"登录魔法衣橱，把精彩美衣带回家"
             forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"测试成功，把精彩美衣带回家"
             forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:[ALImage imageNamed:@"btn_bg"]
                   forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    __block ALTestControlViewController *theBlockCtrl=self;
    [btn setTheBtnClickBlock:^(id sender){
        
        if (theBlockCtrl.theBackBlock)
        {
            theBlockCtrl.theBackBlock(sender);
        }
        else
        {
            ALTabBarViewController* viewCtrl_T = [[ALTabBarViewController alloc]init];
            [viewCtrl_T selectTabIndex:1];
            [theBlockCtrl.navigationController pushViewController:viewCtrl_T animated:true];
        }
    }];
    [theView addSubview:btn];
    
    return theView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int curPage=scrollView.contentOffset.x/scrollView.width;
    [pageCtrl setCurrentPage:curPage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int curPage=scrollView.contentOffset.x/scrollView.width;
    [pageCtrl setCurrentPage:curPage];
}
-(void)reTestRequestAndBlock:(void(^)())theBlock{
    _reTestRequest=YES;
    [self requestTestResultAndBlock:^{
        _reTestRequest=NO;
        if (theBlock) {
            theBlock();
        }
    }];
}
@end
