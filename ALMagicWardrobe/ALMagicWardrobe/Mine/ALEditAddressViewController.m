//
//  ALEditAddressViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALEditAddressViewController.h"
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"
#import "ALMagicAddressAddOrSetViewController.h"
#import "ALMineAddressCell.h"

@interface ALEditAddressViewController ()
<UITableViewDataSource,UITableViewDelegate,MGSwipeTableCellDelegate>
{
    NSMutableArray *_addressArr;
    ALTableView *addressTableView;
    ALLabel *_showLabel;
    NSInteger _selIndex;
    ALButton *_defaultBtn;
    
    NSInteger _selectedIndexAddress;
}
@end

@implementation ALEditAddressViewController

//增加新地址
-(void)addNowAddress{
    ALMagicAddressAddOrSetViewController *theCtrl=[[ALMagicAddressAddOrSetViewController alloc] init];
    [self.navigationController pushViewController:theCtrl animated:YES];

}
-(void)_initData{
    _addressArr=[[NSMutableArray alloc] initWithCapacity:2];
    _selIndex=-1;
}
-(void)_initView{
    addressTableView=[[ALTableView alloc]
                                   initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentViewHeight-60)];
    [addressTableView setDataSource:self];
    [addressTableView setDelegate:self];
    [self.contentView addSubview:addressTableView];
    
    addressTableView.showsVerticalScrollIndicator = NO;
//    addressTableView.backgroundView = nil;
    addressTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (IOS7_OR_LATER) {
        [addressTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    addressTableView.backgroundColor =  HEX(@"#efebe8");
    [self setExtraCellLineHidden:addressTableView];
    [self.contentView addSubview:addressTableView];
    
    //保存
    _defaultBtn = [ALButton buttonWithType:UIButtonTypeCustom];
    [_defaultBtn setFrame:CGRectMake(40, self.view.size.height - 140, 240 , 30)];
    [_defaultBtn setTitle:@"设为默认地址" forState:0];
    [_defaultBtn setBackgroundImage:[UIImage imageNamed:@"bg04"] forState:UIControlStateNormal];
    _defaultBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_defaultBtn.layer setCornerRadius:3];
    if (self.isSelectedAddress)
    {
        [_defaultBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    __weak typeof(self) _self = self;
    [_defaultBtn setTheBtnClickBlock:^(id sender){
        if (_self.isSelectedAddress)
        {
            if (_self.theBlock) {
                _self.theBlock(_addressArr[_selectedIndexAddress]);
                [_self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            [_self _updateDefaultAddressAndBlock:^{
                if (_addressArr&&_addressArr.count>0) {
                    [_addressArr removeAllObjects];
                }
                [self _loadAddressListAndBlock:^{
                    [_addressArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        ALAddressModel *theModel=obj;
                        if ([theModel.isdefault isEqualToString:@"Y"]) {
                            _selIndex=idx;
                        }else{
                        }
                    }];
                    
                    if (_addressArr.count==0) {
                        addressTableView.hidden = YES;
                    }else{
                        addressTableView.hidden = NO;
                        [addressTableView  reloadData];
                    }
                }];
                if (self.theBackBlock) {
                    self.theBackBlock(self);
                }
            }];
        }
        

    }];
    [self.contentView addSubview:_defaultBtn];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentView.backgroundColor =  HEX(@"#efebe8");

    [self setTitle:@"地址"];
    
    __block ALEditAddressViewController * selfBlock = self;
    
    
    [self setViewWithType:rightBtn1_type
                  andView:^(id view) {
                      ALButton *btn=view;
                      [btn setImage:[ALImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
                  } andBackEvent:^(id sender) {
                      
                      [selfBlock addNowAddress];
                      
    }];
    
    UIColor *color = colorByStr(@"#75491F");
    _showLabel  = [[ALLabel alloc]
                   initWithFrame:CGRectMake(10, 170, kScreenWidth-20, 40)];
    _showLabel.textAlignment = NSTextAlignmentCenter;
    _showLabel.text = @"你还没有地址,增加一个";
    _showLabel.layer.masksToBounds = YES;
    _showLabel.layer.borderWidth = 1;
    _showLabel.layer.cornerRadius = 3;
    _showLabel.layer.borderColor = color.CGColor;
    _showLabel.textColor = color;
    _showLabel.font = [UIFont systemFontOfSize:15];
    
//    if ([[ALLoginUserManager sharedInstance] loginCheck]) {
//        [[ALLoginUserManager sharedInstance] getUserInfo:[[ALLoginUserManager sharedInstance] getUserId] andBack:^(ALUserDetailModel *theUserDetailInfo) {
//            
//            _showLabel.text = [NSString stringWithFormat:@"",theUserDetailInfo.theUserModel.nickname];
//        } andReLoad:NO];
//    }
//    
    [self.contentView addSubview:_showLabel];
    
    [self _initData];

    [self _initView];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if (_addressArr&&_addressArr.count>0) {
        [_addressArr removeAllObjects];
    }
    [self _loadAddressListAndBlock:^{
        if (_addressArr.count==0) {
            addressTableView.hidden = YES;
            _defaultBtn.hidden = YES;
        }else{
            addressTableView.hidden = NO;
            _defaultBtn.hidden = NO;

            [_addressArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALAddressModel *theModel=obj;
                if ([theModel.isdefault isEqualToString:@"Y"]) {
                    _selIndex=idx;
                }else{
                }
            }];
            
            [addressTableView  reloadData];
        }
    }];

    
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _addressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *addressCellIdentify=@"addressCellIdentify";
    
    ALMineAddressCell *theCell=[tableView dequeueReusableCellWithIdentifier:addressCellIdentify];
    if (theCell==nil) {
        theCell=[[ALMineAddressCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:addressCellIdentify];
        theCell.backgroundColor =  HEX(@"#efebe8");
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [theCell setTheBlock:^(BOOL sel){
            _selIndex=indexPath.row;
            [tableView reloadData];
        }];
        
        [theCell setImages:@[@"address_edit",@"address_delete"]
                    orTits:nil
                   andBack:^(NSInteger index) {
                       if (index==0) { //编辑
                           ALMagicAddressAddOrSetViewController *theEditAresCtrl=[[ALMagicAddressAddOrSetViewController alloc] init];
                           ALAddressModel *model=_addressArr[indexPath.row];
                           theEditAresCtrl.addRessModel = model;
                           [self.navigationController pushViewController:theEditAresCtrl animated:YES];
                       }else if (index==1){ //删除
                           ALAddressModel *theModel=_addressArr[indexPath.row];
                           
                           NSDictionary *sendDic=@{@"addressId":MBNonEmptyString(theModel.addressId)};
                           [DataRequest
                            requestApiName:@"userCenter_delAddress"
                            andParams:sendDic
                            andMethod:Get_type
                            successBlcok:^(id sucContent) {
                                if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                                    showWarn(@"删除地址失败");
                                    
                                }else{
                                    showWarn(@"删除地址成功");
                                    ALAddressModel *model=_addressArr[indexPath.row];
                                    [_addressArr removeObject:model];
                                    [addressTableView reloadData];
                                }
                            } failedBlock:^(id failContent) {
                                showFail(failContent);
                            } reloginBlock:^(id reloginContent) {
                            }];
                       }
                   }];
    }
    ALAddressModel *theModel=_addressArr[indexPath.row];
    if (indexPath.row==_selIndex) {
        [theCell setSel:YES];
        theModel.isdefault=@"Y";
    }else{
        [theCell setSel:NO];
        theModel.isdefault=@"N";
    }
    [theCell setModel:theModel];
    
    return theCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectedIndexAddress = indexPath.row;
    _selIndex = _selectedIndexAddress;
     ALAddressModel *theModel=_addressArr[_selIndex];
    [tableView reloadData];
}
#pragma mark loadData
#pragma mark -
-(void)_loadAddressListAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    
    [DataRequest requestApiName:@"userCenter_getUserAddress" andParams:sendDic andMethod:Get_type successBlcok:^(id sucContent) {
        
        @try {
            NSArray *tempArr=sucContent[@"body"][@"result"];
            [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALAddressModel *theModel=[ALAddressModel questionWithDict:obj];
                [_addressArr addObject:theModel];
            }];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
       
        if (theBlock) {
            theBlock();
        }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}
//更新默认地址
-(void)_updateDefaultAddressAndBlock:(void(^)())theBlock{
    if (!(_selIndex>=0)) {
        return;
    }
    ALAddressModel *theModel=_addressArr[_selIndex];
    
    NSDictionary *sendDic=@{
                            @"addressId":filterStr(theModel.addressId),
                            @"userId":[[ALLoginUserManager sharedInstance] getUserId]
                            };
    [DataRequest requestApiName:@"userCenter_updateDefaultAddress" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
        showWarn(@"设置成功");
        if (theBlock) {
            theBlock();
        }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    } andShowLoad:YES];
}
@end
