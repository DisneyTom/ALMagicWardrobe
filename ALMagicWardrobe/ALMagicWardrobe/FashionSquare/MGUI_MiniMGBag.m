//
//  MGUI_MiniMGBag.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/24.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUI_MiniMGBag.h"
#import "DataRequest.h"
#import "ALLoginUserManager.h"
#import "MBGlobalCore.h"
#import "ALLoginViewController.h"
#import "ALLine.h"

@interface MGUI_MiniMGBag()<UIAlertViewDelegate>

@end

@implementation MGUI_MiniMGBag
{
    UILabel*    lbl_TagMg;
    UILabel*    lbl_TagMini;
    UIScrollView*   scrollView_Mini;
    ALButton * btn_Sq;
    //NSString*   isBuy;
    NSString*  isMini;
    UIView* view_Succ;
    UILabel* lbl_ZN;
    
    UIButton* btn_Cancel;
    UIButton* btn_Decide;
    UIView* view_Middle;
    UIView* view_Pop;
    UIView* view_Alert;
    UILabel* lbl_AlertPrompt;
}
-(void)reload
{
    view_Succ.hidden = true;
    lbl_ZN.hidden = true;
    if ([[ALLoginUserManager sharedInstance] loginCheck])
    {
        
        [[ALLoginUserManager sharedInstance] getUserInfo:filterStr([[ALLoginUserManager sharedInstance] getUserId])
                                                 andBack:^(ALUserDetailModel *theUserDetailInfo) {
                                                     if (self.theBlockMove) {
                                                         self.theBlockMove();
                                                     }
                                                     [self _loadIsBuyDataAndBlock:^{
                                                         lbl_TagMg.frame = CGRectMake(10, 15, self.bounds.size.width - 20, 200);
                                                         NSLog(@"---------isBuy%@",self.isBuy);
                                                         if ([self.isBuy isEqualToString:@"Y"])
                                                         {
                                                             lbl_ZN.hidden = false;
                                                             lbl_TagMini.hidden = true;
                                                             lbl_TagMg.hidden = false;
                                                             btn_Sq.hidden = true;
                                                             lbl_TagMg.text = @"你已经是魔法衣橱的正式会员了。快去挑选喜爱的衣服加入衣橱，然后申请魔法包吧！";
                                                             [lbl_TagMg sizeToFit];
                                                             NSString* stringZN = @"i 魔法包是什么？\n"
                                                             "魔法包是我们为付费用户提供服务的载体。用户购买魔法衣橱的月租服务后，即可在服务期内不断申请和更换新的魔法包。\n\n"
                                                             "魔法包服务包含：使用线上所有服装、免费清洗服装、魔法包快递。\n\n"
                                                             "用户在服务期内，可以不限次数领取魔法包，而且每次魔法包的使用时间也不设上限。\n\n"
                                                             "每个魔法包内有三件不一样的服装，服装来自于用户的魔法衣橱。如果用户将某款服装添加到衣橱时选择了颜色和尺码，那么进入魔法包时遵从用户选择；如果用户将某款服装添加到衣橱时没有选择颜色和尺码，那么我们的搭配师会综合考虑尺码大小、颜色匹配等条件，来为用户推荐，然后装入魔法包\n\n"
                                                             @"ii 魔法值是什么？有什么用？\n"
                                                             "魔法值是让会员获得魔法衣橱更好服务的计算方法。如果你经常使用和支持我们，魔法值会不断增长，魔法值增长会让你晋升为更高级别的会员，得到当季美衣等贴心礼物。\n\n"
                                                             "而损毁服装或不能按时归还等失信行为则会让魔法值减少，一旦魔法值减少到一定负值，将会影响下一次购买服务的价格，或者不能继续使用我们的服务。\n\n"
                                                             "关于魔法值的计算方法详情请参照【魔法值规则】。\n\n"
                                                             @"iii 如何获得魔法包？\n"
                                                             "所有用户都能通过下载APP免费使用“魔法衣橱”，如果要获得“魔法包”线下服务，则需要进入“我的钱包”里购买，购买成功成为月费会员后，就能收到魔法衣橱寄出的魔法包了。\n\n"
                                                             @"iv 我喜欢这件衣服能够购买吗？\n"
                                                             "魔法衣橱暂时不能提供销售服务。\n\n"
                                                             @"v 魔法包中的3件衣服，我可以指定发送吗？\n"
                                                             "我们会从用户的个人魔法衣橱内匹配服装，装入魔法包，但用户不能指定某件服装。\n\n"
                                                             @"vi 衣服弄脏了或者损毁了怎么办？\n"
                                                             "弄脏或者损毁服装，将会让魔法值降低，当魔法值降低到一定程度时就会影响下次购买服务的价格了，甚至不能再继续使用我们的服务。\n\n"
                                                             "关于魔法值的计算方法详情请参照【魔法值规则】。\n\n"
                                                             @"vii 我购买了魔法包月租服务后，什么时候能够收到货？\n"
                                                             "收货：用户确认收货地址后后台和搭配师开始匹配服装，三天内用户收到魔法包；退货：用户确认取货地址后，次日快递收货。\n\n"
                                                             @"viii 当我下单还衣服之后，新的魔法包就会寄出来了吗？\n"
                                                             "用户点选归还魔法包后，系统会与用户确认取货地址。我们收到用户的服装后系统自动进入下一轮发货。\n\n"
                                                             @"ix 如何查看我的魔法包到哪了？\n"
                                                             "在APP上查看“魔法包”，就能查看当前的魔法包状态。\n\n"
                                                             @"x 没有及时更新我的魔法衣橱，会不会发来我已经不喜欢的款式？\n"
                                                             "有可能，装入魔法包的服装，是从用户魔法衣橱中搭配选择。因此建议用户要经常更新魔法衣橱，这样每次都能收到当下最喜欢的衣服了。\n\n"
                                                             @"xi 送来的衣服不合身怎么办？\n"
                                                             "将服装加入魔法包时，会首先按照用户选择的尺码匹配，如果用户没有在加入衣橱时选择尺码，那么会匹配用户常规尺码。Tips：①在添加服装时都尽量选好尺寸；②在着装测试里填写个人常穿的准确尺码。\n\n"
                                                             @"xii 寄给我的衣服拿到手就有破损或者污渍怎么办？\n"
                                                             "所有寄给用户的服装，我们都会进行严格的清洗和消毒处理，万一用户收到了破损或污渍的服装，请在第一时间登录APP或者网站联系客服，确认属实后我们会为用户延长相应服务期时间。\n\n"
                                                             @"xiii 手机或账户丢失怎么办？\n"
                                                             "在移动互联网普及的今天，请一定保护好手机或PAD之类存有个人信息的终端设备。一旦发现手机或者账户丢失，请立即联系客服，我们会马上为你锁掉账户。\n\n"
                                                             @"xiv 有更多问题？\n"
                                                             "请发送邮件至 mfyc_public@163.com，我们非常期待您的反馈。"
                                                             ;
                                                             
                                                             NSMutableAttributedString *aString_MgTag=[[NSMutableAttributedString alloc] initWithString:stringZN];
                                                             NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                                                             NSMutableParagraphStyle *paragraphStyleT = [[NSMutableParagraphStyle alloc]init];
                                                             [paragraphStyle setLineSpacing:2];
                                                             [paragraphStyleT setLineSpacing:6];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, stringZN.length)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(0,10)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, 9)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(273,15)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(273,15)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(460,13)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(460,13)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(557,17)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(557,17)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(593,22)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(593,22)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(654,17)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(654,17)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(759,27)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(759,27)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(845,28)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(845,28)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(922,16)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(922,16)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(967,30)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(967,30)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(1061,15)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(1061,15)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(1172,26)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(1172,26)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(1284,16)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(1284,16)];
                                                             [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(1374,10)];
                                                             [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(1374,10)];
                                                             lbl_ZN.attributedText = aString_MgTag;
                                                             [lbl_ZN sizeToFit];
                                                             lbl_ZN.frame = CGRectMake(10, lbl_TagMg.bottom + 20, lbl_ZN.width, lbl_ZN.height);

                                                             scrollView_Mini.contentSize = CGSizeMake(kScreenWidth, lbl_ZN.bottom + 10);
                                                         }
                                                         else
                                                         {
                                                             lbl_ZN.hidden = true;
                                                             [self _loadIsMiniDataAndBlock:^{
                                                                 if ([isMini isEqualToString:@"Y"])
                                                                 {
                                                                     view_Succ.hidden = false;
                                                                     lbl_TagMini.hidden = true;
                                                                     lbl_TagMg.hidden = true;
                                                                     btn_Sq.hidden = true;
                                                                     
                                                                     NSString* string_Succ = @"\n\n\n                        MINI魔法包申请成功！\n\n\n\n亲快去挑选喜爱的衣服吧~在衣橱中满20件以上，就可以在“魔法包”页面申请MINI魔法包了哦~！\n\n\n\n记得也要向朋友安利一下魔法衣橱！让她们也快来领取免费魔法包！免费穿漂亮衣服！";
                                                                     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                                                                     [paragraphStyle setLineSpacing:3];
                                                                     NSMutableAttributedString *aString_Succ =[[NSMutableAttributedString alloc] initWithString:string_Succ];
                                                                     [aString_Succ addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string_Succ.length)];
                                                                     [aString_Succ addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(27, 12)];
                                                                     lbl_TagMg.attributedText = aString_Succ;
                                                                     [lbl_TagMg sizeToFit];
                                                                     
                                                                     scrollView_Mini.contentSize = CGSizeMake(kScreenWidth, lbl_TagMg.bottom);
                                                                 }
                                                                 else
                                                                 {
                                                                     lbl_TagMini.hidden = false;
                                                                     lbl_TagMg.hidden = false;
                                                                     btn_Sq.hidden = false;
                                                                     
                                                                     NSString* string_MgTag = @"魔法包是什么：\n\n用户购买魔法衣橱的服务后，即可在服务期内不限次数、不断申请和更换新的魔法包。每个魔法包有3件不同的衣服。\n\n在“我的衣橱”中添加20件你喜爱的衣服，然后小魔就会从衣橱中施展魔法，挑选出3件寄送给你使用。";
                                                                     NSMutableAttributedString *aString_MgTag=[[NSMutableAttributedString alloc] initWithString:string_MgTag];
                                                                     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                                                                     [paragraphStyle setLineSpacing:3];
                                                                     [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string_MgTag.length)];
                                                                     [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, 7)];
                                                                     lbl_TagMg.attributedText = aString_MgTag;
                                                                     [lbl_TagMg sizeToFit];
                                                                     NSString* string_MiniTag = @"不买衣服随便穿的感觉有多好？总要试过才知道！\n\n对跃跃欲试的准会员，魔法衣橱推出为期1周的魔法包体验服务，同样三件新款美衣，同样免费清洗。欢迎新鲜的你来试试。\n\n仅限北京地区用户，赶快领取吧！";
                                                                     NSMutableAttributedString *aString_miniTag=[[NSMutableAttributedString alloc] initWithString:string_MiniTag];
                                                                     [aString_miniTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string_MiniTag.length)];
                                                                     lbl_TagMini.attributedText = aString_miniTag;
                                                                     lbl_TagMini.frame = CGRectMake(10, lbl_TagMg.bottom + 30, self.bounds.size.width - 20, 200);
                                                                     [lbl_TagMini sizeToFit];
                                                                     [btn_Sq setFrame:CGRectMake(40,lbl_TagMini.bottom+40, 240, 30)];
                                                                     scrollView_Mini.contentSize = CGSizeMake(kScreenWidth, btn_Sq.bottom + 20);
                                                                 }
                                                                 
                                                             }];
                    
                                                         }
                                                     }];
                                                 } andReLoad:YES];
    }
    else
    {
        lbl_ZN.hidden = true;
        lbl_TagMini.hidden = false;
        lbl_TagMg.hidden = false;
        btn_Sq.hidden = false;
         lbl_TagMg.frame = CGRectMake(10, 15, self.bounds.size.width - 20, 200);
        NSString* string_MgTag = @"魔法包是什么：\n\n用户购买魔法衣橱的服务后，即可在服务期内不限次数、不断申请和更换新的魔法包。每个魔法包有3件不同的衣服。\n\n在“我的衣橱”中添加20件你喜爱的衣服，然后小魔就会从衣橱中施展魔法，挑选出3件寄送给你使用。";
        NSMutableAttributedString *aString_MgTag=[[NSMutableAttributedString alloc] initWithString:string_MgTag];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:3];
        [aString_MgTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string_MgTag.length)];
        [aString_MgTag addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, 7)];
        lbl_TagMg.attributedText = aString_MgTag;
        [lbl_TagMg sizeToFit];
        NSString* string_MiniTag = @"不买衣服随便穿的感觉有多好？总要试过才知道！\n\n对跃跃欲试的准会员，魔法衣橱推出为期1周的魔法包体验服务，同样三件新款美衣，同样免费清洗。欢迎新鲜的你来试试。\n\n仅限北京地区用户，赶快领取吧！";
        NSMutableAttributedString *aString_miniTag=[[NSMutableAttributedString alloc] initWithString:string_MiniTag];
        [aString_miniTag addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string_MiniTag.length)];

        lbl_TagMini.attributedText = aString_miniTag;
        lbl_TagMini.frame = CGRectMake(10, lbl_TagMg.bottom + 30, self.bounds.size.width - 20, 200);
        [lbl_TagMini sizeToFit];
        [btn_Sq setFrame:CGRectMake(40,lbl_TagMini.bottom+40, 240, 30)];
        scrollView_Mini.contentSize = CGSizeMake(kScreenWidth, btn_Sq.bottom + 20);
    }
}

-(void)create
{
    ALImageView *imgView=[[ALImageView alloc]
                          initWithFrame:CGRectMake(35/2,
                                                   82/2,
                                                   kScreenWidth-35/2-35/2,
                                                   620/2)];
    [imgView setImage:[ALImage imageNamed:@"finish_bg"]];
    [view_Succ addSubview:imgView];
    
    ALLabel *titLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(54/2, 40, imgView.width-54/2*2, 20)
                     andColor:AL_RGB(124,84,1)
                     andFontNum:13];
    [titLbl setText:@"试用魔法包申请成功!"];
    [titLbl setFont:[UIFont systemFontOfSize:13]];
    [titLbl setTextColor:colorByStr(@"#9B7D56")];
    
    [imgView addSubview:titLbl];
    
    
    ALImageView *lineImgView=[[ALImageView alloc]
                              initWithFrame:CGRectMake(0,
                                                       164/2,
                                                       imgView.width,
                                                       6)];
    [lineImgView setImage:[ALImage imageNamed:@"halving_line"]];
    [imgView addSubview:lineImgView];
    
    NSArray *arr=@[
                   @"亲快去挑选喜爱的衣服吧~",
                   @"在衣橱中满20件以上，就可以在“魔法包”页面中申请魔法包了哦~！",
                   @"记得也要向朋友安利一下魔法衣橱！",
                   @"",
                   @"让她们也快来领取试用魔法包！免费穿漂亮衣服!",
                   ];
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSUInteger index = idx;
        if (idx > 2)
        {
            index = index - 1;
        }
        CGFloat space = 5.f;
        if (idx != 3)
        {
            space = 1.f;
        }
        ALLabel *lbl=[[ALLabel alloc]
                      initWithFrame:CGRectMake(30, lineImgView.bottom+30*index+space*index, imgView.width - 60, 50)];
        lbl.text = obj;
        [lbl setFont:[UIFont systemFontOfSize:11]];
        [lbl setNumberOfLines:0];
        [lbl setTextColor:AL_RGB(64, 64, 64)];
        [imgView addSubview:lbl];
        
    }];
    
    ALLine *line=[[ALLine alloc]
                  initWithFrame:CGRectMake(0, 504/2, imgView.width, 1)];
    [imgView addSubview:line];
    
    ALLabel *bottomLbl=[[ALLabel alloc]
                        initWithFrame:CGRectMake(30,
                                                 line.bottom+5,
                                                 imgView.width - 30,
                                                 30)
                        andColor:[UIColor grayColor]
                        andFontNum:12];
    [bottomLbl setText:@"加入魔法衣橱，免费试用免费穿衣"];
    [bottomLbl setTextAlignment:NSTextAlignmentLeft];
    [imgView addSubview:bottomLbl];
    
    

    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    scrollView_Mini = [[UIScrollView alloc]init];
    scrollView_Mini.frame = self.bounds;
    
    view_Succ = [[UIView alloc]init];
    view_Succ.hidden = true;
    view_Succ.frame = self.bounds;
    [self create];
   
    lbl_ZN = [[UILabel alloc]init];
    lbl_ZN.numberOfLines = 0;
    lbl_ZN.font  = [UIFont systemFontOfSize:12];
    lbl_ZN.textColor = [UIColor grayColor];
    lbl_ZN.frame = CGRectMake(10, 10, kScreenWidth - 20, 100);
    
    lbl_TagMg = [[UILabel alloc]init];
    lbl_TagMg.numberOfLines = 0;
    
    lbl_TagMg.font = [UIFont systemFontOfSize:12];
    lbl_TagMg.textColor = [UIColor grayColor];
    
    lbl_TagMini = [[UILabel alloc]init];
    lbl_TagMini.numberOfLines = 0;
    lbl_TagMini.textColor = [UIColor grayColor];
    lbl_TagMini.font = [UIFont systemFontOfSize:12];
    
    btn_Sq =[ALButton buttonWithType:UIButtonTypeCustom];
    [btn_Sq setBackgroundImage:[ALImage imageNamed:@"btn_magic_room"] forState:UIControlStateNormal];
    btn_Sq.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn_Sq setTitle:@"申请试用魔法包"
            forState:UIControlStateNormal];
    __block MGUI_MiniMGBag* thBlock = self;
    [btn_Sq setTheBtnClickBlock:^(id sender){
        if([[ALLoginUserManager sharedInstance] loginCheck])
        {
            lbl_AlertPrompt.text = @"亲,小魔目前只能在北京范围内提供服务哦~您是否是北京地区的用户呢?";
            [lbl_AlertPrompt sizeToFit];
            lbl_AlertPrompt.frame = CGRectMake(20, (100 -lbl_AlertPrompt.height)/2, lbl_AlertPrompt.width, lbl_AlertPrompt.height);
            view_Pop.hidden = false;
            view_Middle.hidden = false;
            [btn_Cancel setTitle:@"我不在北京" forState:UIControlStateNormal];
            btn_Decide.frame = CGRectMake((kScreenWidth - 40)/2,100, (kScreenWidth - 40)/2, 40);
            btn_Cancel.frame = CGRectMake(0,  100, (kScreenWidth - 40)/2, 40);
            [btn_Decide setTitle:@"我在北京" forState:UIControlStateNormal];
        }
        else
        {
            if (thBlock.theBlock)
            {
                thBlock.theBlock();
            }
        }
    }];
    
    [self createAlert];
    [self addSubview:scrollView_Mini];
    [scrollView_Mini addSubview:btn_Sq];
    [scrollView_Mini addSubview:lbl_TagMg];
    [scrollView_Mini addSubview:lbl_TagMini];
    [scrollView_Mini addSubview:lbl_ZN];
    [self reload];
     [scrollView_Mini addSubview:view_Succ];
    return self;
}

-(void)createAlert
{
    btn_Cancel = [[UIButton alloc]init];
    [btn_Cancel setTitle:@"我不在北京" forState:UIControlStateNormal];
    [btn_Cancel setTitleColor:[UIColor blueColor] forState:0];
    btn_Cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    btn_Cancel.layer.cornerRadius = 5;
    btn_Cancel.backgroundColor = colorByStr(@"#xa2a2a2");
    [btn_Cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [btn_Cancel setTitleColor:ALUIColorFromHex(0xa07845) forState:UIControlStateNormal];
    btn_Decide = [[UIButton alloc]init];
    [btn_Decide setTitleColor:ALUIColorFromHex(0xa07845) forState:UIControlStateNormal];
    btn_Decide.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn_Decide addTarget:self action:@selector(decide) forControlEvents:UIControlEventTouchUpInside];
    [btn_Decide setTitle:@"我在北京" forState:UIControlStateNormal];
    UIView* view_line = [[UIView alloc]init];
    view_line.backgroundColor = ALUIColorFromHex(0xa07845);
    view_Middle = [[UIView alloc]init];
    view_Middle.backgroundColor = ALUIColorFromHex(0xa07845);
    btn_Decide.layer.cornerRadius = 5;
    btn_Decide.backgroundColor = colorByStr(@"x25b6ed");
    view_Pop = [[UIView alloc]init];
    view_Pop.backgroundColor = [UIColor colorWithRed:144/255 green:144/255 blue:144/255 alpha:0.5];
    view_Pop.hidden = true;
    view_Alert = [[UIView alloc]init];
    view_Alert.clipsToBounds = true;
    view_Alert.layer.cornerRadius = 5;
    view_Alert.backgroundColor = [UIColor whiteColor];
    lbl_AlertPrompt = [[UILabel alloc]init];
    lbl_AlertPrompt.textColor = [UIColor blackColor];
    lbl_AlertPrompt.font = [UIFont systemFontOfSize:14];
    lbl_AlertPrompt.numberOfLines = 0;
    lbl_AlertPrompt.textAlignment = NSTextAlignmentCenter;
    [view_Alert addSubview:lbl_AlertPrompt];
    [view_Pop addSubview:view_Alert];
    [view_Alert addSubview:btn_Cancel];
    [view_Alert addSubview:btn_Decide];
    [view_Alert addSubview:view_line];
    [view_Alert addSubview:view_Middle];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication].windows lastObject];
    [keyWindow addSubview:view_Pop];
    view_Pop.frame =  CGRectMake(0, 0,kScreenWidth, kScreenHeight);
    view_Alert.frame = CGRectMake(20,(kScreenHeight - 160 )/2 ,kScreenWidth - 40, 140);
    lbl_AlertPrompt.frame = CGRectMake( 20, 0,kScreenWidth - 40 - 40 , 100);
    view_line.frame = CGRectMake(0, 100, kScreenWidth - 40, 0.5);
    view_Middle.frame = CGRectMake((kScreenWidth - 40)/2,100,0.5,40);
}

-(void)decide
{
    view_Pop.hidden = true;
    if (![lbl_AlertPrompt.text isEqualToString:@"对不起,目前仅为北京用户提供服务."])
    {
        [self _loadApplyMiniDataAndBlock:^{
            
            
        }];
    }
}
-(void)cancel
{
    view_Middle.hidden = true;
    lbl_AlertPrompt.text = @"对不起,目前仅为北京用户提供服务.";
    btn_Decide.frame = CGRectMake(0,  100, kScreenWidth - 40, 40);
    [btn_Decide setTitle:@"确定" forState:UIControlStateNormal];
}


-(void)_loadApplyMiniDataAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    
    [DataRequest requestApiName:@"magicBag_ApplyMini" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
        if([MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"])
        {
            [self reload];
        }
        
        if (theBlock) {
            theBlock();
        }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}



-(void)_loadIsBuyDataAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    
    [DataRequest requestApiName:@"magicBag_IsBuy" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
        
        self.isBuy = sucContent[@"body"][@"result"];
        if (theBlock) {
            theBlock();
        }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}

-(void)_loadIsMiniDataAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    
    [DataRequest requestApiName:@"magicBag_IsMini" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
        isMini = sucContent[@"body"][@"result"];
        if (theBlock) {
            theBlock();
        }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}

@end
