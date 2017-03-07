//
//  AlServiceGuildViewController.m
//  ALMagicWardrobe
//
//  Created by wang on 3/22/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import "AlServiceGuildViewController.h"

@interface AlServiceGuildViewController ()

@end

@implementation AlServiceGuildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"服务指南";
    self.contentView.backgroundColor =  HEX(@"#efebe8");
    self.view.backgroundColor =  HEX(@"#efebe8");

    [self initWithView];
}

- (void)initWithView {
    
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
    UILabel* lbl = [[UILabel alloc]init];
    lbl.numberOfLines = 0;
    lbl.font  = [UIFont systemFontOfSize:12];
    lbl.textColor = [UIColor grayColor];
    lbl.frame = CGRectMake(10, 10, kScreenWidth - 20, 100);
    lbl.attributedText = aString_MgTag;
    [lbl sizeToFit];
    lbl.frame = CGRectMake(10, 10, lbl.width, lbl.height);
    [self.contentView addSubview:lbl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
