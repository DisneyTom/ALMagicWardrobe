//
//  ALMagicAddressAddOrSetViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicAddressAddOrSetViewController.h"
#import "JSONKit.h"
#import "ALTextView.h"

@interface ALMagicAddressAddOrSetViewController ()
{
    BOOL _isEditOrAddAddress;//yes 修改地址
    ALSelectView *_citySelView;
    ALSelectView *_countySelView;
    NSArray *_provinces;
}
@end

@implementation ALMagicAddressAddOrSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.addRessModel&&[self.addRessModel.province length]>0) { //修改
        [self setTitle:@"修改地址"];
        _isEditOrAddAddress = YES;
    }else{
        [self setTitle:@"增加地址"];
        _isEditOrAddAddress = NO;
    }
    
    [self _initData];
    [self _initView];
}

-(void)_initData{
}

-(void)castPersonProvinSelBtnPressed{
    
    int row =0;
    for (int i=0; i<_provinces.count; i++) {
        if ([_provinces[i][@"state"] isEqualToString:_citySelView.value]) {
            row = i;
            break;
        }
    }
    NSArray* cities = [[_provinces objectAtIndex:row] objectForKey:@"cities"];
    [_countySelView setOptions:cities];
    _citySelView.selectedFont = [UIFont systemFontOfSize:14];
     _countySelView.selectedFont = [UIFont systemFontOfSize:14];
    [_countySelView setValue:cities[0]];
   
    
}
-(void)_initView{
    
    _citySelView=[[ALSelectView alloc]
                  initWithFrame:CGRectMake(80/2, 50/2, 190/2, 66/2)
                  img:[UIImage imageNamed:@"province_city_bg.png"]];
    [_citySelView setSelectType:OcnSelectTypeNormal];
    [_citySelView addTarget:self forVauleChangedaction:@selector(castPersonProvinSelBtnPressed)];
    
    _provinces = [[NSArray alloc]
                  initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    NSArray*cities = [[_provinces objectAtIndex:0] objectForKey:@"cities"];
    
    
    NSMutableArray *proviceAray  = [NSMutableArray arrayWithCapacity:2];
    for (int i=0; i<_provinces.count; i++) {
        [proviceAray addObject:_provinces[i][@"state"]];
    }
    _citySelView.selectedFont = [UIFont systemFontOfSize:14];
    [_citySelView setOptions:proviceAray];
    [_citySelView setValue:@"选择地区"];
    [self.contentView addSubview:_citySelView];
    
    _countySelView=[[ALSelectView alloc] initWithFrame:CGRectMake(_citySelView.left, _citySelView.bottom+32/2, _citySelView.width, _citySelView.height) img:[UIImage imageNamed:@"province_city_bg.png"]];
     _countySelView.selectedFont = [UIFont systemFontOfSize:14];
    [_countySelView setSelectType:OcnSelectTypeNormal];
    [_countySelView setOptions:cities];
   
    [self.contentView addSubview:_countySelView];
    
    UIView *textBack = [[UIView alloc] initWithFrame:CGRectMake(_countySelView.left, _countySelView.bottom+32/2, (kScreenWidth-_countySelView.left*2), _countySelView.height*2)];
    [textBack setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:textBack];
    
    ALTextView *addressDetailTxt=[[ALTextView alloc] initWithFrame:CGRectMake(_countySelView.left + 2, _countySelView.bottom+32/2, (kScreenWidth-_countySelView.left*2), _countySelView.height*2)];
    [addressDetailTxt setBackgroundColor:[UIColor whiteColor]];
    [addressDetailTxt setPlaceholder:@"详细地址"];
    [addressDetailTxt setFont:[UIFont systemFontOfSize:14]];
//    [addressDetailTxt setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [self.contentView addSubview:addressDetailTxt];
    
    
    //联系人
    UIView *linkBack = [[UIView alloc] initWithFrame:CGRectMake(textBack.left, textBack.bottom+32/2, textBack.frame.size.width, textBack.height/2)];
    [linkBack setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:linkBack];
    
    ALTextField *nameTxt=[[ALTextField alloc] initWithFrame:CGRectMake(textBack.left + 9, addressDetailTxt.bottom+32/2,addressDetailTxt.frame.size.width, addressDetailTxt.height/2)];
    [nameTxt setBackgroundColor:[UIColor whiteColor]];
    [nameTxt setPlaceholder:@"联系人"];
    [nameTxt setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:nameTxt];
    
    [nameTxt setPlaceColor:addressDetailTxt.placeholderColor];
    
    //联系电话
    UIView *phoneBack = [[UIView alloc] initWithFrame:CGRectMake(linkBack.left, linkBack.bottom+32/2, (kScreenWidth-linkBack.left*2), linkBack.height)];
    [phoneBack setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:phoneBack];

    
    ALTextField *phoneTxt=[[ALTextField alloc] initWithFrame:CGRectMake(nameTxt.left, nameTxt.bottom+32/2, (kScreenWidth-linkBack.left*2), nameTxt.height)];
    [phoneTxt setBackgroundColor:[UIColor whiteColor]];
    [phoneTxt setPlaceholder:@"联系电话"];
    [phoneTxt setKeyboardType:UIKeyboardTypePhonePad];
    [phoneTxt setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:phoneTxt];
    [phoneTxt setPlaceColor:addressDetailTxt.placeholderColor];
    
    if (_isEditOrAddAddress) {
        if (MBNonEmptyString(_addRessModel.province).length>0) {
            [_citySelView setValue:_addRessModel.province];
        }
        if (MBNonEmptyString(_addRessModel.city).length>0) {
            [_countySelView setValue:_addRessModel.city];
        }
        if (MBNonEmptyString(_addRessModel.tel).length>0) {
            [phoneTxt setText:_addRessModel.tel];
        }
        if (MBNonEmptyString(_addRessModel.linkman).length>0) {
            [nameTxt setText:_addRessModel.linkman];
        }
        if (MBNonEmptyString(_addRessModel.address).length>0) {
            [addressDetailTxt setText:_addRessModel.address];
        }
    }
    ALButton *okBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake(40, 820/2, 240, 60/2)];
    [okBtn setBackgroundImage:[ALImage imageNamed:@"bg04"] forState:UIControlStateNormal];
    [okBtn setTitle:@"确认" forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [okBtn setTheBtnClickBlock:^(id sender){
        
        if (nameTxt.text.length <= 0)
        {
            showWarn(@"请填写联系人!");
            return;
        }
        
        if (phoneTxt.text.length <= 0)
        {
            showWarn(@"请填写手机号码!");
            return;
        }
        
        if (addressDetailTxt.text.length <= 0)
        {
            showWarn(@"请填写详细地址!");
            return;
        }
        
        
        NSDictionary *sendDic = nil;
        if (_isEditOrAddAddress) {
            
            sendDic=@{
                      @"addressId":_addRessModel.addressId,
                      @"linkMan":filterStr(nameTxt.text),
                      @"tel":filterStr(phoneTxt.text),
                      @"province":filterStr(_citySelView.value),
                      @"city":filterStr(_countySelView.value),
                      @"area":filterStr(@""),
                      @"address":filterStr(addressDetailTxt.text)
                      };
            
        }else{
            sendDic=@{
                      @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                      @"linkMan":filterStr(nameTxt.text),
                      @"tel":filterStr(phoneTxt.text),
                      @"province":filterStr(_citySelView.value),
                      @"city":filterStr(_countySelView.value),
                      @"area":filterStr(@""),
                      @"address":filterStr(addressDetailTxt.text)
                      };
        }
        [DataRequest requestApiName:_isEditOrAddAddress?@"userCenter_updateAddress":@"userCenter_addAddress" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
            
            if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                
                if(_isEditOrAddAddress){
                    showWarn(@"修改失败");
                }else{
                    showWarn(@"增加失败");
                }
            }else{
                if(_isEditOrAddAddress){
                    showWarn(@"修改成功");
                }else{
                    showWarn(@"增加成功");
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failedBlock:^(id failContent) {
            showFail(failContent);
        } reloginBlock:^(id reloginContent) {
        }];
    }];
    [self.contentView addSubview:okBtn];
}



@end
