//
//  ALMoneyViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-14.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMoneyViewController.h"
#import "ALMagicBagCell.h"

@interface ALMoneyViewController ()
<UITableViewDataSource,UITableViewDelegate>
@end

@implementation ALMoneyViewController{
    NSMutableArray *_magicBagArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"购买魔法包"];
    
    [self _initData];
    
    [self _initView];
}

-(void)_initData{
    _magicBagArr=[[NSMutableArray alloc] initWithCapacity:2];
    
    for (int i=0; i<5; i++) {
        NSDictionary *dic=@{
                            @"img":@"",
                            @"content":@"这里是魔法包介绍之类的文字"
                            };
        [_magicBagArr addObject:dic];
    }
}
-(void)_initView{

    //
    ALTableView *magicBagBuyTableView=[[ALTableView alloc]
                                       initWithFrame:CGRectMake(0,
                                                                0,
                                                                kScreenWidth,
                                                                kContentViewHeight/3*2)];
    [magicBagBuyTableView setDataSource:self];
    [magicBagBuyTableView setDelegate:self];
    [magicBagBuyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [magicBagBuyTableView setBackgroundColor:RGB_BG_Clear];
    [self.contentView addSubview:magicBagBuyTableView];
    
    //
    ALComView *buyActionView=[[ALComView alloc]
                              initWithFrame:CGRectMake(0,
                                                       magicBagBuyTableView.bottom,
                                                       kScreenWidth,
                                                       self.contentView.height-magicBagBuyTableView.bottom)];
    [self.contentView addSubview:buyActionView];
    
    ALLabel *titLbl=[[ALLabel alloc] initWithFrame:CGRectMake(0, 0, buyActionView.width, 30)];
    [titLbl setText:@"选择付款方式"];
    [titLbl setFont:[UIFont systemFontOfSize:13]];
    [buyActionView addSubview:titLbl];
    
    float width=kScreenWidth/2;
    float orginY=titLbl.bottom;
    for (int i=0; i<2; i++) {
        ALComView *buyView=[[ALComView alloc]
                            initWithFrame:CGRectMake(i*width, titLbl.bottom, width, 50)];
        [buyActionView addSubview:buyView];
        
        ALButton * selectImgBtn = [[ALButton alloc] init];
        [selectImgBtn setFrame:CGRectMake(10, (60-22)/2.0f, 22, 22)];
        [selectImgBtn setImage:[UIImage imageNamed:@"shopping_btn_select_normal"] forState:UIControlStateNormal];
        [selectImgBtn setImage:[UIImage imageNamed:@"shopping_img_select_check"] forState:UIControlStateSelected];
        [selectImgBtn setTheBtnClickBlock:^(id sender){
        }];
        [buyView addSubview:selectImgBtn];
        
        ALImageView *imgView=[[ALImageView alloc]
                              initWithFrame:CGRectMake(selectImgBtn.right+5, 5, 40, 40)];
        [imgView setBackgroundColor:[UIColor yellowColor]];
        [buyView addSubview:imgView];
        
        orginY=buyView.bottom;
    }
    
    ALLabel *totalMoneyLbl=[[ALLabel alloc]
                            initWithFrame:CGRectMake(10, orginY, kScreenWidth-10-10, 30)];
    [totalMoneyLbl setText:@"本次支付：***元"];
    [buyActionView addSubview:totalMoneyLbl];
    
    ALLabel *sayLbl=[[ALLabel alloc] initWithFrame:CGRectMake(totalMoneyLbl.left, totalMoneyLbl.bottom, kScreenWidth-10-10, 30)];
    [sayLbl setText:@"支付后魔法包使用期限至………………"];
    [buyActionView addSubview:sayLbl];
    
    ALButton *goPaymentBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [goPaymentBtn setFrame:CGRectMake(10, sayLbl.bottom+5, kScreenWidth-10-10, 40)];
    [goPaymentBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [goPaymentBtn setBackgroundColor:[UIColor redColor]];
    [goPaymentBtn setTheBtnClickBlock:^(id sender){
    
    }];
    [buyActionView addSubview:goPaymentBtn];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _magicBagArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *theCellIdentify=@"theCellIdentify";
    ALMagicBagCell *theCell=[tableView dequeueReusableCellWithIdentifier:theCellIdentify];
    if (theCell==nil) {
        theCell=[[ALMagicBagCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:theCellIdentify];
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        ALLabel *lineLbl=[[ALLabel alloc]
                          initWithFrame:CGRectMake(0, 60-.5f, kScreenWidth, .5f)];
        [lineLbl setBackgroundColor:RGB_Line_Gray];
        [theCell addSubview:lineLbl];
    }
    [theCell setMagicDic:_magicBagArr[indexPath.row] andSel:YES andSelAction:^(BOOL sel) {
        
    }];
    return theCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
