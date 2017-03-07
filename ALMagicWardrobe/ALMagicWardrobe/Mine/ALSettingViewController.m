//
//  ALSettingViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALSettingViewController.h"
#import "ALAboutMeViewController.h"
#import "AlGiveAdvanceViewController.h"
#import "ALHelpViewController.h"
#define ALSetingCellHeight (96/2)
@interface ALSettingViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate>
@end

@implementation ALSettingViewController{
    NSArray *_leftTitArr;
    NSArray *_leftImageArr;
    ALComView *_footView;
    NSString *_trackViewUrl1;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"设置"];
    
    _leftTitArr=@[@"版本信息",@"给我好评",@"意见反馈",@"联系我们",@"清除缓存",@"关于我们"];
  _leftImageArr=@[@"setting_icon01",@"setting_icon02",@"setting_icon03",@"setting_icon05",@"setting_icon06",@"setting_icon07"];
    
    _footView=[[ALComView alloc]
               initWithFrame:CGRectMake(0, 0, kScreenWidth, 200/2+60/2)];
    
    ALButton *lognOutBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [lognOutBtn setFrame:CGRectMake((kScreenWidth-470/2)/2, 200/2, 470/2, 60/2)];
    [lognOutBtn setBackgroundColor:[UIColor clearColor]];
    [lognOutBtn.layer setCornerRadius:2.0f];
    [lognOutBtn setBackgroundImage:[UIImage imageNamed:@"bg04"] forState:UIControlStateNormal];
    [lognOutBtn setTitle:@"退出账号" forState:UIControlStateNormal];
    [lognOutBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [lognOutBtn setTheBtnClickBlock:^(id sender){
        NSDictionary *sendDic=@{
                                @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                                };
        [DataRequest requestApiName:@"userCenter_logout"
                          andParams:sendDic
                             andMethod:Get_type
                       successBlcok:^(id sucContent) {
                           showWarn(@"退出成功");
                           [[ALLoginUserManager sharedInstance] userInfoClean];
                           [self.navigationController popViewControllerAnimated:YES];
        } failedBlock:^(id failContent) {
            showFail(failContent);
        } reloginBlock:^(id reloginContent) {
        }];
    }];
    [_footView addSubview:lognOutBtn];
    
    UITableView * tableView = [[UITableView alloc]
                               initWithFrame:CGRectMake(0,
                                                        0,
                                                        kScreenWidth,
                                                        kContentViewHeight+69)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.view setBackgroundColor:AL_RGB(244, 244, 244)];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:tableView];
    self.contentView.backgroundColor =  HEX(@"#efebe8");
    tableView.tableFooterView = _footView;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _leftTitArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96/2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"setting222";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:identifier];
        
        ALImageView *leftImgView = [[ALImageView alloc]
                                    initWithFrame:(CGRect){26/2,(96/2-33)/2,33,33}];
        leftImgView.tag=1102;
        [cell addSubview:leftImgView];
        
        ALLabel *label = [[ALLabel alloc]
                              initWithFrame:(CGRect){leftImgView.right+5,(96/2-24)/2,200/2,24}
                              BoldFont:14 BGColor:RGB_BG_Clear
                              FontColor:colorByStr(@"#656565")];
        [label setTag:1100];
        [cell addSubview:label];
        
        label = [[ALLabel alloc]
                 initWithFrame:(CGRect){label.right+5,(ALSetingCellHeight-24)/2,cell.width-label.right-5-20-10,24}
                 BoldFont:14
                 BGColor:RGB_BG_Clear
                 FontColor:colorByStr(@"#9A9A9A")];
        [label setTextAlignment:NSTextAlignmentRight];
        [label setTag:1101];
        [cell addSubview:label];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        ALImageView *nextImgView = [[ALImageView alloc]
                                    initWithFrame:(CGRect){kScreenWidth - 20/2-20,(ALSetingCellHeight-20)/2,20,20}];
        [nextImgView setImage:Img(@"icon_next", @"png")];
        [cell addSubview:nextImgView];
        
        UIView *lineView = [[UIView alloc]
                            initWithFrame:CGRectMake(0, 96/2-.5f, kScreenWidth, .5f)];
        [lineView setBackgroundColor:AL_RGB(127,120,113)];
        [cell addSubview:lineView];
    }
    ALImageView *leftImgeView = (ALImageView *)[cell viewWithTag:1102];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1100];
    UILabel *dataLabel = (UILabel *)[cell viewWithTag:1101];
    [dataLabel setText:@""];
    if (indexPath.row==0) {
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
        [dataLabel setText:[NSString stringWithFormat:@"v%@",currentVersion]];
    }
    
    if (indexPath.row==3) {
        [dataLabel setText:getTxt(@"UsPhone")];
    }
    [nameLabel setText:_leftTitArr[indexPath.row]];
    leftImgeView.image = [UIImage imageNamed:_leftImageArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
          //  [self checkVesion];
        }
            break;
        case 1: //去评价
        {
            NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",getTxt(@"AppleId")];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
            break;
        case 2:
        {
            //意见反馈
            AlGiveAdvanceViewController *theAboutMeCtrl=[[AlGiveAdvanceViewController alloc] init];
            [self.navigationController pushViewController:theAboutMeCtrl animated:YES];
        }
            break;
//        case 3:
//        {
//            //帮助中心
//            ALHelpViewController *theAboutMeCtrl=[[ALHelpViewController alloc] init];
//            [self.navigationController pushViewController:theAboutMeCtrl animated:YES];
//        }
//            break;
        case 3:
        {
            ALAlertView *alterView = [[ALAlertView alloc]
                                      initWithTitle:getTxt(@"UsPhone")
                                      message:@"您确定要拨打此电话吗?"
                                      delegate:self
                                      cancelButtonTitle:@"确认"
                                      otherButtonTitles:@"取消", nil];
            [alterView show];
        }
            break;
        case 4:
        {
            dispatch_async(
                           dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                           , ^{
                               NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                               
                               NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                               for (NSString *p in files) {
                                   NSError *error;
                                   NSString *path = [cachPath stringByAppendingPathComponent:p];
                                   if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                                       [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                                   }
                               }
                               [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
        }
            break;
        case 5:
        {
            //关于我们
            ALAboutMeViewController *theAboutMeCtrl=[[ALAboutMeViewController alloc] init];
            [self.navigationController pushViewController:theAboutMeCtrl animated:YES];
        }
            break;

        default:
            break;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1001) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_trackViewUrl1]];
        }
    }else{
    if (buttonIndex==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",getTxt(@"UsPhone")]]];
    }
    }
}

-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
    showWarn(@"清理成功");
}
#pragma mark 检测软件更新
#pragma mark -
-(void)checkVesion{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",getTxt(@"AppleId")]]];
    [request setHTTPMethod:@"GET"];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:nil];
    
    NSString *latestVersion = [jsonData objectForKey:@"version"];
    _trackViewUrl1 = [jsonData objectForKey:@"trackViewUrl"];//地址trackViewUrl
    NSString *trackName = [jsonData objectForKey:@"trackName"];//trackName
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    double doubleCurrentVersion = [currentVersion doubleValue];
    
    if (doubleCurrentVersion < [latestVersion doubleValue]) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:trackName
                                           message:@"有新版本，是否升级！"
                                          delegate: self
                                 cancelButtonTitle:@"取消"
                                 otherButtonTitles: @"升级", nil];
        alert.tag = 1001;
        [alert show];
    }
    else{
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:trackName
                                           message:@"暂无新版本"
                                          delegate: nil
                                 cancelButtonTitle:@"好的"
                                 otherButtonTitles: nil, nil];
        [alert show];
    }
}
@end