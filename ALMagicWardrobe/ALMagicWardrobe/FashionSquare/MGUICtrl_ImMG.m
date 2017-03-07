//
//  MHUICtrl_ImMG.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/6/28.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUICtrl_ImMG.h"

@interface MGUICtrl_ImMG ()

@end

@implementation MGUICtrl_ImMG
{
    NSDictionary* dict_Im;
    UIWebView* webView_Im;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    webView_Im = [[UIWebView alloc]init];
    webView_Im.delegate = self;
    self.title = @"我是小魔";
    [self _loadGetSysConfigAndBlock:^{
        NSURLRequest* urlRequest = [[NSURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:dict_Im[@"configvalue"]]];
        showRequest;
        [webView_Im loadRequest:urlRequest];
    }];
    [self.contentView addSubview:webView_Im];
    // Do any additional setup after loading the view.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    hideRequest;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
      hideRequest;
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    webView_Im.frame = CGRectMake(0, 0, kScreenWidth, self.contentView.height);
}
-(void)_loadGetSysConfigAndBlock:(void(^)())theBlock
{
    NSDictionary *sendDic=@{@"configKey":@"xiaomourl"};
    [DataRequest requestApiName:@"fashionSquare_SysCongfig"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       @try {
                           @try {
                               //configdesc   configvalue
                               dict_Im=sucContent[@"body"][@"result"];
                               // array_MostS = arr;
                           }
                           @catch (NSException *exception) {
                           }
                           @finally {
                           }
                       }
                       @catch (NSException *exception) {
                       }
                       @finally {
                           
                       }
                       if (theBlock)
                       {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
