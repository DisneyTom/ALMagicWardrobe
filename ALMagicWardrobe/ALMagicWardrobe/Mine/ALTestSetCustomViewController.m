//
//  ALTestSetCustomViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-23.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALTestSetCustomViewController.h"
#import "ALTestComSetViewController.h"
#define MyStyle ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"MyStyle.plist"])

@interface ALTestSetCustomViewController ()
{
    NSMutableArray *_selectViewArray;
    NSMutableArray * _btnMulArr;
    NSMutableArray *_lblArr;
    BOOL _isExit;
    NSDictionary *_oldDic;
    NSArray *_keyArr;
}
@end

@implementation ALTestSetCustomViewController{
    NSArray *_listCustom;
    float _orginY;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectViewArray = [[NSMutableArray alloc]initWithCapacity:2];
    _btnMulArr=[[NSMutableArray alloc] initWithCapacity:2];
    _lblArr = [[NSMutableArray alloc] initWithCapacity:0];
    [self setTitle:@"我的风格"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    
    _isExit = [fileManager fileExistsAtPath:MyStyle isDirectory:&isDir];
    if (_isExit)
    {
        _oldDic = [NSDictionary dictionaryWithContentsOfFile:MyStyle];
    }
    
    [self _initData];
    
    [self _initView];
}

-(void)_initData{
    NSArray *radioArr=@[@"25以下",@"25~30",@" 30以上"];
    NSArray *radioArrTwo=@[@"动物人物",@"植物花卉",@"几何形状",@"格纹条纹",@"字母数字",@"波点",@"抽象",@"无"];
    NSArray *radioArrThree=@[@"镂空",@"手绘",@"破洞",@"钉珠",
                        @"烫钻",@"绣花",@"印花",@"做旧",
                        @"铆钉",@"撞色",@"木耳边流苏",@"褶皱",
                        @"拼接",@"不规则",@"蕾丝",@"扎染",
                        @"亮片", @"蝴蝶结",@"贴布绣",@"无"];
    _keyArr = @[@"ageGroup",@"occupation",@"style",@"wish_style",@"avoid_colour",@"avoid_pic",@"avoid_tec"];
    _listCustom=@[
                       @{@"leftTit":@"年龄：",
                         @"rightValList":radioArr,
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"ageGroup"])
                         },
                       @{@"leftTit":@"职业：",
                         @"rightValList":@[@"商业专业",@"文化创意",@"自由职业",@"艺术表演"],
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"occupation"])
                         },
                       @{@"leftTit":@"主打风格：",
                         @"rightValList":@[@"女王大人",@"甜美清新",@"小小性感",@"轻松休闲",@"文艺小妞",@"职场淑女"],
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"style"])
                         },
                       @{@"leftTit":@"尝试风格：",
                         @"rightValList":@[@"女王大人",@"甜美清新",@"小小性感",@"轻松休闲",@"文艺小妞",@"职场淑女"],
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"wishStyle"])
                         },
                       @{@"leftTit":@"不能接收的颜色：",
                         @"rightValList":@[@"黑色",@"灰色",@"白色",@"奶油色",@"棕色",@"绿色",@"紫色",@"蓝色",@"橙色",@"黄色",@"红色",@"粉色",@"无"],
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"avoidColour"])
                         },
                       @{@"leftTit":@"不能接收的图案：",
                         @"rightValList":radioArrTwo,
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"avoidPic"])
                         },
                       @{@"leftTit":@"不能接受的工艺：",
                         @"rightValList":radioArrThree,
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"avoidTec"])
                         }
                          ];
    _orginY=0;

}
-(void)_initView{
    float height=140/4+10;
    float width=kScreenWidth-kLeftSpace-kRightSpace;
    self.contentView.backgroundColor = AL_RGB(235,235, 235);
    
    [_listCustom enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic=obj;
        
        ALComView *view=[[ALComView alloc]
                         initWithFrame:CGRectMake(kLeftSpace, height*idx, width, height)];
        [self.contentView addSubview:view];
        
        ALLabel *leftLbl=[[ALLabel alloc]
                          initWithFrame:CGRectMake(kLeftSpace, 0, width/2, height)];
        [leftLbl setText:dic[@"leftTit"]];
        [leftLbl setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:leftLbl];
        
        if (idx>=2) {
            ALLabel *lbl=[[ALLabel alloc]
                          initWithFrame:CGRectMake(leftLbl.right, 0, width/2-23, height)
                          andColor:[UIColor blackColor]
                          andFontNum:15];
            __block NSString *contentInit = dic[@"initVal"];
            if (contentInit.length <= 0)
            {
                contentInit = dic[@"rightValList"][0];
            }
            __block NSString *tmpStr = @"";
            NSArray *arr = [contentInit componentsSeparatedByString:@","];
            if (arr.count > 1)
            {
                [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if (idx == 0)
                    {
                        contentInit = obj;
                    }
                    else
                    {
                        NSString *tmp = obj;
                        if (tmp.length > 0 && ![tmp isEqualToString:@"无"])
                        {
                            if (tmpStr.length <= 0)
                            {
                                tmpStr = tmp;
                            }
                            else
                            {
                                tmpStr = [NSString stringWithFormat:@"%@,%@",tmpStr,tmp];
                            }
                            contentInit = tmpStr;
                        }
                        
                    }
                }];
               
            }
            [lbl setText:contentInit];
            [view addSubview:lbl];
            [_lblArr addObject:lbl];
            if (_isExit)
            {
                NSString *value = _keyArr[idx];
                NSString *content = [_oldDic valueForKey:value];
                [lbl setText:content];
            }
            
            ALImageView * imgView=[[ALImageView alloc] initWithFrame:CGRectMake(lbl.right, (height-30/2)/2, 30/2, 30/2)];
            [imgView setImage:[ALImage imageNamed:@"rightTou"]];
            [view addSubview:imgView];
            
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setFrame:CGRectMake(leftLbl.right, 0, width/2, height)];

            [btn setTheBtnClickBlock:^(id sender){
                ALTestComSetViewController *theCtrl=[[ALTestComSetViewController alloc] init];
                if (idx==2) { //
                    [theCtrl setTheType:ALStyle_type];
                    [theCtrl setTheBlock:^(id sender){
                        [lbl setText:sender];
                    }];
                }else if (idx==3){
                    [theCtrl setTheType:ALTryStyle_type];
                    [theCtrl setTheBlock:^(id sender){
                        [lbl setText:sender];
                    }];
                }else if (idx==4){
                    [theCtrl setTheType:ALNonAcceptanceColor_type];
                    [theCtrl setTheBlock:^(id sender){
                        [lbl setText:sender];
                    }];
                }else if (idx==5){
                    [theCtrl setTheType:ALNonAcceptancePattern_type];
                    [theCtrl setTheBlock:^(id sender){
                        [lbl setText:sender];
                    }];
                }else if (idx==6){
                    [theCtrl setTheType:ALNonAcceptanceTechnology_type];
                    [theCtrl setTheBlock:^(id sender){
                        [lbl setText:sender];
                    }];
                }
                [self.navigationController pushViewController:theCtrl animated:YES];
            }];
            [view addSubview:btn];
            [_btnMulArr addObject:btn];
        }else{
        ALSelectView *valSelView=[[ALSelectView alloc]
                                  initWithFrame:CGRectMake(leftLbl.right, 0, width/2, height)];
        [valSelView setSelectType:OcnSelectTypeNormal];
        valSelView.isScrollUp = NO;
        [valSelView setSelectedFont:[UIFont systemFontOfSize:15]];
        [view addSubview:valSelView];
        [_selectViewArray addObject:valSelView];
            [valSelView setValue:dic[@"initVal"]];
            [valSelView setOptions:dic[@"rightValList"]];
//            if (_isExit)
//            {
//                NSString *value = _keyArr[idx];
//                [valSelView setValue:[_oldDic valueForKey:value]];
//            }

        }
        
        ALImageView *line=[[ALImageView alloc]
                           initWithFrame:CGRectMake(0, view.height-.5f, view.width, .5f)];
        [line setImage:[ALImage imageNamed:@"model_long_line"]];
        [view addSubview:line];
        
        _orginY=view.bottom;
    }];
    
    __block ALTestSetCustomViewController *blockSelf = self;

    ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake(kLeftSpace,_orginY+30, 290, 37)];
    [okBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg.png"] forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTheBtnClickBlock:^(id sender){
        [blockSelf requestTestResult];
    }];
    [self.contentView addSubview:okBtn];
}

-(void)requestTestResult{
    __block ALTestSetCustomViewController *blockSelf = self;
    
    UILabel *styleLbl = _lblArr[0];
    UILabel *wishStyleLbl = _lblArr[1];
    UILabel *avoidColourLbl = _lblArr[2];
    UILabel *avoidPicLbl = _lblArr[3];
    UILabel *avoidTecLbl = _lblArr[4];
    
    NSString *style = styleLbl.text;
    NSString *wishStyle = wishStyleLbl.text;
    NSString *avoidColour = avoidColourLbl.text;
    NSString *avoidPic = avoidPicLbl.text;
    NSString *avoidTec = avoidTecLbl.text;
    
//    NSString *style = [[(ALButton *)_btnMulArr[0] titleLabel] text];
//    DLog(@"style is %@",lbl.text);
    NSDictionary *sendDic=@{
                            @"userId":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"id"])),
                            @"height":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"height"])),
                            @"weight":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"weight"])),
                            @"bar_size":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"barSize"])),
                            @"brassiere":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"brassiere"])),
                            @"yaobu":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"yaobu"])),
                            @"tunbu":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"tunbu"])),
                            @"jianbu":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"jianbu"])),
                            @"neck":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"neck"])),
                            @"buttocks":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"buttocks"])),
                            @"shank":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"shank"])),
                            @"thigh":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"thigh"])),
                            @"size":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"size"])),
                            @"habitus":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"habitus"])),
                            @"bust":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"bust"])),
                            @"waistline":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"waistline"])),
                            @"hipline":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"hipline"])),
                            @"shoulder":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"shoulder"])),
                            @"age_group":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[0]).value)),
                            @"occupation":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[1]).value)),
                            
                            @"style":MBNonEmptyStringNo_(style),
                            @"wish_style":MBNonEmptyStringNo_(wishStyle),
                            @"avoid_colour":MBNonEmptyStringNo_(avoidColour),
                            @"avoid_pic":MBNonEmptyStringNo_(avoidPic),
                            @"avoid_tec":MBNonEmptyStringNo_(avoidTec),
                            @"birthday":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"birthday"])),
                            @"status":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"status"])),
                            @"wish":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"wish"]))
                            };

    
    NSLog(@"%@",sendDic);
    
    [DataRequest requestApiName:@"fashionSquare_saveTestResult"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       
                       if(!sucContent[@"body"]||![MBNonEmptyStringNo_(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                           showWarn(@"修改失败");
                           
                       }else{
                           showWarn(@"修改成功");
                           [blockSelf.navigationController popViewControllerAnimated:YES];
                           DLog(@"%@",MyStyle);
                           BOOL isSuc = [sendDic writeToFile:MyStyle atomically:YES];
                           if (isSuc == YES)
                           {
                               DLog(@"写入成功");
                           }
                           
                       }
                   } failedBlock:^(id failContent) {
                       showWarn(@"修改失败");
                   } reloginBlock:^(id reloginContent) {
                   }];
}


@end
