//
//  ALSystemMessageDetailViewController.m
//  ALMagicWardrobe
//
//  Created by wang on 3/22/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import "ALSystemMessageDetailViewController.h"
#import "ALMagicRecordViewController.h"
//#import "ALMagicBagViewController.h"
#import "ALMagicShowBigShowViewController.h"
#import "UIButton+WebCache.h"

static const int tag = 10000;

@interface ALSystemMessageDetailViewController ()
{
    NSMutableArray *_imageArray;
    
    NSDictionary *_dict;
}
@end

@implementation ALSystemMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray = [[NSMutableArray alloc]initWithCapacity:2];
    // Do any additional setup after loading the view.
    self.title = @"异常服装确认";
    __block ALSystemMessageDetailViewController *system = self;
    
    [self _loadSysmagicBag_wornConfirmMessageAndBlock:^{
        [system magicAdd];
    }];
    
}
-(void)_loadSysmagicBag_wornConfirmMessageAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"expressId":_expressId,
                            };
    [DataRequest requestApiName:@"magicBag_wornConfirm" andParams:sendDic andMethod:Get_type successBlcok:^(id sucContent) {
        
        @try {
            _dict = sucContent;
            
            NSArray *tempArr=sucContent[@"body"][@"result"][@"wornImages"];
            [_imageArray  addObjectsFromArray:tempArr];
            
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

/**
 *  服装异常
 */
-(void)magicAdd{
    
    self.contentView.backgroundColor = AL_RGB(240, 235, 233);
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 110)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topView];
    
    
    ALLabel *oneLabel=[[ALLabel alloc]
                       initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 72)];
    [topView addSubview:oneLabel];
    NSNumber *num = _dict[@"body"][@"result"][@"deduction"];
    NSString *text = [NSString stringWithFormat:@"%d",[num intValue]];
    NSString *tmp = [NSString stringWithFormat:@"抱歉通知，我们在收到魔法包 %@ 后，发现了异常情况，魔法值将将少%@。\n请在3天内确认或联系客服，3天后即视为默认.", _expressId, text];
    oneLabel.text = tmp;
    oneLabel.numberOfLines =0;
    oneLabel.font = [UIFont systemFontOfSize:15];
    oneLabel.textColor = AL_RGB(74, 74, 74);
    
    
    ALImageView *imageVIew = [[ALImageView alloc]initWithFrame:CGRectMake(10, 80, 298, 26)];
    imageVIew.image = [UIImage imageNamed:@"excalmatory_mark.png"];
    [topView addSubview:imageVIew];
    
    NSInteger imageCount = _imageArray.count;
    NSInteger indexAbout = imageCount/3;
    if (_imageArray.count%3>0) {
        indexAbout = indexAbout+1;
    }
    
    CGFloat btmY = CGRectGetMaxY(topView.frame) + 5.f;
    UIView *btm = [[UIView alloc] initWithFrame:CGRectMake(0.f, btmY, kScreenWidth, 0.f)];
    btm.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:btm];
    
    CGFloat space = 5.f;
    CGFloat leftSpace = 35.f;
    if (imageCount < 3 && imageCount > 0)
    {
        leftSpace = (kScreenWidth - 80 * imageCount - space * (imageCount - 1))/2;
    }
//    CGFloat originY = 0.f;
    for (int i=0; i<indexAbout; i++) {
        for (int j=0; j<3; j++) {
            NSInteger index = 3*i+j;
            if (index < imageCount)
            {
                UIButton *imageVIew = [[UIButton alloc]initWithFrame:CGRectMake(leftSpace+ (80 + space) * j, 6+(80 + 3)*i, 80, 80)];
                
//                [imageVIew setImageWithURL:[NSURL URLWithString:_imageArray[index]] placeholderImage:LoadIngImg];
                [imageVIew setImageWithURL:[NSURL URLWithString:_imageArray[index]] forState:UIControlStateNormal placeholderImage:LoadIngImg];
                imageVIew.tag = tag + index;
                [imageVIew addTarget:self action:@selector(imgBtn:) forControlEvents:UIControlEventTouchUpInside];
                [btm addSubview:imageVIew];
//                originY = CGRectGetMaxY(imageVIew.frame) + 6;
            }
        }
    }
    btm.frame = CGRectMake(0.f, btmY, kScreenWidth, indexAbout * 80 + 12 + (indexAbout - 1) * 5);
    
    
    CGFloat btnY = CGRectGetMaxY(btm.frame) + 15.f;
    ALButton *sizeBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [sizeBtn setFrame:CGRectMake(40,btnY,240,30)];
    [sizeBtn setBackgroundImage:[ALImage imageNamed:@"bg04"] forState:UIControlStateNormal];
    [sizeBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sizeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sizeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [sizeBtn addTarget:self action:@selector(goMakeSure) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:sizeBtn];
    
    
    {
        ALButton *sizeBtn2=[ALButton buttonWithType:UIButtonTypeCustom];
        [sizeBtn2 setFrame:CGRectMake(40,sizeBtn.bottom + 10.f,240,30)];
        [sizeBtn2 setTitle:@"联系客服" forState:UIControlStateNormal];
        [sizeBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sizeBtn2.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [sizeBtn2 addTarget:self action:@selector(goMakeSureTel) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:sizeBtn2];
        [sizeBtn2 setBackgroundImage:[ALImage imageNamed:@"btn_magic_room"] forState:UIControlStateHighlighted];
        [sizeBtn2 setBackgroundImage:[ALImage imageNamed:@"btn_wardrobe"] forState:UIControlStateNormal];
    }
    
}
-(void)goMakeSure{
    
    NSDictionary *sendDic=@{
                            @"expressId":_expressId,
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            };
    [DataRequest requestApiName:@"magicBag_confirmWorn" andParams:sendDic andMethod:Get_type successBlcok:^(id sucContent) {
        
        
        @try {
            
            if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                showWarn(@"确认失败");
                
            }else{
                showWarn(@"确认成功");
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}

-(void)goMakeSureTel{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://40000000000"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",getTxt(@"UsPhone")]]];
}

- (void)imgBtn:(UIButton *)btn
{
    NSInteger index = btn.tag - tag;
    if (index < _imageArray.count)
    {
        ALMagicShowModel *theModel=[[ALMagicShowModel alloc] init];
        theModel.imageurls = [_imageArray componentsJoinedByString:@";"];
        ALMagicShowBigShowViewController *theCtrl=[[ALMagicShowBigShowViewController alloc] init];
        [theCtrl setTheModel:theModel];
        [theCtrl setCurIndex:index];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }

}
@end
