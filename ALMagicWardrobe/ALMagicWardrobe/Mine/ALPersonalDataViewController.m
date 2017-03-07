//
//  ALPersonalDataViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALPersonalDataViewController.h"
#import "ALPersonalDataCell.h"

#import "ALEditNicknameViewController.h"
#import "ALEditAddressViewController.h"
#import "ALPhoneBindViewController.h"
#import "ALEditPwdViewController.h"

@interface ALPersonalDataViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@end

@implementation ALPersonalDataViewController{
    NSDictionary *_personalDataDic;
    ALComView *_headView; //
    ALImageView * _headImageView;
    ALTableView *personDataTalbeView;
}
-(void)_initData{
    _personalDataDic=@{
                       @"nickname":MBNonEmptyString(self.theUserDetailModel.theUserModel.nickname),
                       @"address":MBNonEmptyString(self.theUserDetailModel.address),
                       @"phonebind":MBNonEmptyString(self.theUserDetailModel.theUserModel.usertel)
                       };
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor =  HEX(@"#efebe8");
    self.view.backgroundColor =  HEX(@"#efebe8");

    self.title = @"个人资料";
    __block ALPersonalDataViewController *theCtrl=self;

    [self _initData];
    
    _headView = [[ALComView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 359/2)];
    [_headView setCustemViewWithType:BothLine_type
                     andTopLineColor:RGB_Line_Gray
                  andBottomLineColor:RGB_Line_Gray];
    _headView.userInteractionEnabled = YES;
    _headView.backgroundColor = HEX(@"#e6c69f");
    [_headView setTheViewTouchuBlock:^(id sender){}];
    [self.contentView addSubview:_headView];
    
    _headImageView = [[ALImageView alloc]
                      initWithFrame:CGRectMake((kScreenWidth-96)/2, 71/2, 96, 96)];
    [_headImageView.layer setCornerRadius:(_headImageView.frame.size.height/2)];
    [_headImageView.layer setMasksToBounds:YES];
    [_headImageView setImageWithURL:[NSURL URLWithString:self.theUserDetailModel.theUserModel.userpic]
                   placeholderImage:[UIImage imageNamed:@"weidenglu.png"]];
    
    _headImageView.userInteractionEnabled = YES;
    [_headImageView setTheImageVimageTouchuBlock:^(id sender){
    
        UIActionSheet *sheet = [[UIActionSheet alloc]
                                initWithTitle:@"选择图片"
                                delegate:theCtrl
                                cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                otherButtonTitles:@"拍照",@"从相册选择", nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
        
    }];

    [_headView addSubview:_headImageView];

    
    personDataTalbeView=[[ALTableView alloc]
                                      initWithFrame:CGRectMake(0, 359/2, kScreenWidth, kContentViewHeight-359/2)];
    [personDataTalbeView setDataSource:self];
    [personDataTalbeView setDelegate:self];
    [self.contentView addSubview:personDataTalbeView];
    
    personDataTalbeView.showsVerticalScrollIndicator = NO;
    personDataTalbeView.backgroundView = nil;
    personDataTalbeView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (IOS7_OR_LATER) {
        [personDataTalbeView setSeparatorInset:UIEdgeInsetsZero];
    }
    personDataTalbeView.backgroundColor = [UIColor clearColor];
    [self setExtraCellLineHidden:personDataTalbeView];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if ([personDataTalbeView respondsToSelector:@selector(setSeparatorInset:)]) {
        [personDataTalbeView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([personDataTalbeView respondsToSelector:@selector(setLayoutMargins:)])  {
        [personDataTalbeView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}

#pragma mark -
#pragma mark ActionSheet deletage
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        [picker setDelegate:self];
        [picker setAllowsEditing:YES];//设置可编辑
        [picker setSourceType:sourceType];
        [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    }
    if (buttonIndex == 1) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        [imagePicker setDelegate:self];
        [imagePicker setAllowsEditing:YES];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark 图片选择上传
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //添加图片，并对其进行压缩（0.0为最大压缩率，1.0为最小压缩率）
    NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
//    _headImageView.image = img;

    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"userCenter_updateUserpic"
                      andParams:sendDic
                         andImg:imageData
                   successBlcok:^(id sucContent) {
                       if (![MBNonEmptyStringNo_(sucContent[@"body"][@"result"]) isEqualToString:@""]) {
                           self.theUserDetailModel.theUserModel.userpic = MBNonEmptyStringNo_(sucContent[@"body"][@"result"]);
                           [_headImageView setImageWithURL:[NSURL URLWithString:self.theUserDetailModel.theUserModel.userpic] placeholderImage:nil];
                       }
                       [self dismissViewControllerAnimated:YES completion:nil];
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *theCellIdentify=@"personalDataCellIdentify";
        MBSetingPersonSubCell *theCell= [tableView dequeueReusableCellWithIdentifier:theCellIdentify];
    if (theCell == nil) {
        theCell = [[MBSetingPersonSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:theCellIdentify];
        theCell.accessoryType = UITableViewCellAccessoryNone;
        theCell.backgroundColor =  HEX(@"#efebe8");
        theCell.leftLabel.frame = CGRectMake(20, theCell.leftLabel.frame.origin.y, theCell.leftLabel.frame.size.width, theCell.leftLabel.frame.size.height);
        theCell.rightLabel.frame = CGRectMake(90, theCell.rightLabel.frame.origin.y, theCell.rightLabel.frame.size.width-50, theCell.rightLabel.frame.size.height);
        theCell.rightImage.frame = CGRectMake(kScreenWidth-27-5, (theCell.height-(26-6))/2, 27-7, 26-6);
        
    }
    theCell.rightLabel.font = [UIFont systemFontOfSize:12];
    theCell.leftLabel.font = [UIFont systemFontOfSize:14];
    theCell.selectionStyle = UITableViewCellSelectionStyleNone;
    theCell.rightImage.image = [UIImage imageNamed:@"icon_next"];
    if (indexPath.row==0) {
        [theCell setLeft:@"昵称：" andRight:_personalDataDic[@"nickname"]];
    }
    else if (indexPath.row==1){
        [theCell setLeft:@"收货地址：" andRight:_personalDataDic[@"address"]];
        theCell.rightLabel.numberOfLines = 2;
        theCell.rightLabel.textAlignment = NSTextAlignmentRight;
//        theCell.rightLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    else if (indexPath.row==2){
        [theCell setLeft:@"手机绑定：" andRight:_personalDataDic[@"phonebind"]];
    }
    else if (indexPath.row==3){
        [theCell setLeft:@"修改密码：" andRight:nil];
    }
    else{
    }
    
    return theCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) { //修改昵称
        ALEditNicknameViewController *theEditNickNameCtrl=[[ALEditNicknameViewController alloc]
                                                           init];
        [theEditNickNameCtrl editName:_personalDataDic[@"nickname"]
                              andBack:^(NSString *newNickname) {
                                  
                                  [[ALLoginUserManager sharedInstance] getUserInfo:[[ALLoginUserManager sharedInstance] getUserId] andBack:^(ALUserDetailModel *theUserDetailInfo) {
                                      self.theUserDetailModel=theUserDetailInfo;
                                      _personalDataDic=@{
                                                         @"nickname":MBNonEmptyString(self.theUserDetailModel.theUserModel.nickname),
                                                         @"address":MBNonEmptyString(self.theUserDetailModel.address),
                                                         @"phonebind":MBNonEmptyString(self.theUserDetailModel.theUserModel.usertel)
                                                         };
                                      [personDataTalbeView reloadData];

                                  } andReLoad:YES];
                                  
        }];
        [self.navigationController pushViewController:theEditNickNameCtrl animated:YES];
    }
    else if (indexPath.row==1){ //修改地址
        ALEditAddressViewController *theEditAddressCtrl=[[ALEditAddressViewController alloc] init];
        [theEditAddressCtrl setTheBackBlock:^(id sender){
            [[ALLoginUserManager sharedInstance] getUserInfo:[[ALLoginUserManager sharedInstance] getUserId] andBack:^(ALUserDetailModel *theUserDetailInfo) {
                self.theUserDetailModel=theUserDetailInfo;
                _personalDataDic=@{
                                   @"nickname":MBNonEmptyString(self.theUserDetailModel.theUserModel.nickname),
                                   @"address":MBNonEmptyString(self.theUserDetailModel.address),
                                   @"phonebind":MBNonEmptyString(self.theUserDetailModel.theUserModel.usertel)
                                   };
                [personDataTalbeView reloadData];
                
            } andReLoad:YES];
        }];
        [self.navigationController pushViewController:theEditAddressCtrl animated:YES];
    }
    else if (indexPath.row==2){ //修该手机绑定
        ALPhoneBindViewController *thePhonBindCtrl=[[ALPhoneBindViewController alloc] init];
        [self.navigationController pushViewController:thePhonBindCtrl animated:YES];
    }
    else if (indexPath.row==3){ //修改密码
        ALEditPwdViewController *thePwdCtrl=[[ALEditPwdViewController alloc] init];
        [self.navigationController pushViewController:thePwdCtrl animated:YES];
    }
    else{
    
    }
}
@end
