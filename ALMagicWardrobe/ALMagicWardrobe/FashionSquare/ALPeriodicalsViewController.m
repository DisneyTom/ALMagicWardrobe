//
//  ALPeriodicalsViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALPeriodicalsViewController.h"
#import "ALPeriodicalsModel.h"
#import "ALClothsModel.h"
#import "UIKit+AFNetworking.h"
#import "ALClothesDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "URLCache.h"

@interface ALPeriodicalsViewController ()
<UIWebViewDelegate>
@end

@implementation ALPeriodicalsViewController{
    NSMutableArray *_listClothesArr;
    ALPeriodicalsModel *_periodicalsModel;
    UIWebView *webView;
    float _orginY;
    UILabel *_titleLbl;
    NSMutableArray *_btnArr;
    ALButton *theBtn_;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    hideRequest;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  __block ALPeriodicalsViewController *theCtrl=self;
    
    [self setTitle:@"时尚期刊"];
    //    URLCache *sharedCache = [[URLCache alloc] initWithMemoryCapacity:1024 * 1024 diskCapacity:0 diskPath:nil];
    //    [NSURLCache setSharedURLCache:sharedCache];
    
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    [self _initData];
    
    _btnArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self _loadPeriodicalDetailAndBlock:^{
        [self _initView];
    }];
}
-(void)_initData{
    _orginY=0;
    _listClothesArr=[NSMutableArray array];
}
-(void)_initView{
    
    //colorByStr(@"#988967")
    //标题size
    CGSize titleSize=[ALComAction getSizeByStr:_periodicalsModel.title
                                       andFont:[UIFont systemFontOfSize:16]
                                       andRect:CGSizeMake(kScreenWidth-20, 0)];
    
    ALLabel *titLbl=[[ALLabel alloc]
                     initWithFrame:CGRectMake(10, 5, kScreenWidth-20, titleSize.height)
                     andColor:AL_RGB(183, 148, 127)
                     andFontNum:16];
    [titLbl setTextAlignment:NSTextAlignmentLeft];
    titLbl.numberOfLines = 0.f;
    [titLbl setText:_periodicalsModel.title];
    [self.contentView addSubview:titLbl];
    _orginY=titLbl.bottom+5;
    if (titLbl.height <= 20)
    {
        [titLbl setTextAlignment:NSTextAlignmentCenter];
    }
    
    
    UIImageView *mainImageView=[[UIImageView alloc]
                                initWithFrame:CGRectMake(10, _orginY, kScreenWidth-20, 120)];
    [mainImageView setImageWithURL:[NSURL URLWithString:_periodicalsModel.mainImage]
                  placeholderImage:nil];
    [self.contentView addSubview:mainImageView];
    _orginY=mainImageView.bottom+10;
    
    CGSize size=[ALComAction getSizeByStr:_periodicalsModel.lead
                                  andFont:[UIFont systemFontOfSize:12]
                                  andRect:CGSizeMake(kScreenWidth-20, 0)];
    ALLabel *leadLbl=[[ALLabel alloc]
                      initWithFrame:CGRectMake(10, _orginY, kScreenWidth-20, size.height)];
    [leadLbl setTextColor:AL_RGB(153, 153, 153)];
    [leadLbl setFont:[UIFont systemFontOfSize:12]];
    [leadLbl setText:_periodicalsModel.lead];
    [leadLbl setNumberOfLines:0];
    //    leadLbl.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:leadLbl];
    _orginY=leadLbl.bottom;
    NSInteger loopIndex = 0;
    NSInteger count = _listClothesArr.count;
    if (count < 3) {
        loopIndex = 0;
    }
    if (count > 3 && count < 6) {
        loopIndex = 3;
    }
    else
    {
        loopIndex = 6;
    }
    
    [_btnArr removeAllObjects];
    [_listClothesArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx < loopIndex)
        {
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [_btnArr addObject:btn];
            ALClothsModel *theModel=obj;
            [btn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:theModel.mainImage]
                 placeholderImage:LoadIngImg];
            [btn setTag:idx+1000];
            [btn setTheBtnClickBlock:^(id sender){
                ALButton *theBtn=sender;
                ALClothsModel *theModel=_listClothesArr[theBtn.tag-1000];
                ALClothesDetailViewController *theCtrl=[[ALClothesDetailViewController alloc] init];
                [theCtrl setFashionId:theModel.clothsId];
                theCtrl.clothsModel = theModel;
                [self.navigationController pushViewController:theCtrl animated:YES];
            }];
            [self.contentView addSubview:btn];
            
        }
    }];
    
    webView=[[UIWebView alloc]
             initWithFrame:CGRectMake(2, _orginY , kScreenWidth - 4, 300)];
    [webView loadHTMLString:_periodicalsModel.content baseURL:nil];
    [webView setDelegate:self];
    webView.scalesPageToFit = NO;
    webView.scrollView.scrollEnabled = NO;
    webView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:webView];
    webView.hidden = YES;
    
    _orginY = webView.bottom;
    _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.f, _orginY + 10, kScreenWidth - 20, 12)];
    _titleLbl.textAlignment = NSTextAlignmentLeft;
    _titleLbl.textColor = AL_RGB(199, 170, 151);
    _titleLbl.text = @"推荐服装:";
    _titleLbl.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_titleLbl];
    _titleLbl.hidden = YES;
    
    
}

#pragma mark loadData
#pragma mark -
-(void)_loadPeriodicalDetailAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"periodicalId":filterStr(self.periodicalsId),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"fashionSquare_periodicalDetail"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       @try {
                           NSArray *tempArr=sucContent[@"body"][@"result"][@"fashions"];
                           [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                               ALClothsModel *theModel=[ALClothsModel questionWithDict:obj];
                               [_listClothesArr addObject:theModel];
                           }];
                           NSDictionary *dic=sucContent[@"body"][@"result"][@"periodical"];
                           _periodicalsModel=[ALPeriodicalsModel questionWithDict:dic];
                           if ([sucContent[@"body"][@"result"][@"isCollected"]isEqualToString:@"Y"])
                           {
                                [theBtn_ setBackgroundImage:[ALImage imageNamed:@"icon_top_heart_on"] forState:UIControlStateNormal];
                           }
                           
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

//删除收藏

-(void)_userCenter_delCollectsAndBlock:(void(^)())theBlock{
    
    NSDictionary *sendDic=@{
                            @"periodcalId":filterStr(self.periodicalsId),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"userCenter_delCollects"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       
                       if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                           showWarn(@"删除收藏失败");
                           
                       }else{
                           showWarn(@"删除收藏成功");
                           
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}
//收藏
-(void)_addCollectionAndBlock:(void(^)())theBlock{
    if (![[ALLoginUserManager sharedInstance] loginCheck]) {
        [self toLoginAndBlock:^{
            [self _addCollectionAndBlock:theBlock];
        } andObj:self];
        return;
    }
    NSDictionary *sendDic=@{
                            @"periodcalId":filterStr(self.periodicalsId),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"userCenter_addCollects"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       
                       if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                           showWarn(@"收藏失败");
                           
                       }else{
                           showWarn(@"收藏成功");
                            [theBtn_ setBackgroundImage:[ALImage imageNamed:@"icon_top_heart_on"] forState:UIControlStateNormal];
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                       
                   }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    showRequest;
}

- (void)webViewDidFinishLoad:(UIWebView *)theWebView{
    
//    CGRect frame = theWebView.frame;
//    frame.size.width = 300;
//    frame.size.height = 1;
//    
//    //    wb.scrollView.scrollEnabled = NO;
//    theWebView.frame = frame;
//    frame.origin.x = 2;
//    frame.size.width = 320 - 4;
//    frame.size.height = theWebView.scrollView.contentSize.height;
    [webView sizeToFit];
 //   webView.frame = frame;
    _orginY = webView.bottom;
    webView.hidden = NO;
    webView.backgroundColor = [UIColor redColor];
    
    NSInteger loopIndex = 0;
    NSInteger count = _listClothesArr.count;
    CGFloat btnHeight = 0.f;
    if (count < 3) {
        loopIndex = 0;
        btnHeight = 0.f;
    }
    else if (count >= 3 && count < 6) {
        loopIndex = 3;
        btnHeight = 1.f;
    }
    else
    {
        loopIndex = 6;
        btnHeight = 2;
    }
    _titleLbl.frame = CGRectMake(10, _orginY+10 , kScreenWidth - 20, 12);
    _titleLbl.hidden = NO;
    //    _orginY = CGRectGetMaxY(_titleLbl.frame) + 10.f;
    _orginY = _titleLbl.bottom;
    float width=(kScreenWidth-30)/3;
    float height=800/4/2;
    [_btnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = obj;
        if (idx/3==0) {
            [btn setFrame:CGRectMake((width + 5)*idx + 10,_titleLbl.bottom+10, width, height)];
        }else if (idx/3==1){
            [btn setFrame:CGRectMake((width + 5)* (idx-3)+10, height*1+_titleLbl.bottom+10, width, height)];
        }
        _orginY= CGRectGetMaxY(btn.frame);
    }];
    [self.contentView setContentSize:CGSizeMake(320, _orginY+10 )];
    //    URLCache *sharedCache = (URLCache *)[NSURLCache sharedURLCache];
    //    [sharedCache saveInfo];
    hideRequest;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    hideRequest;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //    URLCache *sharedCache = (URLCache *)[NSURLCache sharedURLCache];
    //    [sharedCache removeAllCachedResponses];
}

@end
