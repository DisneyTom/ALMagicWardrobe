//
//  MGUICtrl_ OutsideAddress.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/22.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUICtrl_OutsideAddress.h"
#import "JSONKit.h"
#import "ALTextView.h"
#import "ALTabBarViewController.h"


@interface MGUICtrl_OutsideAddress ()
{
    BOOL _isEditOrAddAddress;//yes 修改地址
    ALSelectView *_citySelView;
    ALSelectView *_countySelView;
    NSArray *_provinces;
    UILabel* lbl_Prompt;
    NSMutableArray* array_Data;
}
@end
@implementation MGUICtrl_OutsideAddress
{
}
-(NSMutableArray *)getCityData
{
    NSArray *jsonArray = [[NSArray alloc]init];
    NSData *fileData = [[NSData alloc]init];
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
  
    if ([UD objectForKey:@"city"] == nil) {
        NSString *path;
        path = [[NSBundle mainBundle] pathForResource:@"zh_CN" ofType:@"json"];
        fileData = [NSData dataWithContentsOfFile:path];
        
        [UD setObject:fileData forKey:@"city"];
        [UD synchronize];
    }
    else {
        fileData = [UD objectForKey:@"city"];
    }
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    jsonArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary *dict in jsonArray) {
        [array addObject:dict];
    }
    
    return array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"选择城市"];
    array_Data = [self getCityData][0][@"children"];
    __block MGUICtrl_OutsideAddress* theBlock = self;
    [self setViewWithType:rightBtn1_type
                  andView:^(id view) {
                      ALButton *btn=view;
                      [btn setHidden:NO];
                      [btn setTitle:@"跳过" forState:0];
                      btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
                      [btn setTitleColor:colorByStr(@"#907948") forState:0];
                  } andBackEvent:^(id sender) {
                          [theBlock.navigationController popToRootViewControllerAnimated:true];
                  }];
    [self _initData];
    [self _initView];
}

-(void)_initData{
}

-(void)castPersonProvinSelBtnPressed{
    
    int row =0;
    for (int i=0; i<array_Data.count; i++) {
        if ([array_Data[i][@"name"] isEqualToString:_citySelView.value]) {
            row = i;
            break;
        }
    }
    NSDictionary* cities = array_Data[row];
    [_countySelView setOptions:cities[@"children"]];
    _citySelView.selectedFont = [UIFont systemFontOfSize:14];
    _countySelView.selectedFont = [UIFont systemFontOfSize:14];
    [_countySelView setValue:cities[@"children"][0][@"name"]];
    
    
}
-(void)_initView{
    
    lbl_Prompt = [[UILabel alloc]init];
    lbl_Prompt.text = @"真抱歉，小魔还没能走到你的城市。请留下你的城市信息，小魔会尽快为你的城市提供服务的！";
    lbl_Prompt.numberOfLines = 0;
    lbl_Prompt.frame = CGRectMake(10, 15, kScreenWidth - 20, 80);
    lbl_Prompt.font = [UIFont systemFontOfSize:16];
    [lbl_Prompt sizeToFit];
    lbl_Prompt.frame = CGRectMake((kScreenWidth -lbl_Prompt.width)/2, 15, lbl_Prompt.width, lbl_Prompt.height);
    [self.contentView addSubview:lbl_Prompt];
    _citySelView=[[ALSelectView alloc]
                  initWithFrame:CGRectMake(80/2, lbl_Prompt.bottom + 15, 190/2, 66/2)
                  img:[UIImage imageNamed:@"province_city_bg.png"]];
    [_citySelView setSelectType:OcnSelectTypeNormal];
    [_citySelView addTarget:self forVauleChangedaction:@selector(castPersonProvinSelBtnPressed)];
       [_citySelView setValue:@"选择地区"];
    _provinces = [[NSArray alloc]
                  initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    NSMutableArray *proviceAray  = [NSMutableArray arrayWithCapacity:2];
    for (int i=0; i<array_Data.count; i++) {
        [proviceAray addObject:array_Data[i][@"name"]];
    }
    _citySelView.selectedFont = [UIFont systemFontOfSize:14];
    [_citySelView setOptions:proviceAray];
    [self.contentView addSubview:_citySelView];
    _countySelView=[[ALSelectView alloc] initWithFrame:CGRectMake(_citySelView.left, _citySelView.bottom+32/2, _citySelView.width, _citySelView.height) img:[UIImage imageNamed:@"province_city_bg.png"]];
    _countySelView.selectedFont = [UIFont systemFontOfSize:14];
    [_countySelView setSelectType:OcnSelectTypeNormal];
    [self.contentView addSubview:_countySelView];
    if (_isEditOrAddAddress) {
        if (MBNonEmptyString(_addRessModel.province).length>0) {
            [_citySelView setValue:_addRessModel.province];
        }
        if (MBNonEmptyString(_addRessModel.city).length>0) {
            [_countySelView setValue:_addRessModel.city];
        }
          }
    ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake(40, _countySelView.bottom + 30, 240, 60/2)];
    [okBtn setBackgroundImage:[ALImage imageNamed:@"bg04"] forState:UIControlStateNormal];
    [okBtn setTitle:@"填写完毕,确定" forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [okBtn setTheBtnClickBlock:^(id sender){
        
        if (_citySelView.value.length == 0 || [_citySelView.value isEqualToString:@"选择地区"])
        {
            showWarn(@"请选择地区");
            return ;
        }
        
        NSDictionary *sendDic = nil;
 
            sendDic=@{
                      @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                    //  @"linkMan":filterStr(nameTxt.text),
                    //  @"tel":filterStr(phoneTxt.text),
                      @"province":filterStr(_citySelView.value),
                      @"city":filterStr(_countySelView.value),
                      @"area":filterStr(@""),
                    //  @"address":filterStr(addressDetailTxt.text)
                      };
        
        [DataRequest requestApiName:@"userCenter_addAddress" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
            
            if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                    showWarn(@"增加失败");
            }else{
                    showWarn(@"增加成功");
                [self.navigationController popToRootViewControllerAnimated:true];
//              [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                  CATransition *transition = [CATransition animation];
//                  transition.duration = 0.5;
//                  transition.type = kCATransitionMoveIn;
//                  transition.subtype = kCATransitionFromLeft;
//                  [self.navigationController.view.layer addAnimation:transition forKey:nil];
//                  [self.navigationController pushViewController:[[ALTabBarViewController alloc]init] animated:true];
//              }];
             
            }
        } failedBlock:^(id failContent) {
            showFail(failContent);
        } reloginBlock:^(id reloginContent) {
        }];
    }];
    [self.contentView addSubview:okBtn];
}



@end
