		//
//  ALMagicBagBuyViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-22.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicBagBuyViewController.h"
#import "ALMagicBagBuyCell.h"
#import "ALLine.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlipyInfo.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "WXUtil.h"
#import "payRequsestHandler.h"
#import "MBCorePreprocessorMacros.h"
#import "AppDelegate.h"
#import "NSDateUtilities.h"
#import "MGUICtrl_OutsideAddress.h"


@interface ALMagicBagBuyViewController ()
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@end

@implementation ALMagicBagBuyViewController{
    BOOL _isFirstBuyBool; //是否第一次购买
    NSArray *_listMagicBags;
    ALTableView *_magicBagTableView;
    NSMutableArray *_selMulArr;
    NSInteger _payIndex;  //默认 0 微信   1  支付宝
    NSMutableArray *_payBtnArr;
    ALLabel *totalPriceLbl;
    ALLabel *note2Lbl;
    UILabel *noteLbl;
    NSDictionary *theMagicDic;
    UIView* view_Foot;
    UIView* view_Line;
    UILabel* lbl_Foot;
    UIButton* btn_ChooseDay;
    UIView*   view_Choose;
    NSString* string_BuyDays;
    NSString* string_BygMenuId;
    UILabel*    lbl_Tag;
    NSDictionary* zf;
    NSString* string_OrderName;
    
    
    
    UIButton* btn_Cancel;
    UIButton* btn_Decide;
    UIView* view_Middle;
    UIView* view_Pop;
    UIView* view_Alert;
    UILabel* lbl_AlertPrompt;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"购买魔法包"];
    
    [self _initData];
    
    [self _initView];
    string_BuyDays = @"30";
    [self _loadDataMagicBagGetBuyAndBlock:string_BygMenuId BuyDays:string_BuyDays andBackBlock:^{
       
      [_magicBagTableView reloadData];
    }];
    
    
//    [self _loadDataMagicBagGetMagicMenuAndBlock:^{
//        [_magicBagTableView reloadData];
//        [self _selectMagicMenu:_listMagicBags[0][@"id"] andBackBlock:^{
//        }];
//    }];
}

-(void)_initData{
    _isFirstBuyBool=YES;
    _selMulArr=[[NSMutableArray alloc] initWithCapacity:2];
    [_selMulArr addObject:@(0)];  //默认为 0  微信支付
    _payIndex=0;  //默认为0 微信支付
    _payBtnArr=[[NSMutableArray alloc] initWithCapacity:2];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuc:) name:WXPAYSUCNOTI object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuc:) name:ALIPAYSUCNOTI object:nil];
}
-(void)paySuc:(NSNotification *)noti{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)_initView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    lbl_Tag = [[UILabel alloc]init];
    lbl_Tag.backgroundColor = [UIColor clearColor];
    lbl_Tag.font = [UIFont systemFontOfSize:15];
    lbl_Tag.text = @"  请选择购买单价";
    lbl_Tag.textColor = colorByStr(@"#a07845");
    [self.contentView addSubview:lbl_Tag];
    lbl_Tag.frame = CGRectMake(0, 0, kScreenWidth, 30);
    _magicBagTableView=[[ALTableView alloc]
                        initWithFrame:CGRectMake(0, 30, kScreenWidth, 240/4*2)];
    [_magicBagTableView setDataSource:self];
    [_magicBagTableView setDelegate:self];
    [_magicBagTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _magicBagTableView.scrollEnabled = false;
    [self.contentView addSubview:_magicBagTableView];
    view_Foot = [[UIView alloc]init];
    view_Foot.backgroundColor = [UIColor clearColor];
    view_Foot.frame = CGRectMake(0, _magicBagTableView.bottom, kScreenWidth, 80);
    view_Line = [[UIView alloc]init];
    view_Line.backgroundColor = colorByStr(@"#a07845");
    view_Line.frame = CGRectMake(0, 80 - .5f, kScreenWidth, .5f);
    lbl_Foot = [[UILabel alloc]init];
    lbl_Foot.text = @"选择购买时间";
    lbl_Foot.font = [UIFont systemFontOfSize:15];
    lbl_Foot.frame = CGRectMake(20,30, 100, 20);
    lbl_Foot.textColor = colorByStr(@"#a07845");
    lbl_Foot.backgroundColor = [UIColor clearColor];
    [lbl_Foot sizeToFit];
    btn_ChooseDay = [[UIButton alloc]init];
    [btn_ChooseDay setTitle:@"    30天" forState:0];
    [btn_ChooseDay setTitleColor:colorByStr(@"#4b4b4b") forState:0];
    btn_ChooseDay.titleLabel.font = [UIFont systemFontOfSize:15];
    btn_ChooseDay.frame = CGRectMake(lbl_Foot.left + lbl_Foot.width + 20,(80 - 30)/2 , (kScreenWidth - 40 - 20 - 100), 30);
    btn_ChooseDay.layer.borderColor = AL_RGB(210,204,188).CGColor;
    btn_ChooseDay.layer.borderWidth = 1;
    btn_ChooseDay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn_ChooseDay addTarget:self action:@selector(chooseDay:) forControlEvents:UIControlEventTouchUpInside];
  //  btn_ChooseDay.layer.shadowColor = [UIColor redColor].CGColor;
  //  btn_ChooseDay.layer.shadowOffset = CGSizeZero;
   // btn_ChooseDay.layer.shadowOpacity = 0;
    UIImageView* imgView_Ch = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_chosen"]];
    [btn_ChooseDay addSubview:imgView_Ch];
    imgView_Ch.frame = CGRectMake(btn_ChooseDay.width - 30,0 , 30, 30);
    [view_Foot addSubview:btn_ChooseDay];
    [view_Foot addSubview:lbl_Foot];
    [view_Foot addSubview:view_Line];
    [self.contentView addSubview:view_Foot];
    noteLbl = [[UILabel alloc]init];
    noteLbl.font = [UIFont systemFontOfSize:10];
    noteLbl.frame = CGRectMake(25,view_Foot.bottom,kScreenWidth-50,60);
    noteLbl.textColor = colorByStr(@"#A3A3A3");
    [noteLbl setNumberOfLines:0];
    [self.contentView addSubview:noteLbl];
    //colorByStr(@"#a07845")
    ALLine *line=[[ALLine alloc]
                  initWithFrame:CGRectMake(0, noteLbl.bottom, kScreenWidth, .5f)];
//    line.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:line];
    
    __block ALButton * _selLeftBtn;
    ALButton *leftBuyBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [leftBuyBtn setFrame:CGRectMake(40,
                                    line.bottom+12,
                                    100,
                                    44)];
    [leftBuyBtn setBackgroundImage:[ALImage imageNamed:@"weixin_bg"] forState:UIControlStateNormal];
    [leftBuyBtn setTheBtnClickBlock:^(id sender){
        [self selBtn:_selLeftBtn];
    }];
    [self.contentView addSubview:leftBuyBtn];
    
    _selLeftBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [_selLeftBtn setFrame:CGRectMake(leftBuyBtn.width-20-5,
                                     (leftBuyBtn.height-20)/2, 20, 20)];
    [_selLeftBtn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
    [_selLeftBtn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
    [_selLeftBtn setTag:1111];
    [_selLeftBtn setSelected:YES];
    [_selLeftBtn setTheBtnClickBlock:^(id sender){
        [self selBtn:sender];
    }];
    [leftBuyBtn addSubview:_selLeftBtn];
    [_payBtnArr addObject:_selLeftBtn];
    
    __block ALButton * _selRightBtn;
    ALButton *rightBuyBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [rightBuyBtn setFrame:CGRectMake(leftBuyBtn.right+40, leftBuyBtn.top, 100, 44)];
    [rightBuyBtn setBackgroundImage:[ALImage imageNamed:@"zhifubao_bg"] forState:UIControlStateNormal];
    [rightBuyBtn setTheBtnClickBlock:^(id sender){
        [self selBtn:_selRightBtn];
    }];
    [self.contentView addSubview:rightBuyBtn];
    
    _selRightBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [_selRightBtn setFrame:CGRectMake(rightBuyBtn.width-20-5, (rightBuyBtn.height-20)/2, 20, 20)];
    [_selRightBtn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
    [_selRightBtn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
    [_selRightBtn setTag:2222];
    [_selRightBtn setTheBtnClickBlock:^(id sender){
        [self selBtn:sender];
    }];
    [rightBuyBtn addSubview:_selRightBtn];
    [_payBtnArr addObject:_selRightBtn];
    
    totalPriceLbl=[[ALLabel alloc]
                            initWithFrame:CGRectMake(
                                                     leftBuyBtn.left - 20,
                                                     rightBuyBtn.bottom+10,
                                                     kScreenWidth-leftBuyBtn.left,
                                                     30)
                            andColor:colorByStr(@"#676767")
                            andFontNum:14];
    [self.contentView addSubview:totalPriceLbl];
    
    note2Lbl=[[ALLabel alloc]
                       initWithFrame:CGRectMake(
                                                totalPriceLbl.left,
                                                totalPriceLbl.bottom,
                                                totalPriceLbl.width,
                                                totalPriceLbl.height)
                       andColor:colorByStr(@"#676767")
                       andFontNum:14];
    [self.contentView addSubview:note2Lbl];
    
    ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake((kScreenWidth-470/2)/2,
                               note2Lbl.bottom+10, 470/2, 60/2)];
    [okBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg.png"]
                     forState:UIControlStateNormal];
    [okBtn setTitle:@"去付款" forState:UIControlStateNormal];
//      AppDelegate *theDelegate = [[UIApplication sharedApplication] delegate];
    [okBtn setTheBtnClickBlock:^(id sender){
 
        float price = [theMagicDic[@"totalMagicValue"] floatValue];
        if (price < -10000)
        {
            NSString *content = [NSString stringWithFormat:@"当前魔法值%@，抱歉我们不能再提供服务",theMagicDic[@"totalMagicValue"]];
            showWarn(content);
            return;
        }
        
        [self _loadDataMagicBagIsFirstBuyAndBlock:^{
            if (_isFirstBuyBool)
            { //第一次购买
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
            { //不是第一次购买
                [self _payBeforeAndBlock:^{
                    
                }];
            }
        }];
    }];
    
    view_Choose = [[UIView alloc]init];
    view_Choose.layer.cornerRadius = 3;
    view_Choose.backgroundColor = [UIColor whiteColor];
    view_Choose.layer.borderColor = AL_RGB(210,204,188).CGColor;
    view_Choose.layer.borderWidth = .4f;

    view_Choose.frame = CGRectMake(btn_ChooseDay.left,_magicBagTableView.bottom - 40, btn_ChooseDay.width, 180);
    view_Choose.hidden = true;
    for (int i = 0; i< 6; i++)
    {
        UIButton* btn = [[UIButton alloc]init];
        btn.tag = i*30 + 30;
        [btn addTarget:self action:@selector(chooseDay:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[NSString stringWithFormat:@"        %d天",i*30 + 30 ]forState:0];
        btn.frame = CGRectMake(0, i*30, btn_ChooseDay.width, 30);
        [btn setTitleColor:colorByStr(@"#4b4b4b") forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
         btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [view_Choose addSubview:btn];
    }
    [self.contentView addSubview:view_Choose];
    [self.contentView addSubview:okBtn];
    [self createAlert];
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
    [self _payBeforeAndBlock:^{
        
    }];
}
-(void)cancel
{
    view_Pop.hidden = true;
     [self.navigationController pushViewController:[[MGUICtrl_OutsideAddress alloc] init] animated:true];
}

-(void)selBtn:(ALButton *)btn{
    [_payBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALButton *theBtn=obj;
        if (theBtn.tag==btn.tag) {
            [theBtn setSelected:YES];
        }else{
            [theBtn setSelected:NO];
        }
        if (btn.tag==1111) {
            _payIndex=0;
        }else{
            _payIndex=1;
        }
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {//是
     
    }
    else
    {//否
        
      
    }
}

#pragma mark tableVie Deleagate DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listMagicBags.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *magicBagBuyIdentify=@"magicBagBuyIdentify";
    ALMagicBagBuyCell *theCell=(ALMagicBagBuyCell *)[tableView dequeueReusableCellWithIdentifier:magicBagBuyIdentify];
    if (theCell==nil) {
        theCell=[[ALMagicBagBuyCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:magicBagBuyIdentify];
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    theCell.index = indexPath.row;
    theCell.cellIndexBlock = ^(NSInteger index)
    {
        [self btnClick:index];
    };
    [theCell setDic:_listMagicBags[indexPath.row]];
    [_selMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj integerValue]==indexPath.row) {
            [theCell selBuy:YES];
        }else{
            [theCell selBuy:NO];
        }
    }];
    return theCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return magicBagBuyCellHight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self btnClick:indexPath.row];
}

#pragma mark btnCLick
#pragma mark
-(void)chooseDay:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    if (btn == btn_ChooseDay)
    {
        view_Choose.hidden = false;
    }
    else
    {
        string_BuyDays = [NSString stringWithFormat:@"%ld",(long)btn.tag];
        [btn_ChooseDay setTitle:[NSString stringWithFormat:@"    %ld天",(long)btn.tag] forState:0];
        view_Choose.hidden = true;
        [self _loadDataMagicBagGetBuyAndBlock:string_BygMenuId BuyDays:string_BuyDays andBackBlock:^{
            [_magicBagTableView reloadData];
        }];
    }
}

- (void)btnClick:(NSInteger)index
{
    if (index < _listMagicBags.count)
    {
        string_BygMenuId = _listMagicBags[index][@"id"];
        [self _loadDataMagicBagGetBuyAndBlock:string_BygMenuId BuyDays:string_BuyDays andBackBlock:^{
            [_selMulArr removeAllObjects];
            [_selMulArr addObject:@(index)];
            [_magicBagTableView reloadData];
        }];
//        [self _selectMagicMenu:_listMagicBags[index][@"id"]
//                  andBackBlock:^{
//                      [_selMulArr removeAllObjects];
//                      [_selMulArr addObject:@(index)];
//                      
//                      [_magicBagTableView reloadData];
//                  }];
    }

}

#pragma mark loadData
#pragma mark -
#pragma mark 新接口
-(void)_loadDataMagicBagGetBuyAndBlock:(NSString *)menuId BuyDays:(NSString*)days andBackBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"menuId":filterStr(menuId),
                            @"buyDays":days
                            };
    [DataRequest requestApiName:@"magicBag_BuyDate" andParams:sendDic andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       _listMagicBags=sucContent[@"body"][@"result"][@"menus"];
                       
                       [totalPriceLbl setText:[NSString stringWithFormat:@"本次支付：%@元",[_listMagicBags[0][@"price"] stringValue]] ];
                       theMagicDic=sucContent[@"body"][@"result"];
                       float price = [theMagicDic[@"totalMagicValue"] floatValue];
                       NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                       [paragraphStyle setLineSpacing:3];
                       if (price > -10000)
                       {
                           NSString *str=[NSString stringWithFormat:@"本次支付：%@元",[theMagicDic[@"price"] stringValue]];
                           NSMutableAttributedString *newStr=[[NSMutableAttributedString alloc] initWithString:str];
                           [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(str.length-[[theMagicDic[@"price"] stringValue] length]-1, [[theMagicDic[@"price"] stringValue] length])];
                           [newStr addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#977D51") range:NSMakeRange(str.length-[[theMagicDic[@"price"] stringValue] length]-1, [[theMagicDic[@"price"] stringValue] length])];
                           [totalPriceLbl setAttributedText:newStr];
                           NSString* string_P = [NSString stringWithFormat:@"当前魔法值%@，因此你的支付金额在以上套餐定价基础上上浮了%@，欲了解魔法值与价格信息，请查阅“魔法值规则”，或进入“服务指南”。",theMagicDic[@"totalMagicValue"],theMagicDic[@"ratio"]];
                           NSMutableAttributedString *string_Prompt =[[NSMutableAttributedString alloc] initWithString:string_P];
                           [string_Prompt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,string_P.length)];
                           [noteLbl setAttributedText:string_Prompt];
                       }
                       else
                       {
                           NSString *content = [NSString stringWithFormat:@"当前魔法值%@，抱歉我们不能再提供服务",theMagicDic[@"totalMagicValue"]];
                           [noteLbl setText:content];
                           NSString *str=[NSString stringWithFormat:@"本次支付：元"];
                           NSMutableAttributedString *newStr=[[NSMutableAttributedString alloc] initWithString:str];
                           [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 5)];
                           [newStr addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#977D51") range:NSMakeRange(4, newStr.length - 4)];
                           [totalPriceLbl setAttributedText:newStr];
                       }
                       NSDate *theDate= [NSDate dateWithTimeIntervalString:[theMagicDic[@"matureDate"] stringValue]];
                       
                       NSString *str2=[NSString stringWithFormat:@"支付后魔法包使用期限至%@",[theDate dateChinaString]];
                       NSMutableAttributedString *newStr2=[[NSMutableAttributedString alloc] initWithString:str2];
                       [newStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(str2.length-[[theDate dateString] length] - 1, [[theDate dateString] length])];
                       [newStr2 addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#977D51") range:NSMakeRange(str2.length-[[theDate dateString] length] - 1, [[theDate dateString] length] +1)];
                       
                       // [newStr2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,noteLbl.text.length)];
                       [note2Lbl setAttributedText:newStr2];
                       if (theBlock) {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}

#pragma mark 查询所有的魔法套餐
-(void)_loadDataMagicBagGetMagicMenuAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"magicBag_getMagicMenu" andParams:sendDic andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       _listMagicBags=sucContent[@"body"][@"result"];
                       [totalPriceLbl setText:[NSString stringWithFormat:@"本次支付：%@元",[_listMagicBags[0][@"price"] stringValue]] ];
                       
                       
                       if (theBlock) {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}
#pragma mark 选择魔法套餐
-(void)_selectMagicMenu:(NSString *)menuId andBackBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"menuId":filterStr(menuId)
                            };
    [DataRequest requestApiName:@"magicBag_selectMagicMenu"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       theMagicDic=sucContent[@"body"][@"result"];
                       float price = [theMagicDic[@"totalMagicValue"] floatValue];
                       NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                       [paragraphStyle setLineSpacing:3];
                       if (price > -10000)
                       {
                           NSString *str=[NSString stringWithFormat:@"本次支付：%@元",[theMagicDic[@"price"] stringValue]];
                           NSMutableAttributedString *newStr=[[NSMutableAttributedString alloc] initWithString:str];
                           [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(str.length-[[theMagicDic[@"price"] stringValue] length]-1, [[theMagicDic[@"price"] stringValue] length])];
                           [newStr addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#977D51") range:NSMakeRange(str.length-[[theMagicDic[@"price"] stringValue] length]-1, [[theMagicDic[@"price"] stringValue] length])];
                           [totalPriceLbl setAttributedText:newStr];
                           
                           //                       [note2Lbl setText:[NSString stringWithFormat:@"支付后魔法包使用期限至%@",[theDate dateString]]];
                           NSString* string_P = [NSString stringWithFormat:@"当前魔法值%@，因此你的支付金额在以上套餐定价基础上上浮了%@，欲了解魔法值与价格信息，请查阅“魔法值规则”，或进入“服务指南”。",theMagicDic[@"totalMagicValue"],theMagicDic[@"ratio"]];
                            NSMutableAttributedString *string_Prompt =[[NSMutableAttributedString alloc] initWithString:string_P];
                           [string_Prompt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,string_P.length)];
                           [noteLbl setAttributedText:string_Prompt];
                       }
                       else
                       {
                           NSString *content = [NSString stringWithFormat:@"当前魔法值%@，抱歉我们不能再提供服务",theMagicDic[@"totalMagicValue"]];
                           [noteLbl setText:content];
                           NSString *str=[NSString stringWithFormat:@"本次支付：元"];
                           NSMutableAttributedString *newStr=[[NSMutableAttributedString alloc] initWithString:str];
                           [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 5)];
                           [newStr addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#977D51") range:NSMakeRange(4, newStr.length - 4)];
                           [totalPriceLbl setAttributedText:newStr];
                       }
                       NSDate *theDate= [NSDate dateWithTimeIntervalString:[theMagicDic[@"matureDate"] stringValue]];
                       
                       NSString *str2=[NSString stringWithFormat:@"支付后魔法包使用期限至%@",[theDate dateChinaString]];
                       NSMutableAttributedString *newStr2=[[NSMutableAttributedString alloc] initWithString:str2];
                       [newStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(str2.length-[[theDate dateString] length] - 1, [[theDate dateString] length])];
                       [newStr2 addAttribute:NSForegroundColorAttributeName value:colorByStr(@"#977D51") range:NSMakeRange(str2.length-[[theDate dateString] length] - 1, [[theDate dateString] length] +1)];
                       
                       // [newStr2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,noteLbl.text.length)];
                       [note2Lbl setAttributedText:newStr2];
                       

                       
                       if (theBlock) {
                           theBlock();
                       }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}
#pragma mark 确认付款
-(void)_payBeforeAndBlock:(void(^)())theBlock{


    NSDictionary *dic= _listMagicBags[[_selMulArr[0] integerValue]];
    NSDictionary *sendDic=@{
                            @"menuId":filterStr(dic[@"id"]),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"payWay":_payIndex==0?@"tenpay":@"alipay",
                            @"buyDays":string_BuyDays
                            };
    [DataRequest requestApiName:@"magicBag_payBefore"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       [totalPriceLbl setText:[NSString stringWithFormat:@"本次支付：%@元",sucContent[@"body"][@"result"][@"price"]]];
                       zf = (NSDictionary*)sucContent;
                       if (_payIndex) {
                           [self payOrderFoXhifuBaoWithOrdreID:MBNonEmptyString(sucContent[@"body"][@"result"][@"out_trade_no"]) andPrice:MBNonEmptyString(sucContent[@"body"][@"result"][@"price"]) andNotifyUrl:filterStr(sucContent[@"body"][@"result"][@"notifyUrl"]) orderName:sucContent[@"body"][@"result"][@"orderName"]];
                           
                       }else{
                           [self payOrderWeiXin:sucContent[@"body"][@"result"]];
                       }
                       
                       if (theBlock) {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                      showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}

#pragma mark - 调用微信支付
-(void)payOrderWeiXin:(NSDictionary*)info{
    
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //}}}
    NSLog(@"%@",[[NSString stringWithFormat:@"%0.2f",[filterStr(info[@"price"]) floatValue]*100] componentsSeparatedByString:@"."]);
    //获取到实际调起微信支付的参数后，在app端调起支付

    float price = [[NSString stringWithFormat:@"%.2lf",[filterStr(info[@"price"]) floatValue]] floatValue]*100;
    NSMutableDictionary *dict = [req sendPay_demoWithMoney:[NSString stringWithFormat:@"%.0f",price] andorderno:info[@"out_trade_no"] andNotify_url:info[@"notifyUrl"] orderName:info[@"orderName"]];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi safeSendReq:req];
    }

    return;
    
    
    /*
    NSDictionary *sendDic=@{
                            @"out_trade_no":filterStr(info[@"out_trade_no"]),
                            @"order_price":filterStr(info[@"price"]),
                            @"product_name":filterStr(@"购买魔法值"),
                            @"notify_url":filterStr(info[@"notifyUrl"]),
                                                        };
    [DataRequest requestApiName:@"magicBag_weixinPayRequest"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       
                       if ([MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]) {
                        
                           NSDictionary *dict  = sucContent[@"body"][@"result"];
                           
                           NSString    *package, *time_stamp, *nonce_str;
                           //设置支付参数
                           time_t now;
                           time(&now);
                           time_stamp  = [NSString stringWithFormat:@"%ld", now];
                           nonce_str	= [WXUtil md5:time_stamp];
                           package         = @"Sign=WXPay";
                           //第二次签名参数列表
                           NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
                           [signParams setObject: dict[@"appid"]        forKey:@"appid"];
                           [signParams setObject: nonce_str    forKey:@"noncestr"];
                           [signParams setObject: package      forKey:@"package"];
                           [signParams setObject: dict[@"mch_id"]        forKey:@"partnerid"];
                           [signParams setObject: time_stamp   forKey:@"timestamp"];
                           [signParams setObject: dict[@"prepay_id"]     forKey:@"prepayid"];
                           //生成签名
                           NSString *sign  = [self createMd5Sign:signParams andSign:dict[@"api_key"]];
                           //添加签名
                           [signParams setObject: sign         forKey:@"sign"];
                           

                           //调起微信支付
                           PayReq* req             = [[PayReq alloc] init];
                           req.openID              = MBNonEmptyString([signParams objectForKey:@"appid"]);
                           req.partnerId           = MBNonEmptyString([signParams objectForKey:@"partnerid"]);
                           req.prepayId            = MBNonEmptyString([signParams objectForKey:@"prepayid"]);
                           req.nonceStr            = MBNonEmptyString([signParams objectForKey:@"noncestr"]);
                           req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
                           req.package             = MBNonEmptyString([signParams objectForKey:@"package"]);
                           req.sign                = MBNonEmptyString([signParams objectForKey:@"sign"]);
                           
                           [WXApi safeSendReq:req];
                       }
                   } failedBlock:^(id failContent) {
                       NSLog(@"%@",failContent);
                       
                   } reloginBlock:^(id reloginContent) {
                       
                   }];
     */
}

//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict andSign:(NSString*)sigingKey
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
    }
    //添加key字段
    [contentString appendFormat:@"key=%@",sigingKey];
    NSLog(@"%@",contentString);
    //得到MD5 sign签名
    NSString *md5Sign =[WXUtil md5:contentString];
    
    return md5Sign;
}

#pragma mark - 支付宝支付
-(void)payOrderFoXhifuBaoWithOrdreID:(NSString*)out_trade_no
                            andPrice:(NSString*)price
                        andNotifyUrl:(NSString *)notifyUrl
                           orderName:(NSString*)orderName
{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = KPartner;
    NSString *seller = KSeller;
    NSString *privateKey = KRsaPrivateKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
 
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = out_trade_no; //订单ID（由商家自行制定）
    order.productName = orderName; //商品标题
    order.productDescription = orderName; //商品描述
  
    order.amount = [NSString stringWithFormat:@"%.2lf",[price floatValue]]; //商品价格
    order.notifyURL =  notifyUrl; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString
                                  fromScheme:appScheme
                                    callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

#pragma mark 校验邀请码
-(void)_verInvitationCodeAndInvitationCode:(NSString *)invitationCode andBack:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":[[ALLoginUserManager sharedInstance] getUserId],
                            @"invitationCode":filterStr(invitationCode)
                            };
    [DataRequest requestApiName:@"magicBag_verInvitationCode"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       if (theBlock) {
                           theBlock();
                       }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    } andShowLoad:YES];
}
#pragma mark 是否第一次购买
-(void)_loadDataMagicBagIsFirstBuyAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"magicBag_isFirstBuy"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       //[@"isFirstBuy"]
                       _isFirstBuyBool=[sucContent[@"body"][@"result"] boolValue];
                       if (theBlock) {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}
@end
