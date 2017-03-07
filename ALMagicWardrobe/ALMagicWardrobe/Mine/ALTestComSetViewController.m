//
//  ALTestComSetViewController.m
//  ALMagicWardrobe
//
//  Created by OCN on 15-4-28.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALTestComSetViewController.h"
static const int InitTag = 100000;

@interface ALTestComSetViewController ()
{
    NSMutableArray *mulBtnArr;
    NSMutableArray *getOccuPationArray;
}
@property(nonatomic,copy) NSString *resultStr;
@end

@implementation ALTestComSetViewController{
    float _orginY;
    NSString *_resultStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initData];
    
    [self _initView];
    
    __block ALTestComSetViewController *theBlockCtrl=self;
    
    [self setViewWithType:rightBtn1_type
                  andView:^(id view) {
                      ALButton *theBtn=view;
                      [theBtn setTitle:@"完成" forState:UIControlStateNormal];
                      [theBtn setTitleColor:AL_RGB(149,105,62) forState:UIControlStateNormal];
                      [theBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    } andBackEvent:^(id sender) {
        if (theBlockCtrl.theBlock) {
            theBlockCtrl.theBlock(theBlockCtrl.resultStr);
        }
        [theBlockCtrl.navigationController popViewControllerAnimated:YES];
    }];
}
-(void)_initData{
    _orginY=0;
}
-(void)_initView{
    [self createViewAndType:self.theType];
}
-(void)createViewAndType:(ALTestEnum)theType{
    [self.contentView removeAllSubviews];
    
    switch (theType) {
        case ALStyle_type:
        {
            [self _createOneView];
        }
            break;
        case ALTryStyle_type:
        {
            [self _createTwoView];
        }
            break;
        case ALNonAcceptanceColor_type:
        {
            [self _createThreeView];
        }
            break;
        case ALNonAcceptancePattern_type:
        {
            [self _createFourView];
        }
            break;
        case ALNonAcceptanceTechnology_type:
        {
            [self _createFiveView];
        }
            break;
        default:
            break;
    }
}
#pragma mark ALStyle_type
#pragma mark -
-(void)_createOneView{
    //3
    ALLabel *left3Lbl=[[ALLabel alloc]
                       initWithFrame:CGRectMake(kLeftSpace, 5, kScreenWidth-kLeftSpace-kRightSpace, 30)];
    [left3Lbl setText:@"III、你的常穿风格（可多选）"];
    [self.contentView addSubview:left3Lbl];
    [left3Lbl setFont:[UIFont boldSystemFontOfSize:14]];
    left3Lbl.textColor = colorByStr(@"6D6A6B");
    _orginY=left3Lbl.bottom;
    
    NSArray *arr2=@[
                    @{@"女王大人":@"test_photo001"},
                    @{@"甜美清新":@"test_photo002"},
                    @{@"小小性感":@"test_photo003"},
                    @{@"轻松休闲":@"test_photo004"},
                    @{@"文艺小妞":@"test_photo005"},
                    @{@"职场淑女":@"test_photo006"}
                    ];
    
    getOccuPationArray = [NSMutableArray arrayWithCapacity:2];
    ALComView *contentView=[[ALComView alloc]
                            initWithFrame:CGRectMake((kScreenWidth-104*2-5)/2, _orginY+5, 104*2+5, self.view.size.height - 46)];
    [self.contentView addSubview:contentView];
    self.contentView.scrollEnabled = NO;
    mulBtnArr=[NSMutableArray array];
    [arr2 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic=obj;
        ALImageView *imgView=[[ALImageView alloc]
                              initWithFrame:CGRectZero];
        [imgView setImage:[ALImage imageNamed:[dic allValues][0]]];
        [contentView addSubview:imgView];
        imgView.tag = InitTag + idx;
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImgClick:)];
        [imgView addGestureRecognizer:tap];
        
        ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectZero];
        [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
        [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
        [btn setTitle:[dic allKeys][0] forState:UIControlStateNormal];
        [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTag:1000+idx];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [btn setTheBtnClickBlock:^(id sender){
            ALButton *childBtn=sender;
            [self btnClick:childBtn.tag - 1000];
//            if (childBtn.selected==NO) {
//                [childBtn setSelected:YES];
//                [getOccuPationArray addObject:childBtn.titleLabel.text];
//            }else{
//                [childBtn setSelected:NO];
//                [getOccuPationArray removeObject:childBtn.titleLabel.text];
//            }
//            _resultStr=[getOccuPationArray componentsJoinedByString:@","];
        }];
        [contentView addSubview:btn];
        [mulBtnArr addObject:btn];
        
//        if (idx/2==0) {
//            [imgView setFrame:CGRectMake((5+104)*idx, 0, 104, 132)];
//            [btn setFrame:CGRectMake(imgView.left,imgView.bottom, imgView.width, 20)];
//        }else if (idx/2==1){
//            [imgView setFrame:CGRectMake((5+104)*(idx-2), (132+20)*1+10, 104, 132)];
//            [btn setFrame:CGRectMake(imgView.left,imgView.bottom, imgView.width, 20)];
//        }else{
//            [imgView setFrame:CGRectMake((5+104)*(idx-4), (132+20)*2+20, 104, 132)];
//            [btn setFrame:CGRectMake(imgView.left,imgView.bottom, imgView.width, 20)];
//        }
        if (idx/2==0) {
            [imgView setFrame:CGRectMake( 90*idx + 20, 15, 85, 110)];
            [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 18)];
        }else if (idx/2==1){
            [imgView setFrame:CGRectMake(90*(idx-2) + 20, (110+18 )*1+5 + 15, 85, 110)];
            [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 18)];
        }else{
            [imgView setFrame:CGRectMake(90*(idx-4) + 20, (110+18)*2+8+ 15, 85, 110)];
            [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 18)];
        }

    }];
}
-(void)_createTwoView{
    //4
    ALLabel *left4Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(kLeftSpace, 15, kScreenWidth-kLeftSpace-kRightSpace, 15)];
    [left4Lbl setText:@"IV、你近期想尝试的风格（可多选）"];
    [self.contentView addSubview:left4Lbl];
    [left4Lbl setFont:[UIFont boldSystemFontOfSize:14]];
    left4Lbl.textColor = colorByStr(@"6D6A6B");
    _orginY=left4Lbl.bottom;
    
    NSArray *arr2=@[
                    @{@"女王大人":@"test_photo0001"},
                    @{@"甜美清新":@"test_photo0002"},
                    @{@"小小性感":@"test_photo0003"},
                    @{@"轻松休闲":@"test_photo0004"},
                    @{@"文艺小妞":@"test_photo0005"},
                    @{@"职场淑女":@"test_photo0006"}
                    ];
    getOccuPationArray = [NSMutableArray arrayWithCapacity:2];
    ALComView *contentView=[[ALComView alloc]
                            initWithFrame:CGRectMake((kScreenWidth-104*2-5)/2, _orginY+5, 104*2+5, self.view.size.height - 46)];
    [self.contentView addSubview:contentView];
    self.contentView.scrollEnabled = NO;
    mulBtnArr=[NSMutableArray array];
    [arr2 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic=obj;
        ALImageView *imgView=[[ALImageView alloc]
                              initWithFrame:CGRectZero];
        [imgView setImage:[ALImage imageNamed:[dic allValues][0]]];
        [contentView addSubview:imgView];
        imgView.tag = InitTag + idx;
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImgClick:)];
        [imgView addGestureRecognizer:tap];
        
        ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectZero];
        [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
        [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
        [btn setTitle:[dic allKeys][0] forState:UIControlStateNormal];
        [btn setTag:1000+idx];
        [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [btn setTheBtnClickBlock:^(id sender){
            ALButton *childBtn=sender;
            [self btnClick:childBtn.tag - 1000];
//            if (childBtn.selected==NO) {
//                [childBtn setSelected:YES];
//                [getOccuPationArray addObject:childBtn.titleLabel.text];
//            }else{
//                [childBtn setSelected:NO];
//                [getOccuPationArray removeObject:childBtn.titleLabel.text];
//            }
//            _resultStr=[getOccuPationArray componentsJoinedByString:@","];
        }];
        [contentView addSubview:btn];
        
        
        if (idx/2==0) {
            [imgView setFrame:CGRectMake( 90*idx + 20, 15, 85, 110)];
            [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 18)];
        }else if (idx/2==1){
            [imgView setFrame:CGRectMake(90*(idx-2) + 20, (110+18 )*1+5 + 15, 85, 110)];
            [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 18)];
        }else{
            [imgView setFrame:CGRectMake(90*(idx-4) + 20, (110+18)*2+8+ 15, 85, 110)];
            [btn setFrame:CGRectMake(imgView.left,imgView.bottom + 2, imgView.width, 18)];
        }

        
        [mulBtnArr addObject:btn];
    }];

}
#pragma mark 不能接受的颜色
-(void)_createThreeView{
    
   NSMutableArray * _mulColorArr=[NSMutableArray array];
//   NSMutableString* _mulColorStr=[[NSMutableString alloc] initWithCapacity:2];
   NSMutableArray* _colorBtnArr=[[NSMutableArray alloc] initWithCapacity:2];
    //4
    ALLabel *left4Lbl=[[ALLabel alloc]
                       initWithFrame:CGRectMake(10, 15, 250, 15)];
    [left4Lbl setText:@"V、你不能接受的服装颜色（可多选）"];
    [self.contentView addSubview:left4Lbl];
    [left4Lbl setFont:[UIFont boldSystemFontOfSize:14]];
    left4Lbl.textColor = colorByStr(@"6D6A6B");
    _orginY=left4Lbl.bottom;
    
    NSArray *arr2=@[
                    @{@"黑色":@"choose_black"},
                    @{@"灰色":@"choose_gray"},
                    @{@"白色":@"choose_white"},
                    @{@"奶油色":@"choose_cream"},
                    @{@"棕色":@"choose_brown"},
                    @{@"绿色":@"choose_green"},
                    @{@"紫色":@"choose_purple"},
                    @{@"蓝色":@"choose_blue"},
                    @{@"橙色":@"choose_orange"},
                    @{@"黄色":@"choose_yellow"},
                    @{@"红色":@"choose_red"},
                    @{@"粉色":@"choose_pink"},
                    @{@"无":@"choose_none"}
                    ];
    ALComView *contentView=[[ALComView alloc]
                            initWithFrame:CGRectMake(30, _orginY+15, 275, 240)];
    [self.contentView addSubview:contentView];
    _orginY=contentView.bottom;
    getOccuPationArray = [NSMutableArray arrayWithCapacity:2];
    [arr2 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic=obj;
        ALImageView *imgView=[[ALImageView alloc]
                              initWithFrame:CGRectZero];
        [imgView setImage:[ALImage imageNamed:[dic allValues][0]]];
        [imgView setUserInteractionEnabled:YES];
        [contentView addSubview:imgView];
        
        ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectZero];
        [btn setImage:nil forState:UIControlStateNormal];
        [btn setImage:[ALImage imageNamed:@"icon_option_on"] forState:UIControlStateSelected];
        [btn setTheBtnClickBlock:^(id sender){
            if ([[dic allKeys][0] isEqualToString:@"无"]) {
                [_colorBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    ALButton *btn=obj;
                    [btn setSelected:NO];
                }];
                [_mulColorArr removeAllObjects];
                [getOccuPationArray removeAllObjects];
                _resultStr = @"";
            }else{
                ALButton *btn=_colorBtnArr[_colorBtnArr.count-1];
                [btn setSelected:NO];
                [_mulColorArr removeObject:@"无"];
                [getOccuPationArray removeObject:@"无"];
                NSArray *comArr = [_resultStr componentsSeparatedByString:@","];
                _resultStr = @"";
                [comArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSString *tmp = obj;
                    if (![tmp isEqualToString:@"无"]) {
                        _resultStr = [NSString stringWithFormat:@"%@,%@",_resultStr,obj];
                    }
                    

                }];
            }
            ALButton *theBtn=sender;
            [theBtn setSelected:!theBtn.selected];
            
            if (theBtn.selected) {
                [getOccuPationArray addObject:[dic allKeys][0]];
//                [_mulColorArr addObject:[dic allKeys][0]];
            }else{
                [getOccuPationArray removeObject:[dic allKeys][0]];
//                [_mulColorArr removeObject:[dic allKeys][0]];
            }
            
//            [_mulColorStr deleteCharactersInRange:NSMakeRange(0, _mulColorStr.length)];
//            [_mulColorArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                [_mulColorStr appendFormat:@"%@,",obj];
//            }];
            _resultStr=[getOccuPationArray componentsJoinedByString:@","];

//            _resultStr=_mulColorStr;
        }];
        [imgView addSubview:btn];
        
        ALLabel *lbl=[[ALLabel alloc] initWithFrame:CGRectZero andColor:colorByStr(@"#949192") andFontNum:14];
        [lbl setText:[dic allKeys][0]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [contentView addSubview:lbl];
        
        if (idx/5==0) {
            [imgView setFrame:CGRectMake((5+50)*idx, 0, 50, 50)];
            [btn setFrame:CGRectMake(0,0, imgView.width, imgView.height)];
            [lbl setFrame:CGRectMake(imgView.left,imgView.bottom, imgView.width, 20)];
        }else if (idx/5==1){
            [imgView setFrame:CGRectMake((5+50)*(idx-5), (50+20)*1+10, 50, 50)];
            [btn setFrame:CGRectMake(0,0, imgView.width, imgView.height)];
            [lbl setFrame:CGRectMake(imgView.left,imgView.bottom, imgView.width, 20)];
        }else{
            [imgView setFrame:CGRectMake((5+50)*(idx-10), (50+20)*2+20, 50, 50)];
            [btn setFrame:CGRectMake(0,0, imgView.width, imgView.height)];
            [lbl setFrame:CGRectMake(imgView.left,imgView.bottom, imgView.width, 20)];
        }
        [_colorBtnArr addObject:btn];
    }];
}
#pragma mark 不能接受的图案
-(void)_createFourView{
    NSMutableArray * _mulPicArr=[NSMutableArray array];
//    NSMutableString * _mulPicStr=[[NSMutableString alloc] initWithCapacity:2];
    NSMutableArray * _picBtnArr=[[NSMutableArray alloc] initWithCapacity:2];
    //6
    ALLabel *left5Lbl=[[ALLabel alloc] initWithFrame:CGRectMake(10, 10, 300, 15)];
    [left5Lbl setText:@"VI、你不能接受的服装图案（可多选）"];
    left5Lbl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:left5Lbl];
    _orginY=left5Lbl.bottom;
    left5Lbl.textAlignment = NSTextAlignmentLeft;
    _orginY=left5Lbl.bottom + 20;
    
    ALComView *content2View=[[ALComView alloc] initWithFrame:CGRectMake(35, _orginY, 250, 128)];
    [self.contentView addSubview:content2View];
    
    NSArray *radioArr=@[@"动物人物",@"植物花卉",@"几何形状",@"格纹条纹",@"字母数字",@"波点",@"抽象",@"无"];
    _resultStr=radioArr[0];
    
    float width=content2View.width/3;
    NSMutableArray *btnArr=[NSMutableArray array];
    getOccuPationArray = [NSMutableArray arrayWithCapacity:2];
    [radioArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(kLeftSpace+width*idx, _orginY, width, 30)];
        [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
        [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTag:10000+idx];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setTheBtnClickBlock:^(id sender){
            if ([obj isEqualToString:@"无"]) {
                [_picBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    ALButton *btn=obj;
                    [btn setSelected:NO];
                }];
                [_mulPicArr removeAllObjects];
                [getOccuPationArray removeAllObjects];
                _resultStr = @"";
            }else{
                ALButton *btn=_picBtnArr[_picBtnArr.count-1];
                [btn setSelected:NO];
                [_mulPicArr removeObject:@"无"];
                [getOccuPationArray removeObject:@"无"];
                NSArray *comArr = [_resultStr componentsSeparatedByString:@","];
                _resultStr = @"";
                [comArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSString *tmp = obj;
                    if (![tmp isEqualToString:@"无"]) {
                        _resultStr = [NSString stringWithFormat:@"%@,%@",_resultStr,obj];
                    }
                    
                    
                }];
            }
            
            ALButton *theBtn=sender;
            [theBtn setSelected:!theBtn.selected];
            if (theBtn.selected) {
                [getOccuPationArray addObject:theBtn.titleLabel.text];
//                [_mulPicArr addObject:theBtn.titleLabel.text];
            }else{
                [getOccuPationArray removeObject:theBtn.titleLabel.text];
//                [_mulPicArr removeObject:theBtn.titleLabel.text];
            }
//            [_mulPicStr deleteCharactersInRange:NSMakeRange(0, _mulPicStr.length)];
//            [_mulPicArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                [_mulPicStr appendFormat:@"%@,",obj];
//            }];
            _resultStr=[getOccuPationArray componentsJoinedByString:@","];

//            _resultStr=_mulPicStr;
            
        }];
        
        [content2View addSubview:btn];
        [btnArr addObject:btn];
        
        if (idx/3==0) {
            [btn setFrame:CGRectMake(width*idx, 30*0, width, 30)];
            _orginY=btn.bottom;
        }else if (idx/3==1){
            [btn setFrame:CGRectMake(width*(idx-3), 30*1+10, width, 30)];
            _orginY=btn.bottom;
        }else{
            [btn setFrame:CGRectMake(width*(idx-6), 30*2+20, width, 30)];
            _orginY=btn.bottom;
        }
        
        [_picBtnArr addObject:btn];
    }];
}
#pragma mark 不能接受的工艺
-(void)_createFiveView{
    NSMutableArray * _tecMulArr=[[NSMutableArray alloc] initWithCapacity:2];

    //7
    ALLabel *left7Lbl=[[ALLabel alloc]
                       initWithFrame:CGRectMake(10.f, 15, 255, 15)];
    [left7Lbl setText:@"vii 你不能接受的服装工艺（可多选）"];
    [self.contentView addSubview:left7Lbl];
    [left7Lbl setFont:[UIFont boldSystemFontOfSize:15]];
    left7Lbl.textAlignment = NSTextAlignmentRight;
    _orginY=left7Lbl.bottom + 15;
    
    ALComView *content2View=[[ALComView alloc] initWithFrame:CGRectMake(25, _orginY, 270, 246)];
    [self.contentView addSubview:content2View];
//    content2View.backgroundColor = [UIColor redColor];
    
    NSArray *radioArr=@[@"镂空",@"手绘",@"破洞",@"钉珠",
                        @"烫钻",@"绣花",@"印花",@"做旧",
                        @"铆钉",@"撞色",@"木耳边",@"流苏",
                        @"褶皱",@"拼接",@"不规则",@"蕾丝",
                        @"扎染",@"亮片", @"蝴蝶结",@"贴布绣",
                        @"无"];
    float width=content2View.width/4;
    _resultStr=radioArr[0];
    
    NSMutableArray *btnArr=[NSMutableArray array];
    getOccuPationArray = [NSMutableArray arrayWithCapacity:2];
    [radioArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(kLeftSpace+width*idx, _orginY, width, 30)];
        [btn setImage:[ALImage imageNamed:@"icon025"] forState:UIControlStateNormal];
        [btn setImage:[ALImage imageNamed:@"icon024"] forState:UIControlStateSelected];
        [btn setTitle:obj forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth=YES;
        [btn setTitleColor:colorByStr(@"#9c9a96") forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTag:10000+idx];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [btn setTheBtnClickBlock:^(id sender){
            if ([obj isEqualToString:@"无"]) {
                [_tecMulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    ALButton *btn=obj;
                    [btn setSelected:NO];
                }];
                [getOccuPationArray removeAllObjects];
                _resultStr = @"";
            }else{
                ALButton *btn=_tecMulArr[_tecMulArr.count-1];
                [btn setSelected:NO];
                [getOccuPationArray removeObject:@"无"];
                NSArray *comArr = [_resultStr componentsSeparatedByString:@","];
                _resultStr = @"";
                [comArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSString *tmp = obj;
                    if (![tmp isEqualToString:@"无"]) {
                        _resultStr = [NSString stringWithFormat:@"%@,%@",_resultStr,obj];
                    }
                    
                    
                }];
            }
            
            ALButton *theBtn=sender;
            [theBtn setSelected:!theBtn.selected];
            if (theBtn.selected) {
                [getOccuPationArray addObject:theBtn.titleLabel.text];
            }else{
                [getOccuPationArray removeObject:theBtn.titleLabel.text];
            }
            _resultStr=[getOccuPationArray componentsJoinedByString:@","];
        }];
        [content2View addSubview:btn];
        [btnArr addObject:btn];
       
        if (idx < 12)
        {
            if (idx/4==0) {
                [btn setFrame:CGRectMake(width*idx, 20*0, width, 20)];
                _orginY=btn.bottom;
            }else if (idx/4==1){
                [btn setFrame:CGRectMake(width*(idx-4), 20*1+10, width, 20)];
                _orginY=btn.bottom;
            }else if (idx/4==2){
                [btn setFrame:CGRectMake(width*(idx-4*2), 20*2+20, width, 20)];
                _orginY=btn.bottom;
            }
        }
        else
        {
            NSInteger index = idx - 12;
            if (index/3==0){
                [btn setFrame:CGRectMake(width*index, 20*3+30, width, 20)];
                _orginY=btn.bottom;
            }else if (index/3==1){
                [btn setFrame:CGRectMake(width*(index-3), 20*4+40, width, 20)];
                _orginY=btn.bottom;
            }
            else if (index/3 == 2)
            {
                [btn setFrame:CGRectMake(width*(index-3*2), 20*5+50, width, 20)];
                _orginY=btn.bottom;
            }
        }

        

        [_tecMulArr addObject:btn];
    }];
}


#pragma mark -设置图片点击
- (void)setImgClick:(UITapGestureRecognizer *)reco
{
    UIImageView *view = (UIImageView *)reco.view;
    NSInteger tag = view.tag;
    [self btnClick:tag - InitTag];
    
}


#pragma mark - 按钮的点击状态
- (void)btnClick:(NSInteger)tag
{
    
    [mulBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        ALButton *childBtn = obj;
        if (idx == tag)
        {
            if (childBtn.selected == NO) {
                [childBtn setSelected:YES];
                [getOccuPationArray addObject:childBtn.titleLabel.text];
            }else{
                [childBtn setSelected:NO];
                [getOccuPationArray removeObject:childBtn.titleLabel.text];
            }
        }
         _resultStr=[getOccuPationArray componentsJoinedByString:@","];
    }];
}
@end
