//
//  ALTestSetModelViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-23.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALTestSetModelViewController.h"

@interface ALTestSetModelViewController ()

@end

@implementation ALTestSetModelViewController{
    NSArray *_listMyTestModel;
    NSMutableArray *_selectViewArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectViewArray = [[NSMutableArray alloc]initWithCapacity:2];
    [self setTitle:@"我的模形"];
    [self _initData];
    [self _initView];
}


-(void)_initData{
    
    NSMutableArray *cmArray = [NSMutableArray arrayWithCapacity:2];
    for(int i=150;i<=175;i++){
        [cmArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSMutableArray *hiArray = [NSMutableArray arrayWithCapacity:2];
    for(int i=40;i<=65;i++){
        [hiArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSMutableArray *oneArray = [NSMutableArray arrayWithCapacity:2];
    for(int i=70;i<=105;i++){
        [oneArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSMutableArray *twoArray = [NSMutableArray arrayWithCapacity:2];
    for(int i=50;i<=85;i++){
        [twoArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSMutableArray *twotwoArr=[NSMutableArray arrayWithCapacity:2];
    for (int i=70; i<=105; i++) {
        [twotwoArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSMutableArray *threeArray = [NSMutableArray arrayWithCapacity:2];
    for(int i=30;i<=50;i++){
        [threeArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSMutableArray *fourArray = [NSMutableArray arrayWithCapacity:2];
//    for(int i=30;i<=50;i++){
//        [fourArray addObject:[NSString stringWithFormat:@"%d",i]];
//    }
    //@"较窄",@"适中",@"较宽"
    [fourArray addObject:@"较窄"];
    [fourArray addObject:@"适中"];
    [fourArray addObject:@"较宽"];
   
    _listMyTestModel=@[
                       @{@"leftTit":@"身高：",
                         @"unit":@"cm",
                        @"rightValList":cmArray,
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"height"])},
                       @{@"leftTit":@"体重：",
                         @"unit":@"kg",
                         @"rightValList":hiArray,
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"weight"])
                         },
                       @{@"leftTit":@"胸围：",
                         @"unit":@"cm",
                         @"rightValList":oneArray,
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"bust"])
                         },
                       @{@"leftTit":@"腰围：",
                         @"unit":@"cm",
                         @"rightValList":twoArray,
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"waistline"])
                         },
                       @{
                           @"leftTit":@"臀围：",
                           @"unit":@"cm",
                           @"rightValList":twotwoArr,
                           @"initVal":filterStr(self.theUserDetailTest[@"user"][@"hipline"])
                           },
                       @{@"leftTit":@"肩宽：",
                         @"unit":@"cm",
                         @"rightValList":threeArray,
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"shoulder"])
                         },
                       @{@"leftTit":@"颈围：",
                         @"unit":@"",
                         @"rightValList":@[@"适中",@"修长",@"略粗"],
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"neck"])
                         },
                       @{@"leftTit":@"上臂围：",
                         @"unit":@"",
                         @"rightValList":@[@"适中",@"修长",@"略粗"],
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"buttocks"])
                         },
                       @{@"leftTit":@"大腿围：",
                         @"unit":@"",
                         @"rightValList":@[@"适中",@"修长",@"略粗"],
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"thigh"])
                         },
                       @{@"leftTit":@"小腿围：",
                         @"unit":@"",
                         @"rightValList":@[@"适中",@"修长",@"略粗"],
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"shank"])
                         },
                       @{@"leftTit":@"体型：",
                         @"unit":@"",
                         @"rightValList":@[@"A体型",@"X体型",@"H体型",@"Y体型",@"O体型"],
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"habitus"])
                         },
                       @{@"leftTit":@"常穿尺码：",
                         @"unit":@"",
                         @"rightValList":@[@"XS",@"S",@"M",@"L",@"XL",@"均码"],
                         @"initVal":filterStr(self.theUserDetailTest[@"user"][@"size"])
                         }
                       ];
}
-(void)_initView{
    float height=36;
    float width=350/2;
    [_listMyTestModel enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic=obj;
        
        ALComView *view=[[ALComView alloc]
                         initWithFrame:CGRectMake(20/2, height*idx, width, height)];
        [self.contentView addSubview:view];
        
        ALLabel *leftLbl=[[ALLabel alloc]
                          initWithFrame:CGRectMake(0, 0, width/3+15, height)];
        [leftLbl setText:dic[@"leftTit"]];
        [leftLbl setTextAlignment:NSTextAlignmentRight];
        [leftLbl setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:leftLbl];
        
        ALSelectView *valSelView=[[ALSelectView alloc]
                                  initWithFrame:CGRectMake(leftLbl.right, 0, width/3, height)];
        [valSelView setSelectType:OcnSelectTypeNormal];
        [_selectViewArray addObject:valSelView];
        [view addSubview:valSelView];
        [valSelView changeFont:[UIFont systemFontOfSize:12]];
        [valSelView setSelectedFont:[UIFont systemFontOfSize:12]];
        [valSelView setValue:dic[@"initVal"]];
        [valSelView setOptions:dic[@"rightValList"]];
        [valSelView setAlignment:UIControlContentHorizontalAlignmentCenter];
        
        ALLabel *unitLbl=[[ALLabel alloc]
                          initWithFrame:CGRectMake(valSelView.right, 0, width/3-15, height) andColor:colorByStr(@"#9A9A9A") andFontNum:13];
        [unitLbl setText:dic[@"unit"]];
        unitLbl.textAlignment = NSTextAlignmentRight;
        [view addSubview:unitLbl];
        
        ALImageView *line=[[ALImageView alloc] initWithFrame:CGRectMake(30, view.height-.5f, 140, .5f)];
        [line setImage:[ALImage imageNamed:@"model_long_line"]];
        [view addSubview:line];
    }];
    
    //height*_listMyTestModel.count
    UIImageView *rightImgView=[[UIImageView alloc]
                               initWithFrame:CGRectMake(320 - 100, 12, 90, 421)];
    [rightImgView setImage:[ALImage imageNamed:@"model_bg"]];
    [self.contentView addSubview:rightImgView];
    __block ALTestSetModelViewController *blockSelf = self;

    ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake((kScreenWidth-470/2)/2, rightImgView.bottom+10, 470/2, 60/2)];
    [okBtn setBackgroundImage:[ALImage imageNamed:@"btn_bg.png"] forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTheBtnClickBlock:^(id sender){
        [blockSelf requestTestResult];
    }];
    [self.contentView addSubview:okBtn];
}
-(void)requestTestResult{

    __block ALTestSetModelViewController *blockSelf = self;
    
    NSDictionary *sendDic=@{
                            @"userId":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"id"])),
                            @"height":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[0]).value)),
                            @"weight":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[1]).value)),
                            @"bar_size":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"barSize"])),
                            @"brassiere":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"brassiere"])),
                            @"yaobu":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"yaobu"])),
                            @"tunbu":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"tunbu"])),
                            @"jianbu":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"jianbu"])),
                            @"neck":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[6]).value)),
                            @"buttocks":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[7]).value)),
                            @"shank":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[9]).value)),
                            @"thigh":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[8]).value)),
                            @"size":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[11]).value)),
                            @"habitus":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[10]).value)),
                            @"bust":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[2]).value)),
                            @"waistline":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[3]).value)),
                            @"hipline":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[4]).value)),
                            @"shoulder":MBNonEmptyStringNo_(filterStr(((ALSelectView*)_selectViewArray[5]).value)),
                            @"age_group":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"ageGroup"])),
                            @"occupation":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"occupation"])),
                            @"style":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"style"])),
                            @"wish_style":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"wishStyle"])),
                            @"avoid_colour":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"avoidColour"])),
                            @"avoid_pic":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"avoidPic"])),
                            @"avoid_tec":MBNonEmptyStringNo_(filterStr(_theUserDetailTest[@"user"][@"avoidTec"])),
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
                           
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}

@end
